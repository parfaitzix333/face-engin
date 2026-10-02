"""
test_calibration.py
====================

Calcule les distributions des similarités :
  - genuine  : même personne, photos différentes
  - impostor : personnes différentes

Puis propose un seuil de reconnaissance optimal.
"""

import numpy as np
from pathlib import Path
from itertools import combinations


# ==================================================
# 1. Charger tous les embeddings
# ==================================================

def load_all_embeddings(root="embeddings"):
    """
    Retourne :
      {employe_id: [emb1, emb2, emb3, emb4, emb5]}
    """
    root = Path(root)
    data = {}

    for emp_dir in sorted(root.glob("employee_*")):
        emp_id = int(emp_dir.name.split("_")[1])
        embeddings = []

        for f in sorted(emp_dir.glob("embedding_*.npy")):
            embeddings.append(np.load(f))

        data[emp_id] = embeddings

    return data


# ==================================================
# 2. Calculer toutes les paires
# ==================================================

def compute_pairs(data):
    """
    Retourne :
      genuine  : liste de (emp_id, i, j, score)
      impostor : liste de (emp_a, emp_b, i, j, score)
    """
    genuine  = []
    impostor = []

    emp_ids = sorted(data.keys())

    # --- Paires genuine (même employé) ---
    for emp_id in emp_ids:
        embs = data[emp_id]
        for i, j in combinations(range(len(embs)), 2):
            s = float(np.dot(embs[i], embs[j]))
            genuine.append((emp_id, i + 1, j + 1, s))

    # --- Paires impostor (employés différents) ---
    for idx_a in range(len(emp_ids)):
        for idx_b in range(idx_a + 1, len(emp_ids)):
            emp_a = emp_ids[idx_a]
            emp_b = emp_ids[idx_b]

            for i, emb_a in enumerate(data[emp_a], start=1):
                for j, emb_b in enumerate(data[emp_b], start=1):
                    s = float(np.dot(emb_a, emb_b))
                    impostor.append((emp_a, emp_b, i, j, s))

    return genuine, impostor


# ==================================================
# 3. Statistiques
# ==================================================

def stats(scores):
    scores = np.array(scores)
    return {
        "n":      len(scores),
        "mean":   float(scores.mean()),
        "std":    float(scores.std()),
        "min":    float(scores.min()),
        "max":    float(scores.max()),
        "p05":    float(np.percentile(scores, 5)),
        "p95":    float(np.percentile(scores, 95)),
    }


# ==================================================
# 4. Programme principal
# ==================================================

if __name__ == "__main__":

    print("=" * 70)
    print("CALIBRATION DES SEUILS DE RECONNAISSANCE")
    print("=" * 70)

    # --- Chargement ---
    data = load_all_embeddings("embeddings")
    print(f"\nEmployés chargés : {sorted(data.keys())}")
    for emp_id, embs in sorted(data.items()):
        print(f"  Employé {emp_id} : {len(embs)} embeddings")

    # --- Calcul des paires ---
    genuine, impostor = compute_pairs(data)

    scores_gen = [s for _, _, _, s in genuine]
    scores_imp = [s for _, _, _, _, s in impostor]

    # --- Statistiques ---
    s_gen = stats(scores_gen)
    s_imp = stats(scores_imp)

    print("\n" + "=" * 70)
    print("DISTRIBUTION GENUINE (même personne)")
    print("=" * 70)
    print(f"  Nombre de paires : {s_gen['n']}")
    print(f"  Moyenne          : {s_gen['mean']:.4f}")
    print(f"  Écart-type       : {s_gen['std']:.4f}")
    print(f"  Min              : {s_gen['min']:.4f}")
    print(f"  Max              : {s_gen['max']:.4f}")
    print(f"  5e percentile    : {s_gen['p05']:.4f}")
    print(f"  95e percentile   : {s_gen['p95']:.4f}")

    print("\n" + "=" * 70)
    print("DISTRIBUTION IMPOSTOR (personnes différentes)")
    print("=" * 70)
    print(f"  Nombre de paires : {s_imp['n']}")
    print(f"  Moyenne          : {s_imp['mean']:.4f}")
    print(f"  Écart-type       : {s_imp['std']:.4f}")
    print(f"  Min              : {s_imp['min']:.4f}")
    print(f"  Max              : {s_imp['max']:.4f}")
    print(f"  5e percentile    : {s_imp['p05']:.4f}")
    print(f"  95e percentile   : {s_imp['p95']:.4f}")

    # --- Chevauchement ? ---
    print("\n" + "=" * 70)
    print("ANALYSE DE SÉPARATION")
    print("=" * 70)

    # Score maximum observé chez les impostors
    imp_max = s_imp["max"]
    # Score minimum observé chez les genuines
    gen_min = s_gen["min"]

    print(f"  Score MAX des impostors   : {imp_max:.4f}")
    print(f"  Score MIN des genuines    : {gen_min:.4f}")

    if gen_min > imp_max:
        print("\n  ✅ SÉPARATION PARFAITE")
        print(f"     Aucun chevauchement.")
        print(f"     Zone de seuil possible : [{imp_max:.4f} , {gen_min:.4f}]")
        seuil_suggere = (imp_max + gen_min) / 2
    else:
        print("\n  ⚠️  CHEVAUCHEMENT DÉTECTÉ")
        print(f"     Certains impostors ({imp_max:.4f}) dépassent "
              f"certaines genuines ({gen_min:.4f})")
        seuil_suggere = (s_gen["mean"] + s_imp["mean"]) / 2

    print(f"\n  Seuil suggéré (compromis) : {seuil_suggere:.4f}")

    # --- Détail des cas difficiles ---
    print("\n" + "=" * 70)
    print("DÉTAIL — Paires les plus difficiles")
    print("=" * 70)

    print("\n  [Impostors avec les scores les plus ÉLEVÉS]")
    impostor_sorted = sorted(impostor, key=lambda x: x[4], reverse=True)
    for emp_a, emp_b, i, j, s in impostor_sorted[:5]:
        print(f"    {emp_a}_{i} ↔ {emp_b}_{j} : {s:.4f}")

    print("\n  [Genuines avec les scores les plus BAS]")
    genuine_sorted = sorted(genuine, key=lambda x: x[3])
    for emp_id, i, j, s in genuine_sorted[:5]:
        print(f"    {emp_id}_{i} ↔ {emp_id}_{j} : {s:.4f}")