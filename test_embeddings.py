import cv2
import numpy as np
from insightface.app import FaceAnalysis
from pathlib import Path


# ==================================================
# 1. Initialisation du modèle
# ==================================================

print("Chargement du modèle...")

app = FaceAnalysis(
    name="buffalo_l",
    providers=["CPUExecutionProvider"]
)

app.prepare(
    ctx_id=-1,
    det_size=(640, 640)
)

print("Modèle chargé.")


# ==================================================
# 2. Dossier des images
# ==================================================

image_dir = Path("test_images")

images = sorted(
    image_dir.glob("personne_*.jpg")
)


# ==================================================
# 3. Traitement
# ==================================================

for image_path in images:

    print("\n" + "=" * 60)
    print(f"Image : {image_path.name}")

    image = cv2.imread(str(image_path))

    if image is None:
        print("Impossible de lire l'image.")
        continue

    # Détection + reconnaissance
    faces = app.get(image)

    print(f"Nombre de visages : {len(faces)}")

    if len(faces) == 0:
        print("Aucun visage détecté.")
        continue

    # Pour le moment, nous prenons le premier visage
    face = faces[0]

    # ==================================================
    # Embedding ArcFace
    # ==================================================

    embedding = face.embedding

    print("Type :", type(embedding))
    print("Dimension :", embedding.shape)
    print("Type numérique :", embedding.dtype)

    print("\nPremières valeurs :")
    print(embedding[:10])

    print("\nNorme du vecteur :")
    print(np.linalg.norm(embedding))

    # ==================================================
    # Sauvegarde locale
    # ==================================================

    output_file = (
        image_dir /
        f"{image_path.stem}_embedding.npy"
    )

    np.save(
        output_file,
        embedding.astype(np.float32)
    )

    print(
        f"\nEmbedding sauvegardé : {output_file}"
    )