"""
api/main.py
===========

API FastAPI pour la reconnaissance faciale ARSP.

Endpoints :
  GET  /health          → vérifie que l'API tourne
  POST /recognize       → reconnaît un visage dans une image
  GET  /employees       → liste les employés enrôlés
"""

from fastapi import FastAPI, File, UploadFile, HTTPException
from fastapi.responses import JSONResponse
import numpy as np
import cv2

from recognition_mysql import FaceRecognizerMySQL


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


# ==================================================
# Lancement (si exécuté directement)
# ==================================================

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)