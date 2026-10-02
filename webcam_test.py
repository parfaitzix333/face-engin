"""
webcam_test.py
==============

Démo temps réel avec affichage nom + matricule.
Utilise FaceRecognizer (recognition.py).
"""

import numpy as np
import cv2

from recognition import FaceRecognizer


# ==================================================
# Configuration
# ==================================================

SEUIL  = 0.40
INDEX  = 1        # ← index de la webcam (vu avec v4l2-ctl : 1 = Integrated)
INTERVALLE_RECONNAISSANCE = 5


# ==================================================
# Métadonnées employés (provisoire — plus tard depuis MySQL)
# ==================================================

METADATA = {
    101: {"nom": "Personne C", "matricule": "ARSP-000101"},
    102: {"nom": "Personne D", "matricule": "ARSP-000102"},
    103: {"nom": "Personne E", "matricule": "ARSP-000103"},
    104: {"nom": "Personne F", "matricule": "ARSP-000104"},
}


# ==================================================
# Initialisation
# ==================================================

print("[INFO] Chargement du moteur...")
recognizer = FaceRecognizer(seuil=SEUIL)
recognizer.load_employees_from_disk("embeddings", metadata=METADATA)
print(f"[INFO] {len(recognizer.employees)} employés chargés.")


# ==================================================
# Ouverture webcam
# ==================================================

cap = cv2.VideoCapture(INDEX)
if not cap.isOpened():
    raise RuntimeError(f"Impossible d'ouvrir la webcam index {INDEX}")

cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)

print(f"[INFO] Webcam index {INDEX} ouverte. 'q' pour quitter.\n")


# ==================================================
# Boucle
# ==================================================

frame_count = 0
cache = []      # liste de RecognitionResult du dernier calcul

while True:
    ret, frame = cap.read()
    if not ret:
        break

    frame_count += 1

    # -------- Reconnaissance (toutes N frames) --------
    if frame_count % INTERVALLE_RECONNAISSANCE == 0:
        # Pour la démo, on ne gère qu'un seul visage principal.
        # (Pour plusieurs visages en même temps : voir note plus bas)
        result = recognizer.recognize_image(frame)
        cache = [result] if result else []

    # -------- Affichage --------
    for r in cache:
        if r is None:
            continue

        x1, y1, x2, y2 = [int(v) for v in r.bbox]
        couleur = (0, 255, 0) if r.reconnu else (0, 0, 255)

        # Rectangle
        cv2.rectangle(frame, (x1, y1), (x2, y2), couleur, 2)

        # Construit le texte (2 lignes)
        if r.reconnu:
            ligne1 = r.nom
            ligne2 = f"{r.matricule}  ({r.score:.2f})"
        else:
            ligne1 = "INCONNU"
            ligne2 = f"({r.score:.2f})"

        # Taille du bloc de texte
        font = cv2.FONT_HERSHEY_SIMPLEX
        scale = 0.7
        thick = 2
        (w1, h1), _ = cv2.getTextSize(ligne1, font, scale, thick)
        (w2, h2), _ = cv2.getTextSize(ligne2, font, scale, thick)
        w = max(w1, w2)
        h_total = h1 + h2 + 20

        # Fond coloré derrière le texte
        cv2.rectangle(frame,
                      (x1, y1 - h_total),
                      (x1 + w + 20, y1),
                      couleur, -1)

        # Texte blanc
        cv2.putText(frame, ligne1,
                    (x1 + 10, y1 - h_total + h1 + 5),
                    font, scale, (255, 255, 255), thick)

        cv2.putText(frame, ligne2,
                    (x1 + 10, y1 - h_total + h1 + h2 + 15),
                    font, scale, (255, 255, 255), thick)

    # Info haut-gauche
    cv2.putText(frame,
                f"Frame {frame_count} | Seuil {SEUIL} | 'q' pour quitter",
                (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.6,
                (255, 255, 255), 2)

    cv2.imshow("Reconnaissance faciale ARSP", frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break


cap.release()
cv2.destroyAllWindows()
print("[INFO] Webcam fermée.")