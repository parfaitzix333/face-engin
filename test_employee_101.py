"""
Vérifie la cohérence des 5 embeddings de l'employé 101.
On calcule la similarité cosinus entre chaque paire.
"""

import numpy as np
from pathlib import Path
from itertools import combinations


# ==================================================
# Charger les 5 embeddings
# ==================================================

folder = Path("embeddings/employee_000101")

files = sorted(folder.glob("embedding_*.npy"))

embeddings = []
for f in files:
    emb = np.load(f)
    embeddings.append(emb)
    print(f"Chargé : {f.name}   norme={np.linalg.norm(emb):.6f}")


# ==================================================
# Similarité entre toutes les paires
# ==================================================

print("\n" + "=" * 60)
print("SIMILARITÉS INTRA-EMPLOYÉ 101")
print("=" * 60)

scores = []

for i, j in combinations(range(len(embeddings)), 2):
    s = float(np.dot(embeddings[i], embeddings[j]))
    scores.append(s)
    print(f"  embedding_{i+1} ↔ embedding_{j+1} : {s:.6f}")


# ==================================================
# Statistiques
# ==================================================

scores = np.array(scores)

print("\n" + "-" * 60)
print(f"Moyenne : {scores.mean():.6f}")
print(f"Minimum : {scores.min():.6f}")
print(f"Maximum : {scores.max():.6f}")
print("-" * 60)