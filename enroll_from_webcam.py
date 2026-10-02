"""
enroll_from_webcam.py
=====================

Enrôle un employé depuis la webcam.
- Affiche la liste des employés en base.
- L'utilisateur choisit un employé (id ou matricule).
- Capture 5 photos guidées (ESPACE pour capturer, 'q' pour annuler).
- Insert dans face_templates (annee_id = active).
"""

import time
import numpy as np
import cv2
from pathlib import Path

import pymysql

from face_core import FaceCore
from db_config import DB_CONFIG


# ==================================================
# Configuration
# ==================================================

WEBCAM_INDEX = 1
DET_SIZE     = (640, 640)
CTX_ID       = -1
N_PHOTOS     = 5
SEUIL_DET    = 0.5           # score de détection minimum accepté


# Les 5 consignes guidées
CONSIGNES = [
    "1/5 : Face neutre, bien eclaire, de face",
    "2/5 : Tournez legerement a GAUCHE (15 deg)",
    "3/5 : Tournez legerement a DROITE (15 deg)",
    "4/5 : Levez legerement la tete, regard vers le haut",
    "5/5 : Expression normale (lunettes/accessoires si habituels)",
]


# ==================================================
# Helpers MySQL
# ==================================================

def get_connection():
    return pymysql.connect(**DB_CONFIG)


def get_annee_active(conn):
    with conn.cursor() as cur:
        cur.execute("SELECT id FROM annees WHERE statut='active' LIMIT 1")
        row = cur.fetchone()
        if row is None:
            raise RuntimeError("Aucune annee active.")
        return row[0]


def list_employes(conn):
    with conn.cursor() as cur:
        cur.execute(
            """
            SELECT e.id, e.matricule, e.nom,
                   COUNT(ft.id) AS nb_templates
            FROM employes e
            LEFT JOIN face_templates ft
                ON ft.employe_id = e.id
               AND ft.annee_id = (SELECT id FROM annees WHERE statut='active')
            GROUP BY e.id, e.matricule, e.nom
            ORDER BY e.id
            """
        )
        return cur.fetchall()


def count_templates(conn, employe_id, annee_id):
    with conn.cursor() as cur:
        cur.execute(
            "SELECT COUNT(*) FROM face_templates WHERE employe_id=%s AND annee_id=%s",
            (employe_id, annee_id),
        )
        return cur.fetchone()[0]


def delete_templates(conn, employe_id, annee_id):
    with conn.cursor() as cur:
        cur.execute(
            "DELETE FROM face_templates WHERE employe_id=%s AND annee_id=%s",
            (employe_id, annee_id),
        )
        return cur.rowcount


def insert_templates(conn, employe_id, annee_id, embeddings):
    with conn.cursor() as cur:
        for emb in embeddings:
            blob = emb.astype("<f4").tobytes()
            assert len(blob) == 2048, f"Taille invalide : {len(blob)}"
            cur.execute(
                """
                INSERT INTO face_templates
                    (employe_id, face_embedding, annee_id,
                     created_at, updated_at)
                VALUES (%s, %s, %s, NOW(), NOW())
                """,
                (employe_id, blob, annee_id),
            )
    conn.commit()


# ==================================================
# Interface webcam
# ==================================================

def dessine_bandeau(frame, texte, y=40, couleur=(0, 150, 0), taille=0.8):
    font = cv2.FONT_HERSHEY_SIMPLEX
    (w, h), _ = cv2.getTextSize(texte, font, taille, 2)
    cv2.rectangle(frame, (10, y - h - 15), (10 + w + 20, y + 5), couleur, -1)
    cv2.putText(frame, texte, (20, y), font, taille, (255, 255, 255), 2)


