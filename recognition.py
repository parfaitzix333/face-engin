"""
recognition.py
==============

Classe FaceRecognizer : charge les embeddings enrôlés et identifie
l'employé présent dans une image.

Fournit :
  - load_employees_from_disk()  : charge depuis embeddings/
  - recognize(image)            : retourne (employe_id, score, info) ou None
  - recognize_file(path)        : variante fichier
"""

import numpy as np
from pathlib import Path
from dataclasses import dataclass

from face_core import FaceCore


# ==================================================
# Structure de résultat
# ==================================================

@dataclass
class RecognitionResult:
    employe_id: int
    nom: str
    matricule: str
    score: float
    bbox: tuple          # (x1, y1, x2, y2)
    reconnu: bool        # True si score >= seuil


# ==================================================
# Classe FaceRecognizer
# ==================================================

class FaceRecognizer:

    def __init__(self,
                 seuil: float = 0.40,
                 core: FaceCore | None = None):

        self.seuil = seuil
        self.core = core if core is not None else FaceCore()

        # Stockage interne :
        #   employees[employe_id] = {
        #       "nom":       str,
        #       "matricule": str,
        #       "matrix":    np.ndarray (N, 512)
        #   }
        self.employees: dict[int, dict] = {}

    # ----------------------------------------------
    # Chargement depuis le disque (embeddings/)
    # ----------------------------------------------

    def load_employees_from_disk(self,
                                  root: str | Path = "embeddings",
                                  metadata: dict | None = None):
        """
        Charge les embeddings .npy du dossier `embeddings/`.

        metadata : dict optionnel qui associe employe_id → infos
        {
            101: {"nom": "KABONGO MUKENDI", "matricule": "ARSP-000101"},
            ...
        }

        Si metadata est absent, on met des valeurs par défaut.
        """
        root = Path(root)
        metadata = metadata or {}

        self.employees.clear()

        for emp_dir in sorted(root.glob("employee_*")):
            emp_id = int(emp_dir.name.split("_")[1])

            vectors = [
                np.load(f)
                for f in sorted(emp_dir.glob("embedding_*.npy"))
            ]

            if not vectors:
                continue

            # Matrice (N, 512) — chaque ligne = 1 embedding normalisé
            matrix = np.stack(vectors)

            info = metadata.get(emp_id, {})
            self.employees[emp_id] = {
                "nom":       info.get("nom", f"Employe {emp_id}"),
                "matricule": info.get("matricule", f"ARSP-{emp_id:06d}"),
                "matrix":    matrix,
            }

        return self.employees

    # ----------------------------------------------
    # Reconnaissance
    # ----------------------------------------------

    def recognize_image(self, image: np.ndarray) -> RecognitionResult | None:
        """
        Prend une image BGR (numpy) et retourne :
          - RecognitionResult si un visage est détecté (reconnu ou non)
          - None si aucun visage détecté
        """
        face = self.core.extract_from_image(image)
        if face is None:
            return None

        return self._match(face["embedding"], face["bbox"])

    def recognize_file(self, image_path: str | Path) -> RecognitionResult | None:
        """Variante qui lit depuis un fichier."""
        face = self.core.extract_from_file(image_path)
        if face is None:
            return None

        return self._match(face["embedding"], face["bbox"])

    # ----------------------------------------------
    # Comparaison (privée)
    # ----------------------------------------------

    def _match(self, embedding: np.ndarray, bbox: tuple) -> RecognitionResult:
        """
        Compare l'embedding requête à tous les employés chargés.
        Retourne un RecognitionResult (reconnu=True/False).
        """
        best_id    = -1
        best_score = -1.0

        for emp_id, info in self.employees.items():
            # (N, 512) @ (512,) → (N,) → max
            score = float((info["matrix"] @ embedding).max())
            if score > best_score:
                best_score = score
                best_id    = emp_id

        if best_id == -1:
            # Aucun employé enrôlé
            return RecognitionResult(
                employe_id=-1,
                nom="INCONNU",
                matricule="",
                score=0.0,
                bbox=bbox,
                reconnu=False,
            )

        reconnu = best_score >= self.seuil
        info = self.employees[best_id]

        return RecognitionResult(
            employe_id=best_id,
            nom=info["nom"] if reconnu else "INCONNU",
            matricule=info["matricule"] if reconnu else "",
            score=best_score,
            bbox=bbox,
            reconnu=reconnu,
        )