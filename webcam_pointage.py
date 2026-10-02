"""
webcam_pointage.py
==================

Script principal de pointage en temps réel.

Usage :
    python webcam_pointage.py
    (q pour quitter)
"""

import time
import cv2

from recognition_mysql import FaceRecognizerMySQL
from pointage import (
    try_pointage,
    PointageResult,
    Mouvement,
)


# ==================================================
# Configuration
# ==================================================

SEUIL  = 0.40
INDEX  = 1
INTERVALLE_RECONNAISSANCE = 5
DUREE_MESSAGE = 3.0     # secondes : durée d'affichage du message "✅ ENTREE"


# ==================================================
# Initialisation
# ==================================================

print("[INFO] Chargement du moteur...")
recognizer = FaceRecognizerMySQL(seuil=SEUIL)
recognizer.load_employees()
print(f"[INFO] {len(recognizer.employees)} employés chargés depuis MySQL.")
for emp_id, info in sorted(recognizer.employees.items()):
    print(f"       - id={emp_id} : {info['nom']} ({info['matricule']})")


# ==================================================
# Webcam
# ==================================================

cap = cv2.VideoCapture(INDEX)
if not cap.isOpened():
    raise RuntimeError(f"Webcam index {INDEX} indisponible.")

cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)


# ==================================================
# Boucle
# ==================================================

frame_count = 0
cache_result = None         # dernier RecognitionResult
message_temporaire = None   # (texte, couleur, timestamp_expiration)


def afficher_message(frame, texte, couleur, x1, y1):
    """Affiche un bandeau de message pendant DUREE_MESSAGE secondes."""
    font = cv2.FONT_HERSHEY_SIMPLEX
    scale = 0.8
    thick = 2
    (w, h), _ = cv2.getTextSize(texte, font, scale, thick)
    cv2.rectangle(frame, (x1, y1 - h - 20), (x1 + w + 20, y1), couleur, -1)
    cv2.putText(frame, texte, (x1 + 10, y1 - 8),
                font, scale, (255, 255, 255), thick)


print("[INFO] Webcam ouverte. 'q' pour quitter.\n")

while True:
    ret, frame = cap.read()
    if not ret:
        break

    frame_count += 1

    # -------- Reconnaissance (toutes N frames) --------
    if frame_count % INTERVALLE_RECONNAISSANCE == 0:
        cache_result = recognizer.recognize_image(frame)

        # --- Si reconnu, tente un pointage ---
        if cache_result is not None and cache_result.reconnu:
            result, mouvement = try_pointage(
                cache_result.employe_id,
                cache_result.score,
            )

            if result == PointageResult.ENTREE_OK:
                texte = "✅ ENTREE enregistree"
                message_temporaire = (texte, (0, 150, 0), time.time())
                print(f"[POINTAGE] {cache_result.nom} → ENTREE "
                      f"(score={cache_result.score:.4f})")

            elif result == PointageResult.SORTIE_OK:
                texte = "✅ SORTIE enregistree"
                message_temporaire = (texte, (0, 100, 200), time.time())
                print(f"[POINTAGE] {cache_result.nom} → SORTIE "
                      f"(score={cache_result.score:.4f})")

            elif result == PointageResult.DEJA_COMPLET:
                texte = "Deja pointe aujourd'hui"
                message_temporaire = (texte, (80, 80, 80), time.time())

            elif result == PointageResult.COOLDOWN:
                # On n'affiche rien, c'est juste un anti-doublon
                pass

    # -------- Affichage --------
    if cache_result is not None:
        r = cache_result
        x1, y1, x2, y2 = [int(v) for v in r.bbox]
        couleur = (0, 255, 0) if r.reconnu else (0, 0, 255)

        cv2.rectangle(frame, (x1, y1), (x2, y2), couleur, 2)

        # Bloc nom + matricule + score
        if r.reconnu:
            ligne1 = r.nom
            ligne2 = f"{r.matricule}  ({r.score:.2f})"
        else:
            ligne1 = "INCONNU"
            ligne2 = f"({r.score:.2f})"

        font = cv2.FONT_HERSHEY_SIMPLEX
        scale = 0.7
        thick = 2
        (w1, h1), _ = cv2.getTextSize(ligne1, font, scale, thick)
        (w2, h2), _ = cv2.getTextSize(ligne2, font, scale, thick)
        w = max(w1, w2)
        h_total = h1 + h2 + 20

        cv2.rectangle(frame, (x1, y1 - h_total),
                      (x1 + w + 20, y1), couleur, -1)
        cv2.putText(frame, ligne1, (x1 + 10, y1 - h_total + h1 + 5),
                    font, scale, (255, 255, 255), thick)
        cv2.putText(frame, ligne2, (x1 + 10, y1 - h_total + h1 + h2 + 15),
                    font, scale, (255, 255, 255), thick)

        # Message temporaire (ENTREE / SORTIE / déjà pointé)
        if message_temporaire is not None:
            texte, coul_msg, t0 = message_temporaire
            if time.time() - t0 < DUREE_MESSAGE:
                afficher_message(frame, texte, coul_msg, x1, y2 + 50)
            else:
                message_temporaire = None

    # Info haut-gauche
    cv2.putText(frame,
                f"Frame {frame_count} | Seuil {SEUIL} | 'q' pour quitter",
                (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 0.6,
                (255, 255, 255), 2)

    cv2.imshow("Pointage ARSP", frame)

    if cv2.waitKey(1) & 0xFF == ord("q"):
        break


cap.release()
cv2.destroyAllWindows()
print("[INFO] Bye.")