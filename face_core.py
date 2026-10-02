"""
face_core.py
============

Socle technique partagé par enrollment.py et recognition.py.

Contient :
  - l'initialisation du modèle InsightFace (SCRFD + ArcFace)
  - la détection du visage principal dans une image
  - l'extraction d'un embedding normalisé

Aucune logique métier ici. Aucun accès disque. Aucune comparaison.
"""

import numpy as np
import cv2
from pathlib import Path


# ==================================================
# Constantes
# ==================================================

EMBEDDING_DIM = 512
MODEL_NAME    = "buffalo_l"
DET_SIZE      = (640, 640)
CTX_ID        = -1        # -1 = CPU, 0 = premier GPU


# ==================================================
# Classe FaceCore
# ==================================================

class FaceCore:
    """
    Encapsule SCRFD + ArcFace d'InsightFace.
    Une seule instance suffit pour toute l'application.
    """

    def __init__(self,
                 model_name: str = MODEL_NAME,
                 det_size: tuple = DET_SIZE,
                 ctx_id: int = CTX_ID):

        # Import local : évite de charger InsightFace si on importe juste
        # une constante du module.
        from insightface.app import FaceAnalysis

        providers = (
            ["CUDAExecutionProvider"] if ctx_id >= 0
            else ["CPUExecutionProvider"]
        )

        self.app = FaceAnalysis(name=model_name, providers=providers)
        self.app.prepare(ctx_id=ctx_id, det_size=det_size)

    # ----------------------------------------------
    # Détection + extraction sur une image numpy (BGR)
    # ----------------------------------------------

    def extract_from_image(self, image: np.ndarray) -> dict | None:
        """
        Prend une image OpenCV (BGR, np.ndarray) et retourne :

            {
                "embedding":  np.ndarray (512,) normalisé L2,
                "bbox":       (x1, y1, x2, y2) en pixels,
                "det_score":  float,
                "n_faces":    int,     nombre de visages vus
            }

        Retourne None si aucun visage n'est détecté.
        """
        faces = self.app.get(image)
        n_faces = len(faces)

        if n_faces == 0:
            return None

        # Si plusieurs visages, on prend le plus grand (aire bbox)
        if n_faces > 1:
            faces = sorted(
                faces,
                key=lambda f: (f.bbox[2] - f.bbox[0]) * (f.bbox[3] - f.bbox[1]),
                reverse=True,
            )

        face = faces[0]
        emb = face.embedding.astype(np.float32)

        if emb.shape != (EMBEDDING_DIM,):
            raise ValueError(f"Dimension inattendue : {emb.shape}")

        norm = np.linalg.norm(emb)
        if norm == 0:
            raise ValueError("Embedding nul.")

        return {
            "embedding": emb / norm,
            "bbox":      tuple(float(v) for v in face.bbox),
            "det_score": float(face.det_score),
            "n_faces":   n_faces,
        }

    # ----------------------------------------------
    # Extraction depuis un fichier sur disque
    # ----------------------------------------------

    def extract_from_file(self, image_path: str | Path) -> dict | None:
        """
        Comme extract_from_image, mais lit depuis un fichier.

        Lève FileNotFoundError si le fichier n'existe pas.
        Lève ValueError si l'image est illisible.
        Retourne None si aucun visage.
        """
        path = Path(image_path)

        if not path.exists():
            raise FileNotFoundError(f"Image introuvable : {image_path}")

        img = cv2.imread(str(path))
        if img is None:
            raise ValueError(f"Lecture impossible : {image_path}")

        return self.extract_from_image(img)