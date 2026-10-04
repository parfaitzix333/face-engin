"""
api/main.py
===========

API FastAPI pour la reconnaissance faciale ARSP.

Endpoints :
  GET  /health          → vérifie que l'API tourne
  POST /recognize       → reconnaît un visage dans une image
  GET  /employees       → liste les employés enrôlés
"""

from fastapi import FastAPI, File, UploadFile, HTTPException,Form
from fastapi.responses import JSONResponse
import numpy as np
import cv2

from recognition_mysql import FaceRecognizerMySQL

from typing import List
import pymysql

from face_core import FaceCore
from db_config import DB_CONFIG


# ==================================================
# Initialisation
# ==================================================

app = FastAPI(
    title="ARSP Face Recognition API",
    description="API de reconnaissance faciale pour le pointage ARSP",
    version="0.1.0",
)

# Charge le modèle UNE SEULE FOIS au démarrage
print("[API] Initialisation du moteur de reconnaissance...")
recognizer = FaceRecognizerMySQL(seuil=0.40)
recognizer.load_employees()
print(f"[API] {len(recognizer.employees)} employés chargés.")


# ==================================================
# Endpoints
# ==================================================

@app.get("/health")
def health():
    """Vérifie que l'API tourne."""
    return {
        "status": "ok",
        "employes_charges": len(recognizer.employees),
        "seuil": recognizer.seuil,
    }


@app.get("/employees")
def list_employees():
    """Retourne la liste des employés enrôlés."""
    return [
        {
            "employe_id": emp_id,
            "nom": info["nom"],
            "matricule": info["matricule"],
            "nb_embeddings": info["matrix"].shape[0],
        }
        for emp_id, info in sorted(recognizer.employees.items())
    ]


@app.post("/recognize")
async def recognize(file: UploadFile = File(...)):
    """
    Reconnaît un visage dans une image uploadée.

    Retour :
    {
        "employe_id": int,
        "nom": str,
        "matricule": str,
        "score": float,
        "reconnu": bool,
        "bbox": [x1, y1, x2, y2]
    }
    """
    # --- Validation ---
    if not file.content_type.startswith("image/"):
        raise HTTPException(
            status_code=400,
            detail=f"Fichier non-image : {file.content_type}",
        )

    # --- Lecture ---
    try:
        contents = await file.read()
        arr = np.frombuffer(contents, np.uint8)
        img = cv2.imdecode(arr, cv2.IMREAD_COLOR)

        if img is None:
            raise ValueError("Image illisible")

    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Erreur de lecture : {e}")

    # --- Reconnaissance ---
    result = recognizer.recognize_image(img)

    if result is None:
        raise HTTPException(
            status_code=422,
            detail="Aucun visage détecté dans l'image",
        )

    return {
        "employe_id": result.employe_id,
        "nom":        result.nom,
        "matricule":  result.matricule,
        "score":      round(result.score, 5),
        "reconnu":    result.reconnu,
        "bbox":       [int(v) for v in result.bbox],
    }




# Instance partagée du core (à initialiser au démarrage)
face_core = FaceCore()


@app.post("/enroll")
async def enroll(
    employe_id: int = Form(...),
    files: List[UploadFile] = File(...),
):
    """
    Enrôle un employé en stockant ses embeddings faciaux.
    
    - employe_id : ID de l'employé en base
    - files : 5 photos du visage (angles variés recommandés)
    """
    
    # --- 1. Validation ---
    if len(files) < 1:
        raise HTTPException(422, "Au moins une image est requise")
    
    if len(files) > 10:
        raise HTTPException(422, "Maximum 10 images acceptées")
    
    # --- 2. Connexion MySQL ---
    conn = pymysql.connect(**DB_CONFIG)
    
    try:
        # Vérifier que l'employé existe
        with conn.cursor() as cur:
            cur.execute(
                "SELECT nom, matricule FROM employes WHERE id = %s",
                (employe_id,)
            )
            row = cur.fetchone()
            if not row:
                raise HTTPException(404, f"Employé {employe_id} introuvable")
            nom, matricule = row
            
            # Récupérer l'année active
            cur.execute("SELECT id FROM annees WHERE statut='active' LIMIT 1")
            annee_row = cur.fetchone()
            if not annee_row:
                raise HTTPException(500, "Aucune année active en base")
            annee_id = annee_row[0]
        
        # --- 3. Extraire les embeddings ---
        embeddings = []
        details = []
        
        for i, file in enumerate(files, start=1):
            try:
                contents = await file.read()
                arr = np.frombuffer(contents, np.uint8)
                img = cv2.imdecode(arr, cv2.IMREAD_COLOR)
                
                if img is None:
                    raise ValueError(f"Image illisible")
                
                face = face_core.extract_from_image(img)
                
                if face is None:
                    raise HTTPException(
                        400,
                        f"Aucun visage détecté dans la photo {i} ({file.filename})"
                    )
                
                embeddings.append(face["embedding"])
                details.append({
                    "index": i,
                    "det_score": round(face["det_score"], 4),
                    "source": file.filename,
                })
                
            except HTTPException:
                raise
            except Exception as e:
                raise HTTPException(400, f"Erreur photo {i} : {str(e)}")
        
        # --- 4. Insertion en base ---
        with conn.cursor() as cur:
            # Supprimer les anciens embeddings de cet employé pour cette année
            cur.execute(
                "DELETE FROM face_templates WHERE employe_id=%s AND annee_id=%s",
                (employe_id, annee_id)
            )
            
            # Insérer les nouveaux
            for emb in embeddings:
                blob = emb.astype("<f4").tobytes()
                assert len(blob) == 2048, f"Taille invalide : {len(blob)}"
                
                cur.execute(
                    """
                    INSERT INTO face_templates
                        (employe_id, face_embedding, annee_id,
                         created_at, updated_at)
                    VALUES (%s, %s, %s, NOW(), NOW())
                    """,
                    (employe_id, blob, annee_id)
                )
        
        conn.commit()
        recognizer.reload_employee(employe_id)
        # --- 5. Réponse ---
        return {
            "employe_id": employe_id,
            "nom": nom,
            "matricule": matricule,
            "n_embeddings": len(embeddings),
            "annee_id": annee_id,
            "message": "Enrôlement réussi",
            "details": details,
        }
    
    except HTTPException:
        conn.rollback()
        raise
    except Exception as e:
        conn.rollback()
        raise HTTPException(500, f"Erreur serveur : {str(e)}")
    finally:
        conn.close()

# ==================================================
# Lancement (si exécuté directement)
# ==================================================

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8001)