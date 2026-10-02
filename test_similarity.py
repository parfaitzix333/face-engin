import numpy as np
from pathlib import Path


# ==================================================
# 1. Charger les embeddings
# ==================================================

A1 = np.load(
    "test_images/personne_A_1_embedding.npy"
)

A2 = np.load(
    "test_images/personne_A_2_embedding.npy"
)

B1 = np.load(
    "test_images/personne_B_1_embedding.npy"
)


# ==================================================
# 2. Fonction de normalisation L2
# ==================================================

def normalize(embedding):
    norm = np.linalg.norm(embedding)

    if norm == 0:
        raise ValueError("Embedding nul.")

    return embedding / norm


# ==================================================
# 3. Normalisation
# ==================================================

A1_norm = normalize(A1)
A2_norm = normalize(A2)
B1_norm = normalize(B1)


# ==================================================
# 4. Similarité cosinus
# ==================================================

similarity_A1_A2 = np.dot(A1_norm, A2_norm)

similarity_A1_B1 = np.dot(A1_norm, B1_norm)

similarity_A2_B1 = np.dot(A2_norm, B1_norm)


# ==================================================
# 5. Affichage
# ==================================================

print("=" * 60)
print("COMPARAISON DES EMBEDDINGS")
print("=" * 60)

print(
    f"\nA1 ↔ A2 : {similarity_A1_A2:.6f}"
)

print(
    f"A1 ↔ B1 : {similarity_A1_B1:.6f}"
)

print(
    f"A2 ↔ B1 : {similarity_A2_B1:.6f}"
)


# ==================================================
# 6. Normes après normalisation
# ==================================================

print("\nNormes après normalisation :")

print(
    f"A1 : {np.linalg.norm(A1_norm):.6f}"
)

print(
    f"A2 : {np.linalg.norm(A2_norm):.6f}"
)

print(
    f"B1 : {np.linalg.norm(B1_norm):.6f}"
)