def capture_photo(cap, core, consigne, photo_num):
    """
    Affiche la consigne, attend ESPACE pour capturer.
    Retourne l'embedding normalisé OU None si l'utilisateur annule.
    """
    print(f"\n[CAPTURE] {consigne}")
    print("         Appuyez sur ESPACE pour capturer, 'q' pour annuler.")

    while True:
        ret, frame = cap.read()
        if not ret:
            return None

        # Bandeau avec consigne
        dessine_bandeau(frame, f"Photo {photo_num}/{N_PHOTOS}", y=40,
                        couleur=(0, 100, 200))
        dessine_bandeau(frame, consigne, y=90, couleur=(0, 0, 0), taille=0.6)

        # Détection en direct (pour afficher le rectangle)
        face = core.extract_from_image(frame)
        if face is not None:
            x1, y1, x2, y2 = [int(v) for v in face["bbox"]]
            couleur = (0, 255, 0) if face["det_score"] >= SEUIL_DET else (0, 165, 255)
            cv2.rectangle(frame, (x1, y1), (x2, y2), couleur, 2)
            cv2.putText(frame, f"det={face['det_score']:.2f}",
                        (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX,
                        0.6, couleur, 2)
        else:
            cv2.putText(frame, "Aucun visage detecte",
                        (20, 140), cv2.FONT_HERSHEY_SIMPLEX,
                        0.7, (0, 0, 255), 2)

        cv2.imshow("Enrolement ARSP", frame)
        key = cv2.waitKey(1) & 0xFF

        if key == ord("q"):
            return None

        if key == ord(" "):
            if face is None:
                print("  [!] Aucun visage detecte, reessayez.")
                time.sleep(0.5)
                continue

            if face["det_score"] < SEUIL_DET:
                print(f"  [!] Detection faible ({face['det_score']:.2f}), reessayez.")
                time.sleep(0.5)
                continue

            print(f"  [OK] Capture ! det={face['det_score']:.2f}")
            # Petit feedback visuel : on flash en vert
            cv2.rectangle(frame, (0, 0), (frame.shape[1], frame.shape[0]),
                          (0, 255, 0), 20)
            cv2.imshow("Enrolement ARSP", frame)
            cv2.waitKey(200)

            return face["embedding"]


# ==================================================
# Sélection de l'employé
# ==================================================

def choisir_employe(conn):
    rows = list_employes(conn)

    print("\n" + "=" * 60)
    print("Employes disponibles")
    print("=" * 60)
    print(f"{'ID':<4} {'Matricule':<12} {'Nom':<30} {'Templates':<10}")
    print("-" * 60)
    for emp_id, matricule, nom, nb in rows:
        print(f"{emp_id:<4} {matricule:<12} {nom:<30} {nb:<10}")

    print()
    choix = input("Entrez l'ID de l'employe a enroler (ou 'q' pour quitter) : ").strip()

    if choix.lower() == "q":
        return None

    try:
        emp_id = int(choix)
    except ValueError:
        print("ID invalide.")
        return choisir_employe(conn)

    for row in rows:
        if row[0] == emp_id:
            return {
                "id":        row[0],
                "matricule": row[1],
                "nom":       row[2],
                "nb_templates_actuels": row[3],
            }

    print(f"Aucun employe avec l'ID {emp_id}.")
    return choisir_employe(conn)


# ==================================================
# Programme principal
# ==================================================

def main():
    print("=" * 60)
    print("ENROLEMENT FACIAL DEPUIS LA WEBCAM")
    print("=" * 60)

    conn = get_connection()
    annee_id = get_annee_active(conn)
    print(f"[INFO] Annee active : id = {annee_id}")

    # -------- Choisir l'employé --------
    employe = choisir_employe(conn)
    if employe is None:
        print("Annule.")
        conn.close()
        return

    employe_id = employe["id"]
    nom        = employe["nom"]
    matricule  = employe["matricule"]
    nb_exist   = employe["nb_templates_actuels"]

    print(f"\n[INFO] Employe selectionne : {nom} ({matricule})")

    # -------- Doublons : confirmation --------
    if nb_exist > 0:
        print(f"\n[!] Cet employe a deja {nb_exist} template(s) pour l'annee active.")
        reponse = input("Voulez-vous les REMPLACER ? (o/n) : ").strip().lower()
        if reponse != "o":
            print("Annule.")
            conn.close()
            return

    # -------- Ouvrir webcam --------
    cap = cv2.VideoCapture(WEBCAM_INDEX)
    if not cap.isOpened():
        print(f"[ERREUR] Impossible d'ouvrir la webcam {WEBCAM_INDEX}.")
        conn.close()
        return

    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)

    print("[INFO] Chargement du modele...")
    core = FaceCore(det_size=DET_SIZE, ctx_id=CTX_ID)
    print("[INFO] Modele pret.\n")
    print("=" * 60)
    print("INSTRUCTIONS")
    print("=" * 60)
    print("Appuyez sur ESPACE pour capturer chaque photo.")
    print("'q' pour annuler a tout moment.")
    print("=" * 60)

    # -------- Capture des 5 photos --------
    embeddings = []
    try:
        for i, consigne in enumerate(CONSIGNES, start=1):
            emb = capture_photo(cap, core, consigne, i)
            if emb is None:
                print("\n[ANNULATION] Enrolement interrompu.")
                cap.release()
                cv2.destroyAllWindows()
                conn.close()
                return
            embeddings.append(emb)
            print(f"      -> {len(embeddings)}/{N_PHOTOS} captures OK")

    finally:
        cap.release()
        cv2.destroyAllWindows()

    # -------- Écriture en base --------
    print("\n" + "=" * 60)
    print("ECRITURE EN BASE")
    print("=" * 60)

    if nb_exist > 0:
        deleted = delete_templates(conn, employe_id, annee_id)
        print(f"  [OK] {deleted} ancien(s) template(s) supprime(s)")

    insert_templates(conn, employe_id, annee_id, embeddings)
    print(f"  [OK] {len(embeddings)} template(s) insere(s)")

    # Vérification immédiate
    total = count_templates(conn, employe_id, annee_id)
    print(f"  [OK] Total actuel en base : {total}")

    conn.close()

    print("\n" + "=" * 60)
    print(f"ENROLEMENT TERMINE : {nom} ({matricule})")
    print("=" * 60)


if __name__ == "__main__":
    main()