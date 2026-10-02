import cv2
from insightface.app import FaceAnalysis
from pathlib import Path


# --------------------------------------------------
# 1. Initialisation du modèle
# --------------------------------------------------

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


# --------------------------------------------------
# 2. Dossier contenant les images
# --------------------------------------------------

image_dir = Path("test_images")

images = sorted(image_dir.glob("*.jpg"))

if not images:
    print("Aucune image JPG trouvée dans test_images/")
    exit()


# --------------------------------------------------
# 3. Analyse des images
# --------------------------------------------------

for image_path in images:

    print("\n" + "=" * 50)
    print(f"Image : {image_path.name}")

    image = cv2.imread(str(image_path))

    if image is None:
        print("Erreur : impossible de lire l'image.")
        continue

    # Détection des visages
    faces = app.get(image)

    print(f"Nombre de visages détectés : {len(faces)}")

    # --------------------------------------------------
    # 4. Affichage des informations détectées
    # --------------------------------------------------

    for i, face in enumerate(faces, start=1):

        bbox = face.bbox
        landmarks = face.kps

        print(f"\nVisage {i}")

        print("Bounding box :")
        print(bbox)

        print("Landmarks :")
        print(landmarks)

        # Dessiner le rectangle autour du visage
        x1, y1, x2, y2 = bbox.astype(int)

        cv2.rectangle(
            image,
            (x1, y1),
            (x2, y2),
            (0, 255, 0),
            2
        )

        # Dessiner les landmarks
        for point in landmarks.astype(int):
            x, y = point
            cv2.circle(
                image,
                (x, y),
                3,
                (0, 0, 255),
                -1
            )

    # --------------------------------------------------
    # 5. Sauvegarde de l'image annotée
    # --------------------------------------------------

    output_path = image_dir / f"resultat_{image_path.name}"

    cv2.imwrite(
        str(output_path),
        image
    )

    print(f"Résultat enregistré : {output_path}")