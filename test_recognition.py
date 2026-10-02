"""
test_recognition.py
===================

Simule la reconnaissance : pour chaque image de test, on calcule
l'employé le plus probable, puis on applique le seuil.

Ne fait AUCUN apprentissage, AUCUN enrôlement.
C'est juste un test du pipeline de décision.
"""

import numpy as np
import cv2
from pathlib import Path

from insightface.app import FaceAnalysis


# ==================================================
# Configuration
# ==================================================

SEUIL = 0.40                        # seuil préliminaire
MODEL_NAME = "buffalo_l"
DET_SIZE = (640, 640)
CTX_ID = -1                         # -1 = CPU

EMBEDDINGS_DIR = Path("embeddings")
TEST_DIR       = Path("test_images/inconnus")


# ==================================================
# Initialisation (une seule fois)
# ==================================================

app = FaceAnalysis(name=MODEL_NAME)
app.prepare(ctx_id=CTX_ID, det_size=DET_SIZE)


# ==================================================
# Chargement des embeddings enrôlés
# ==================================================

def load_enrolled(root=EMBEDDINGS_DIR):
    """
    Retourne un dict :
      {employe_id: np.ndarray de shape (N, 512)}
    où N = nombre d'embeddings pour cet employé.
    """
    data = {}

    for emp_dir in sorted(root.glob("employee_*")):
        emp_id = int(emp_dir.name.split("_")[1])
        vectors = []

        for f in sorted(emp_dir.glob("embedding_*.npy")):
            vectors.append(np.load(f))

        # On empile en matrice (N, 512)
        data[emp_id] = np.stack(vectors)

    return data


# ==================================================
# Extraction de l'embedding requête
# ==================================================

def extract_query_embedding(image_path):
    """
    Retourne l'embedding normalisé du visage principal,
    ou None si aucun visage détecté.
    """
    img = cv2.imread(str(image_path))
    if img is None:
        raise ValueError(f"Lecture impossible : {image_path}")

    faces = app.get(img)

    if len(faces) == 0:
        return None

    # Si plusieurs visages : prendre le plus grand
    if len(faces) > 1:
        faces = sorted(
            faces,
            key=lambda f: (f.bbox[2] - f.bbox[0]) * (f.bbox[3] - f.bbox[1]),
            reverse=True,
        )

    emb = faces[0].embedding.astype(np.float32)
    norm = np.linalg.norm(emb)

    if norm == 0:
        return None

    return emb / norm


# ==================================================
# Reconnaissance
# ==================================================

def recognize(query_emb, enrolled):
    """
    Retourne :
      meilleur_employe_id, meilleur_score, tableau de tous les scores
    """
    scores = {}

    for emp_id, matrix in enrolled.items():
        # matrix : (N, 512)
        # query_emb : (512,)
        # produit scalaire -> (N,)
        sims = matrix @ query_emb
        # Score de cet employé = max sur ses 5 embeddings
        scores[emp_id] = float(sims.max())

    best_emp = max(scores, key=scores.get)
    best_score = scores[best_emp]

    return best_emp, best_score, scores


# ==================================================
# Programme principal
# ==================================================

if __name__ == "__main__":

    print("=" * 70)
    print("TEST DE RECONNAISSANCE")
    print("=" * 70)
    print(f"Seuil appliqué : {SEUIL}")

    # --- Chargement ---
    enrolled = load_enrolled()
    print(f"\nEmployés enrôlés : {sorted(enrolled.keys())}")
    for emp_id, mat in sorted(enrolled.items()):
        print(f"  Employé {emp_id} : {mat.shape[0]} embeddings")

    # --- Fichiers de test ---
    test_files = sorted(TEST_DIR.glob("*.jpeg"))
    print(f"\nImages à tester : {len(test_files)}")

    # --- Boucle ---
    for img_path in test_files:
        print("\n" + "-" * 70)
        print(f"📷 {img_path.name}")
        print("-" * 70)

        query_emb = extract_query_embedding(img_path)

        if query_emb is None:
            print("   ❌ Aucun visage détecté")
            continue

        best_emp, best_score, scores = recognize(query_emb, enrolled)

        # Détail des scores
        print("   Scores par employé :")
        for emp_id in sorted(scores):
            marker = "  ← meilleur" if emp_id == best_emp else ""
            print(f"     employé {emp_id} : {scores[emp_id]:.4f}{marker}")

        # Décision
        if best_score >= SEUIL:
            print(f"\n   ✅ RECONNU : employé {best_emp}   (score={best_score:.4f})")
        else:
            print(f"\n   ❌ INCONNU (meilleur score : {best_score:.4f} < {SEUIL})")