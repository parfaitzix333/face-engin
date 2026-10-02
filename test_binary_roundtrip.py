"""
Vérifie que notre convention binaire est stable :
numpy float32 <-> bytes <-> numpy float32
"""

import numpy as np
from enrollment import embedding_to_bytes, bytes_to_embedding

# Vecteur aléatoire normalisé
np.random.seed(42)
v = np.random.randn(512).astype(np.float32)
v /= np.linalg.norm(v)

blob = embedding_to_bytes(v)
print(f"Taille du BLOB : {len(blob)} octets  (attendu : 2048)")
assert len(blob) == 2048, "❌ Taille incorrecte"

v2 = bytes_to_embedding(blob)
print(f"Norme après round-trip : {np.linalg.norm(v2):.8f}")

diff = np.max(np.abs(v - v2))
print(f"Différence max : {diff:.2e}")
assert diff < 1e-7, "❌ Round-trip instable"

print("✅ Round-trip Python OK")