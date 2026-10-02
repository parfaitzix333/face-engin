"""
import_embeddings_to_mysql.py
=============================

Importe les embeddings .npy dans la table face_templates.

Mapping (dossier local -> employe_id en base) :
    employee_000101 -> employe_id 4  (Numbi Kabange Guelord, 204)
    employee_000102 -> employe_id 3  (Bliss Ngoie,          203)
    employee_000103 -> employe_id 1  (Mumba Kisimba Boaz,   201)
    employee_000104 -> employe_id 2  (Benjamain Hemedi,     202)

Chaque .npy (512 float32) est converti en 2048 octets
float32 little-endian, puis inséré dans face_embedding.
"""

import numpy as np
import pymysql
from pathlib import Path

from db_config import DB_CONFIG


# ==================================================
# Configuration
# ==================================================

EMBEDDINGS_DIR = Path("embeddings")

# Mapping dossier local -> employe_id
MAPPING = {
    101: 4,   # personne C -> Numbi Kabange
    102: 3,   # personne D -> Bliss Ngoie
    103: 1,   # personne E -> Mumba Kisimba
    104: 2,   # personne F -> Benjamain Hemedi
}


# ==================================================
# Connexion
# ==================================================

def get_connection():
    return pymysql.connect(**DB_CONFIG)


def get_active_annee_id(conn):
    """Retourne l'id de l'année active."""
    with conn.cursor() as cur:
        cur.execute("SELECT id FROM annees WHERE statut = 'active' LIMIT 1")
        row = cur.fetchone()

    if row is None:
        raise RuntimeError("Aucune année active dans la table 'annees'.")

    return row[0]


# ==================================================
# Conversion float32 -> bytes
# ==================================================

def embedding_to_blob(embedding: np.ndarray) -> bytes:
    """
    Convertit un embedding (512 float32) en bytes.
    Doit donner exactement 2048 octets.
    """
    blob = embedding.astype("<f4").tobytes()

    if len(blob) != 2048:
        raise ValueError(
            f"Taille inattendue : {len(blob)} octets (attendu 2048)."
        )

    return blob


# ==================================================
# Import principal
# ==================================================

def import_all():
    conn = get_connection()
    annee_id = get_active_annee_id(conn)
    print(f"[INFO] Année active : id = {annee_id}")

    total_inserted = 0

    try:
        with conn.cursor() as cur:

            # --- Pour chaque dossier d'embeddings ---
            for emp_dir in sorted(EMBEDDINGS_DIR.glob("employee_*")):
                local_id = int(emp_dir.name.split("_")[1])

                if local_id not in MAPPING:
                    print(f"[SKIP] Dossier {emp_dir.name} non mappé.")
                    continue

                employe_id = MAPPING[local_id]

                # Récupère nom + matricule pour l'affichage
                cur.execute(
                    "SELECT nom, matricule FROM employes WHERE id = %s",
                    (employe_id,),
                )
                row = cur.fetchone()
                if row is None:
                    print(f"[ERR]  employe_id {employe_id} introuvable en base.")
                    continue
                nom, matricule = row

                print(f"\n[INFO] Dossier {emp_dir.name}")
                print(f"       -> employe_id {employe_id} ({nom}, {matricule})")

                # --- Supprimer les éventuels anciens templates ---
                # (idempotence : on peut relancer le script sans doublons)
                cur.execute(
                    "DELETE FROM face_templates WHERE employe_id = %s AND annee_id = %s",
                    (employe_id, annee_id),
                )
                deleted = cur.rowcount
                if deleted:
                    print(f"       -> {deleted} ancien(s) template(s) supprimé(s)")

                # --- Insérer les nouveaux ---
                npy_files = sorted(emp_dir.glob("embedding_*.npy"))
                if not npy_files:
                    print(f"       -> aucun .npy trouvé, skip.")
                    continue

                for npy_file in npy_files:
                    emb = np.load(npy_file)
                    blob = embedding_to_blob(emb)

                    cur.execute(
                        """
                        INSERT INTO face_templates
                            (employe_id, face_embedding, annee_id,
                             created_at, updated_at)
                        VALUES
                            (%s, %s, %s, NOW(), NOW())
                        """,
                        (employe_id, blob, annee_id),
                    )
                    total_inserted += 1
                    print(f"       -> INSERT {npy_file.name}  ({len(blob)} octets)")

        conn.commit()
        print(f"\n[OK] {total_inserted} ligne(s) insérée(s) au total.")

    except Exception as e:
        conn.rollback()
        print(f"\n[ERREUR] Rollback effectué : {e}")
        raise

    finally:
        conn.close()


# ==================================================
# Programme principal
# ==================================================

if __name__ == "__main__":
    print("=" * 60)
    print("IMPORT EMBEDDINGS -> MySQL (face_templates)")
    print("=" * 60)
    import_all()