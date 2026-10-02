"""
enrollment.py
Prend les 5 photos d'un employé, extrait 5 embeddings ArcFace normalisés,
et les sauvegarde dans embeddings/employee_XXXXXX/.
"""

import numpy as np
import cv2
from pathlib import Path

from insightface.app import FaceAnalysis


# ==================================================
# Initialisation du modèle (une seule fois)
# ==================================================

app = FaceAnalysis(name="buffalo_l")
app.prepare(ctx_id=-1, det_size=(640, 640))


# ==================================================
# Fonctions
# ==================================================

def normalize(embedding):
    """Normalise un vecteur pour que sa norme = 1."""
    norm = np.linalg.norm(embedding)
    if norm == 0:
        raise ValueError("Embedding nul, impossible de normaliser.")
    return embedding / norm


def extract_embedding(image_path):
    """
    Détecte le visage principal d'une image
    et retourne son embedding normalisé.
    """
    img = cv2.imread(str(image_path))
    if img is None:
        raise ValueError(f"Impossible de lire : {image_path}")

    faces = app.get(img)

    if len(faces) == 0:
        raise ValueError(f"Aucun visage détecté dans : {image_path}")

    # Si plusieurs visages : on prend le plus grand
    if len(faces) > 1:
        faces = sorted(
            faces,
            key=lambda f: (f.bbox[2] - f.bbox[0]) * (f.bbox[3] - f.bbox[1]),
            reverse=True,
        )

    embedding = faces[0].embedding.astype(np.float32)
    return normalize(embedding)


def enroll_employee(employee_id, image_paths, output_dir="embeddings"):
    """
    Enrôle un employé à partir de plusieurs images.
    Sauvegarde chaque embedding dans :
        embeddings/employee_XXXXXX/embedding_N.npy
    """
    out_dir = Path(output_dir) / f"employee_{employee_id:06d}"
    out_dir.mkdir(parents=True, exist_ok=True)

    embeddings = []
    errors = []

    for i, img_path in enumerate(image_paths, start=1):
        try:
            emb = extract_embedding(img_path)
            embeddings.append(emb)

            # Sauvegarde .npy
            out_file = out_dir / f"embedding_{i}.npy"
            np.save(out_file, emb)

            print(f"[OK]   {img_path}  ->  {out_file}")

        except Exception as e:
            errors.append({"image": str(img_path), "error": str(e)})
            print(f"[FAIL] {img_path}  ->  {e}")

    return {
        "employee_id": employee_id,
        "embeddings": embeddings,
        "errors": errors,
    }


# ==================================================
# Test manuel — on enrôle la personne C (5 photos)
# ==================================================

if __name__ == "__main__":

    # Liste des 5 photos de la personne C
    photos_C = [
        "test_images/pers_C_1.jpeg",
        "test_images/pers_C_2.jpeg",
        "test_images/pers_C_3.jpeg",
        "test_images/pers_C_4.jpeg",
        "test_images/pers_C_5.jpeg",
    ]

    print("=" * 60)
    print("ENRÔLEMENT — Employé fictif 101 (personne C)")
    print("=" * 60)

    resultat = enroll_employee(
        employee_id=101,
        image_paths=photos_C,
    )

    print("\n" + "=" * 60)
    print("RAPPORT")
    print("=" * 60)
    print(f"Employé       : {resultat['employee_id']}")
    print(f"Embeddings OK : {len(resultat['embeddings'])}")
    print(f"Échecs        : {len(resultat['errors'])}")

    # Vérification : chaque embedding doit avoir une norme de 1.0
    print("\nNormes des embeddings sauvegardés :")
    for i, emb in enumerate(resultat["embeddings"], start=1):
        print(f"  embedding_{i} : dim={emb.shape}, norme={np.linalg.norm(emb):.6f}")