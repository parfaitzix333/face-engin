"""
Enrôle plusieurs employés en une seule fois.
Réutilise les fonctions de enrollment.py.
"""

from enrollment import enroll_employee

# Mapping : personne → (employee_id, liste de photos)
EMPLOYES = {
    "C": (101, [f"test_images/pers_C_{i}.jpeg" for i in range(1, 6)]),
    "D": (102, [f"test_images/pers_D_{i}.jpeg" for i in range(1, 6)]),
    "E": (103, [f"test_images/pers_E_{i}.jpeg" for i in range(1, 6)]),
    "F": (104, [f"test_images/pers_F_{i}.jpeg" for i in range(1, 6)]),
}


for personne, (emp_id, photos) in EMPLOYES.items():
    print("\n" + "=" * 60)
    print(f"ENRÔLEMENT — Employé {emp_id} (personne {personne})")
    print("=" * 60)

    resultat = enroll_employee(
        employee_id=emp_id,
        image_paths=photos,
    )

    print(f"\n  Embeddings OK : {len(resultat['embeddings'])}")
    print(f"  Échecs        : {len(resultat['errors'])}")