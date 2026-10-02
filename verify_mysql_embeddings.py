"""
verify_mysql_embeddings.py
==========================

Vérifie que les embeddings stockés dans MySQL sont identiques
à ceux des fichiers .npy d'origine.

Attendu : max|Δ| = 0.0 pour chaque embedding.
"""

import numpy as np
import pymysql
from pathlib import Path

from db_config import DB_CONFIG


EMBEDDINGS_DIR = Path("embeddings")

MAPPING = {
    101: 4,
    102: 3,
    103: 1,
    104: 2,
}


def blob_to_embedding(blob: bytes) -> np.ndarray:
    """2048 octets little-endian -> 512 float32."""
    return np.frombuffer(blob, dtype="<f4").copy()


def main():
    conn = pymysql.connect(**DB_CONFIG)

    try:
        with conn.cursor() as cur:

            # Récupère l'année active
            cur.execute("SELECT id FROM annees WHERE statut = 'active' LIMIT 1")
            annee_id = cur.fetchone()[0]
            print(f"[INFO] Année active : {annee_id}\n")

            for local_id, employe_id in MAPPING.items():

                print("=" * 60)
                print(f"Employé {employe_id} (dossier local {local_id})")
                print("=" * 60)

                # Charge les .npy locaux
                emp_dir = EMBEDDINGS_DIR / f"employee_{local_id:06d}"
                npy_files = sorted(emp_dir.glob("embedding_*.npy"))

                # Récupère les BLOB depuis MySQL (dans l'ordre d'insertion)
                cur.execute(
                    """
                    SELECT id, face_embedding
                    FROM face_templates
                    WHERE employe_id = %s AND annee_id = %s
                    ORDER BY id
                    """,
                    (employe_id, annee_id),
                )
                rows = cur.fetchall()

                if len(rows) != len(npy_files):
                    print(f"  ❌ Nombre incohérent : "
                          f"{len(rows)} en base vs {len(npy_files)} en local")
                    continue

                max_glob = 0.0

                for i, ((row_id, blob), npy_file) in enumerate(
                        zip(rows, npy_files), start=1):

                    v_local = np.load(npy_file)
                    v_db    = blob_to_embedding(blob)

                    diff = float(np.max(np.abs(v_local - v_db)))
                    max_glob = max(max_glob, diff)

                    status = "✅" if diff < 1e-6 else "❌"
                    print(f"  [{i}] {npy_file.name} "
                          f"| max|Δ| = {diff:.3e}  {status}")

                print(f"  → max|Δ| global : {max_glob:.3e}\n")

    finally:
        conn.close()


if __name__ == "__main__":
    print("=" * 60)
    print("VÉRIFICATION PYTHON <-> MySQL")
    print("=" * 60 + "\n")
    main()
    print("=" * 60)
    print("FIN")
    print("=" * 60)