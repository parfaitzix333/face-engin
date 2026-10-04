"""
recognition_mysql.py
====================

Version MySQL de la reconnaissance.
Charge les embeddings depuis la table face_templates,
joint les infos employé (nom, matricule),
expose recognize() et recognize_file().
"""

import numpy as np
import pymysql
from dataclasses import dataclass
from pathlib import Path

from face_core import FaceCore
from db_config import DB_CONFIG


# ==================================================
# Résultat
# ==================================================

@dataclass
class RecognitionResult:
    employe_id: int
    nom: str
    matricule: str
    score: float
    bbox: tuple
    reconnu: bool


# ==================================================
# Helpers BLOB
# ==================================================

def blob_to_embedding(blob: bytes) -> np.ndarray:
    """2048 octets little-endian → 512 float32."""
    return np.frombuffer(blob, dtype="<f4").copy()


# ==================================================
# Classe FaceRecognizerMySQL
# ==================================================

class FaceRecognizerMySQL:

    def __init__(self,
                 seuil: float = 0.40,
                 annee_id: int | None = None,
                 core: FaceCore | None = None,
                 db_config: dict | None = None):

        self.seuil = seuil
        self.core = core if core is not None else FaceCore()
        self.db_config = db_config if db_config is not None else DB_CONFIG

        self.annee_id = annee_id if annee_id is not None else self._get_active_annee_id()

        # employees[employe_id] = {
        #     "nom": str, "matricule": str, "matrix": np.ndarray (N, 512)
        # }
        self.employees: dict[int, dict] = {}

    # ----------------------------------------------
    # Année active
    # ----------------------------------------------

    def _get_active_annee_id(self) -> int:
        conn = pymysql.connect(**self.db_config)
        try:
            with conn.cursor() as cur:
                cur.execute(
                    "SELECT id FROM annees WHERE statut='active' LIMIT 1"
                )
                row = cur.fetchone()
                if row is None:
                    raise RuntimeError("Aucune année active dans 'annees'.")
                return row[0]
        finally:
            conn.close()

    # ----------------------------------------------
    # Chargement depuis MySQL
    # ----------------------------------------------

    def load_employees(self):
        """
        Charge les embeddings + infos employés depuis MySQL.
        Remplit self.employees.
        """
        conn = pymysql.connect(**self.db_config)
        self.employees.clear()

        try:
            with conn.cursor() as cur:
                # Jointure : face_templates + employes
                cur.execute(
                    """
                    SELECT
                        ft.employe_id,
                        e.nom,
                        e.matricule,
                        ft.face_embedding
                    FROM face_templates ft
                    JOIN employes e ON e.id = ft.employe_id
                    WHERE ft.annee_id = %s
                    ORDER BY ft.employe_id, ft.id
                    """,
                    (self.annee_id,),
                )
                rows = cur.fetchall()

                for employe_id, nom, matricule, blob in rows:
                    emb = blob_to_embedding(blob)

                    if employe_id not in self.employees:
                        self.employees[employe_id] = {
                            "nom": nom,
                            "matricule": matricule,
                            "vectors": [],
                        }

                    self.employees[employe_id]["vectors"].append(emb)

            # Empile en matrices (N, 512)
            for emp_id, info in self.employees.items():
                info["matrix"] = np.stack(info["vectors"])
                del info["vectors"]

        finally:
            conn.close()

        return self.employees

    # ----------------------------------------------
    # Reconnaissance
    # ----------------------------------------------

    def recognize_image(self, image: np.ndarray) -> RecognitionResult | None:
        face = self.core.extract_from_image(image)
        if face is None:
            return None
        return self._match(face["embedding"], face["bbox"])

    def recognize_file(self, path) -> RecognitionResult | None:
        face = self.core.extract_from_file(path)
        if face is None:
            return None
        return self._match(face["embedding"], face["bbox"])

    # ----------------------------------------------
    # Comparaison
    # ----------------------------------------------

    def _match(self, embedding: np.ndarray, bbox: tuple) -> RecognitionResult:
        best_id = -1
        best_score = -1.0

        for emp_id, info in self.employees.items():
            score = float((info["matrix"] @ embedding).max())
            if score > best_score:
                best_score = score
                best_id = emp_id

        if best_id == -1:
            return RecognitionResult(
                employe_id=-1, nom="INCONNU", matricule="",
                score=0.0, bbox=bbox, reconnu=False,
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

    def reload_employee(self, employe_id: int):
        """
        Recharge les embeddings d'un seul employé depuis MySQL.
        Si l'employé n'a plus d'embeddings, il est retiré du cache.
        """
        conn = pymysql.connect(**self.db_config)
        try:
            with conn.cursor() as cur:
                cur.execute(
                    """
                    SELECT e.nom, e.matricule, ft.face_embedding
                    FROM face_templates ft
                    JOIN employes e ON e.id = ft.employe_id
                    WHERE ft.employe_id = %s AND ft.annee_id = %s
                    ORDER BY ft.id
                    """,
                    (employe_id, self.annee_id),
                )

                rows = cur.fetchall()

                if not rows:
                    self.employees.pop(employe_id, None)
                    print(f"[CACHE] Employé {employe_id} retiré du cache.")
                    return

                nom = rows[0][0]
                matricule = rows[0][1]
                vectors = [blob_to_embedding(r[2]) for r in rows]

                self.employees[employe_id] = {
                    "nom": nom,
                    "matricule": matricule,
                    "matrix": np.stack(vectors),
                }

                print(
                    f"[CACHE] Employé {employe_id} ({nom}) rechargé "
                    f"({len(vectors)} embeddings)."
                )
        finally:
            conn.close()