"""
pointage.py
===========

Logique métier du pointage.

Règle :
    1 seule ENTREE + 1 seule SORTIE par jour.

Cooldown par employé : 30 secondes.
"""

import time
import pymysql
from enum import Enum

from db_config import DB_CONFIG


# ==================================================
# Types de mouvement
# ==================================================

class Mouvement(str, Enum):
    ENTREE = "entree"
    SORTIE = "sortie"


# ==================================================
# Résultat d'une tentative de pointage
# ==================================================

class PointageResult(str, Enum):
    ENTREE_OK          = "entree_ok"
    SORTIE_OK          = "sortie_ok"
    DEJA_COMPLET       = "deja_complet"       # entrée + sortie déjà faites
    COOLDOWN           = "cooldown"           # < 30s depuis dernier pointage
    ERREUR             = "erreur"


# ==================================================
# État du cooldown en mémoire
# ==================================================

# {employe_id: timestamp_du_dernier_pointage}
DERNIER_POINTAGE: dict[int, float] = {}

COOLDOWN_SECONDES = 30


# ==================================================
# Fonctions principales
# ==================================================

def get_annee_active(conn) -> int:
    with conn.cursor() as cur:
        cur.execute("SELECT id FROM annees WHERE statut='active' LIMIT 1")
        row = cur.fetchone()
        if row is None:
            raise RuntimeError("Aucune année active.")
        return row[0]


def get_pointages_du_jour(conn, employe_id: int, annee_id: int):
    """
    Retourne la liste des mouvements déjà enregistrés aujourd'hui
    pour cet employé (dans l'ordre chronologique).
    """
    with conn.cursor() as cur:
        cur.execute(
            """
            SELECT mouvement
            FROM presences
            WHERE employe_id = %s
              AND annee_id = %s
              AND DATE = CURDATE()
            ORDER BY heure ASC
            """,
            (employe_id, annee_id),
        )
        return [row[0] for row in cur.fetchall()]


def determine_mouvement(pointages_du_jour: list[str]) -> Mouvement | None:
    """
    Décide du mouvement à effectuer en fonction des pointages déjà faits.

    Règle : 1 ENTREE + 1 SORTIE maximum par jour.

    Retourne :
        Mouvement.ENTREE si aucun pointage
        Mouvement.SORTIE si seulement ENTREE
        None             si ENTREE + SORTIE (complet)
    """
    if len(pointages_du_jour) == 0:
        return Mouvement.ENTREE
    if len(pointages_du_jour) == 1 and pointages_du_jour[0] == "entree":
        return Mouvement.SORTIE
    return None   # complet


def try_pointage(employe_id: int, score: float) -> tuple[PointageResult, Mouvement | None]:
    """
    Tente d'enregistrer un pointage pour l'employé.

    Retourne (PointageResult, Mouvement | None).
    """
    maintenant = time.time()

    # --- Cooldown ---
    dernier = DERNIER_POINTAGE.get(employe_id, 0)
    if maintenant - dernier < COOLDOWN_SECONDES:
        reste = COOLDOWN_SECONDES - (maintenant - dernier)
        return PointageResult.COOLDOWN, None

    conn = pymysql.connect(**DB_CONFIG)

    try:
        annee_id = get_annee_active(conn)
        pointages = get_pointages_du_jour(conn, employe_id, annee_id)
        mouvement = determine_mouvement(pointages)

        if mouvement is None:
            return PointageResult.DEJA_COMPLET, None

        # --- INSERT ---
        with conn.cursor() as cur:
            cur.execute(
                """
                INSERT INTO presences
                    (employe_id, DATE, heure, mouvement,
                     score_reconnaissance, annee_id,
                     created_at, updated_at)
                VALUES
                    (%s, CURDATE(), CURTIME(), %s,
                     %s, %s, NOW(), NOW())
                """,
                (employe_id, mouvement.value, score, annee_id),
            )
            

        conn.commit()

        # --- Mise à jour du cooldown ---
        DERNIER_POINTAGE[employe_id] = maintenant

        if mouvement == Mouvement.ENTREE:
            return PointageResult.ENTREE_OK, mouvement
        else:
            return PointageResult.SORTIE_OK, mouvement

    except Exception as e:
        conn.rollback()
        print(f"[POINTAGE ERREUR] {e}")
        return PointageResult.ERREUR, None

    finally:
        conn.close()


def reset_cooldown(employe_id: int | None = None):
    """Reset le cooldown (debug)."""
    if employe_id is None:
        DERNIER_POINTAGE.clear()
    else:
        DERNIER_POINTAGE.pop(employe_id, None)