Ce que ce README couvre
==========================================
Section	Contenu
1-2	Comprendre le projet et son architecture
3-4	Installer et configurer l'environnement
5	Structure des fichiers
6	Comment fonctionne le ML (SCRFD, ArcFace)
7	Schéma complet de la base MySQL
8	Documentation de chaque module Python
9	Documentation complète de l'API FastAPI
10	Comment PHP parle à FastAPI
11	Guide pas-à-pas pour utiliser le système
12	Conventions (float32, endianness, seuil)
13	Résultats chiffrés (calibration, tests réels)
14	Résolution des problèmes courants
15	Ce qui est fait, ce qui reste

N'importe qui peut reprendre le projet avec ce document. C'est le but.
===========================================================


# Projet ARSP — Reconnaissance Faciale & Pointage

Système de pointage d'employés par reconnaissance faciale pour l'ARSP
(Agence de Regulation du Secteur Postal).

---

## Table des matières

1. [Aperçu du projet](#1-aperçu-du-projet)
2. [Architecture technique](#2-architecture-technique)
3. [Prérequis](#3-prérequis)
4. [Installation](#4-installation)
5. [Structure du projet](#5-structure-du-projet)
6. [Pipeline Machine Learning](#6-pipeline-machine-learning)
7. [Base de données MySQL](#7-base-de-données-mysql)
8. [Modules Python](#8-modules-python)
9. [API FastAPI](#9-api-fastapi)
10. [Intégration PHP](#10-intégration-php)
11. [Guide d'utilisation](#11-guide-dutilisation)
12. [Conventions techniques](#12-conventions-techniques)
13. [Résultats obtenus](#13-résultats-obtenus)
14. [Dépannage](#14-dépannage)
15. [Roadmap](#15-roadmap)

---

## 1. Aperçu du projet

### Objectif

Permettre le pointage automatique des employés de l'ARSP via une
reconnaissance faciale, avec validation par un superviseur humain.

### Fonctionnalités

- **Enrôlement** : capture de 5 photos guidées par employé via webcam
- **Reconnaissance** : identification d'un employé à partir d'une image
- **Pointage** : enregistrement automatique des entrées/sorties
- **Persistance** : stockage des embeddings (512D) et des pointages en MySQL
- **API HTTP** : exposition des fonctionnalités via FastAPI
- **Interface web** : intégration dans une plateforme Laravel existante

### Contexte métier

- **Environnement** : ARSP, RDC
- **Workflow** : le système propose un pointage, le superviseur valide
- **Règle** : 1 entrée + 1 sortie par employé par jour
- **Robustesse** : doit fonctionner en conditions réelles (éclairage variable,
  accessoires, angles)

---

## 2. Architecture technique

### Vue d'ensemble

    ┌─────────────────────────────────────────────────────────┐
    │                    Navigateur (Web)                     │
    │  - Vue Blade Laravel                                    │
    │  - JavaScript (getUserMedia)                            │
    └───────────────────────┬─────────────────────────────────┘
                            │ HTTP (upload image)
                            ▼
    ┌─────────────────────────────────────────────────────────┐
    │                 Laravel (PHP) — port 80                 │
    │  - Contrôleur FaceRecognitionController                 │
    │  - Service FaceRecognitionService (client HTTP)         │
    │  - Enregistrement des pointages dans presences          │
    └───────────────────────┬─────────────────────────────────┘
                            │ HTTP (JSON + multipart)
                            ▼
    ┌─────────────────────────────────────────────────────────┐
    │                FastAPI (Python) — port 8001             │
    │  - POST /recognize                                      │
    │  - POST /enroll                                         │
    │  - GET  /employees                                      │
    │  - GET  /health                                         │
    └───────────────────────┬─────────────────────────────────┘
                            │
                            ▼
    ┌─────────────────────────────────────────────────────────┐
    │              Pipeline ML (InsightFace)                  │
    │  SCRFD (détection)  →  ArcFace (embedding 512D)         │
    │  →  Normalisation L2  →  Similarité cosinus             │
    └───────────────────────┬─────────────────────────────────┘
                            │ PyMySQL
                            ▼
    ┌─────────────────────────────────────────────────────────┐
    │                MySQL (XAMPP) — port 3306                │
    │  Tables : employes, annees, face_templates, presences   │
    └─────────────────────────────────────────────────────────┘

### Flux d'une reconnaissance

    1. Utilisateur clique "Pointer" sur la page Laravel
    2. JavaScript capture une image (webcam)
    3. POST /api/face/recognize (Laravel)
    4. Laravel relaie à FastAPI (POST /recognize)
    5. FastAPI → SCRFD → ArcFace → embedding 512D
    6. FastAPI → compare aux embeddings MySQL (cosinus)
    7. FastAPI → JSON {employe_id, nom, matricule, score, reconnu}
    8. Laravel enregistre le pointage dans presences
    9. Laravel renvoie le résultat à la vue
    10. Superviseur valide/rejette (workflow à venir)

---

## 3. Prérequis

### Système

- **OS** : Linux (Ubuntu 22.04+ recommandé)
- **RAM** : 4 Go minimum (8 Go recommandé)
- **CPU** : Dual-core minimum
- **Webcam** : intégrée ou USB (index /dev/videoN)

### Logiciels

| Logiciel | Version | Rôle |
|---|---|---|
| Python | 3.10+ | ML + FastAPI |
| XAMPP | 8.0+ | Apache + MySQL + PHP |
| MySQL | 5.7+ (fourni par XAMPP) | Base de données |
| PHP | 8.0+ (fourni par XAMPP) | Laravel |
| Composer | 2.0+ | Dépendances Laravel |
| Laravel | 10 ou 11 | Plateforme web |
| Node.js (optionnel) | 18+ | Assets frontend |

### Dépendances Python

- `insightface` — détection + reconnaissance faciale
- `onnxruntime` — runtime des modèles ONNX
- `opencv-python` — traitement d'image
- `numpy` — calcul matriciel
- `pymysql` — connecteur MySQL
- `fastapi` — framework API HTTP
- `uvicorn` — serveur ASGI
- `python-multipart` — gestion des uploads

---

## 4. Installation

### 4.1 Cloner / préparer le projet

    cd ~/Bureau/ARCHIVE/MES\ DOC/MY\ PROJECTS/PROJET\ ARSP/
    mkdir face-engin && cd face-engin

### 4.2 Environnement virtuel Python

    python3 -m venv venv
    source venv/bin/activate      # Linux/macOS
    # ou
    venv\Scripts\activate.bat     # Windows

### 4.3 Installer les dépendances Python

    pip install insightface onnxruntime opencv-python numpy pymysql
    pip install fastapi uvicorn python-multipart

**Note** : lors de la première exécution, InsightFace télécharge
automatiquement le modèle `buffalo_l` (~326 Mo) dans
`~/.insightface/models/`.

### 4.4 Démarrer XAMPP

    sudo /opt/lampp/lampp start

Vérification :

    sudo /opt/lampp/lampp status
    # Attendu : Apache is running. MySQL is running.

### 4.5 Base de données

- Base : `bd_arsp`
- Tables requises (voir §7) :
  - `employes` (existante)
  - `annees` (existante)
  - `face_templates` (à créer via migration Laravel)
  - `presences` (existante)

### 4.6 Test de connexion MySQL depuis Python

    python -c "
    import pymysql
    conn = pymysql.connect(
        host='127.0.0.1', port=3306, user='root',
        password='', database='bd_arsp'
    )
    cur = conn.cursor()
    cur.execute('SELECT COUNT(*) FROM employes')
    print(cur.fetchone())
    conn.close()
    "

**Attendu** : un tuple avec le nombre d'employés.

---

## 5. Structure du projet

    face-engin/
    │
    ├── api/                          # API FastAPI
    │   ├── __init__.py
    │   └── main.py                   # Endpoints HTTP
    │
    ├── embeddings/                   # Sorties d'enrôlement (dev)
    │   ├── employee_000101/
    │   │   ├── embedding_1.npy
    │   │   ├── embedding_2.npy
    │   │   ├── embedding_3.npy
    │   │   ├── embedding_4.npy
    │   │   └── embedding_5.npy
    │   ├── employee_000102/
    │   ├── employee_000103/
    │   └── employee_000104/
    │
    ├── test_images/                  # Images de test
    │   ├── pers_C_1.jpeg ... C_5.jpeg
    │   ├── pers_D_1.jpeg ... D_5.jpeg
    │   ├── pers_E_1.jpeg ... E_5.jpeg
    │   ├── pers_F_1.jpeg ... F_5.jpeg
    │   ├── personne_A_1.jpg
    │   ├── personne_A_2.jpg
    │   ├── personne_B_1.jpg
    │   ├── resultat_personne_A_1.jpg
    │   ├── resultat_personne_A_2.jpg
    │   ├── resultat_personne_B_1.jpg
    │   ├── back_photo_originales/
    │   └── inconnus/
    │       ├── connu_1.jpeg
    │       ├── inconnu_1.jpeg
    │       ├── inconnu_2.jpeg
    │       ├── inconnu_3.jpeg
    │       └── inconnu_4.jpeg
    │
    ├── models/                       # Cache InsightFace (optionnel)
    │
    ├── db_config.py                  # Configuration MySQL centralisée
    ├── face_core.py                  # SCRFD + ArcFace (classe FaceCore)
    ├── recognition.py                # Reconnaissance depuis .npy
    ├── recognition_mysql.py          # Reconnaissance depuis MySQL
    ├── pointage.py                   # Logique métier du pointage
    │
    ├── enrollment.py                 # Enrôlement depuis fichiers (dev)
    ├── enroll_all.py                 # Enrôlement en batch
    ├── enroll_from_webcam.py         # Enrôlement guidé depuis webcam
    │
    ├── webcam_test.py                # Test reconnaissance webcam
    ├── webcam_pointage.py            # Pointage webcam temps réel
    │
    ├── import_embeddings_to_mysql.py # Import .npy → face_templates
    ├── verify_mysql_embeddings.py    # Vérification round-trip
    │
    ├── test_similarity.py            # Test similarité basique
    ├── test_calibration.py           # Calibration seuil
    ├── test_recognition.py           # Test reconnaissance sur fichiers
    ├── test_employee_101.py          # Test cohérence intra-employé
    ├── test_api.php                  # Test PHP → FastAPI
    │
    ├── requirements.txt              # Dépendances Python (à générer)
    ├── README.md                     # Ce fichier
    └── venv/                         # Environnement virtuel

---

## 6. Pipeline Machine Learning

### 6.1 Vue d'ensemble

    Image
      │
      ▼
    ┌──────────────┐
    │    SCRFD     │  Détection du visage (bbox + landmarks)
    └──────┬───────┘
           ▼
    ┌──────────────┐
    │   ArcFace    │  Extraction d'un embedding 512D
    └──────┬───────┘
           ▼
    ┌──────────────┐
    │ Normalisation│  L2 : ||v|| = 1
    │      L2      │
    └──────┬───────┘
           ▼
    Vecteur (512,) float32 — exploitable pour la comparaison

### 6.2 Modèle utilisé

| Composant | Valeur |
|---|---|
| Modèle InsightFace | `buffalo_l` |
| Détecteur | SCRFD (RetinaFace-like) |
| Reconnaisseur | ArcFace (ResNet-100) |
| Dimension embedding | 512 |
| Type | `float32` |
| Norme avant normalisation | ~20-22 |
| Norme après normalisation | **1.0** |

### 6.3 Comparaison

Deux embeddings normalisés `a` et `b` sont comparés par
**similarité cosinus** :

    similarity = a · b = Σ(aᵢ × bᵢ)

**Interprétation** :

| Score | Signification |
|---|---|
| ~1.0 | Même personne (quasi identique) |
| 0.7 - 0.9 | Même personne (conditions variables) |
| 0.4 - 0.6 | Même personne (conditions difficiles) |
| 0.0 - 0.3 | Personnes différentes |
| < 0.0 | Personnes très différentes (anti-corrélation) |

### 6.4 Seuil de reconnaissance

**Valeur retenue : 0.40**

Calibrée à partir de 40 paires genuine + 150 paires impostor sur 5
employés (voir §13).

---

## 7. Base de données MySQL

### 7.1 Configuration

- **Hôte** : `127.0.0.1` (**PAS** `localhost` — piège XAMPP)
- **Port** : `3306`
- **Utilisateur** : `root`
- **Mot de passe** : *(vide — dev local)*
- **Base** : `bd_arsp`
- **Charset** : `utf8mb4`

### 7.2 Table `employes` (existante)

    CREATE TABLE `employes` (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
      `matricule` varchar(50) NOT NULL,
      `nom` varchar(150) NOT NULL,
      `grade_id` bigint(20) unsigned DEFAULT NULL,
      `service_id` bigint(20) unsigned DEFAULT NULL,
      `date_naissance` date DEFAULT NULL,
      `date_engagement` date DEFAULT NULL,
      `lieu_naissance` varchar(150) DEFAULT NULL,
      `province_origine` varchar(150) DEFAULT NULL,
      `territoire` varchar(150) DEFAULT NULL,
      `localite` varchar(150) DEFAULT NULL,
      `niveau_etude` varchar(150) DEFAULT NULL,
      `user_id` bigint(20) unsigned DEFAULT NULL,
      `emploiyeur` varchar(255) DEFAULT 'ARSP',
      `annee_id` bigint(20) unsigned NOT NULL,
      ...
    )

**Employés enrôlés** (au moment de la rédaction) :

| id | matricule | nom | annee_id |
|---|---|---|---|
| 1 | 201 | Allegresse Umba Malaka | 3 |
| 2 | 202 | Baraka Umnba-Nguz | 3 |
| 3 | 203 | Sephora Nguz | 3 |
| 4 | 204 | Numbi Kabange Guelord | 3 |
| 5 | 205 | Mariclaire Nguz | 3 |

### 7.3 Table `annees` (existante)

    CREATE TABLE `annees` (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
      `annee` year NOT NULL UNIQUE,
      `statut` enum('active','inactive') DEFAULT 'inactive',
      ...
    )

**État actuel** :

| id | annee | statut |
|---|---|---|
| 3 | 2026 | **active** |
| 4 | 2025 | inactive |
| 5 | 2024 | inactive |

### 7.4 Table `face_templates` (existante)

    CREATE TABLE `face_templates` (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
      `employe_id` bigint(20) unsigned NOT NULL,
      `face_embedding` varbinary(3000) NOT NULL,
      `annee_id` bigint(20) unsigned NOT NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      PRIMARY KEY (`id`),
      FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
      FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`)
    )

**Contenu** : 5 embeddings × 5 employés = **25 lignes**.

### 7.5 Table `presences` (existante)

    CREATE TABLE `presences` (
      `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
      `employe_id` bigint(20) unsigned NOT NULL,
      `DATE` date NOT NULL,
      `heure` time NOT NULL,
      `mouvement` enum('entree','sortie') NOT NULL,
      `score_reconnaissance` decimal(6,5) DEFAULT NULL,
      `annee_id` bigint(20) unsigned NOT NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      PRIMARY KEY (`id`),
      FOREIGN KEY (`employe_id`) REFERENCES `employes` (`id`),
      FOREIGN KEY (`annee_id`) REFERENCES `annees` (`id`)
    )

**Règle métier** : 1 `entree` + 1 `sortie` maximum par employé
par jour.

### 7.6 Requêtes utiles

    -- Voir tous les templates d'un employé
    SELECT id, employe_id, LENGTH(face_embedding) AS taille
    FROM face_templates
    WHERE employe_id = 5;

    -- Voir les pointages du jour
    SELECT e.nom, p.heure, p.mouvement, p.score_reconnaissance
    FROM presences p
    JOIN employes e ON e.id = p.employe_id
    WHERE p.DATE = CURDATE()
    ORDER BY p.heure;

    -- Année active
    SELECT id, annee FROM annees WHERE statut = 'active';

---

## 8. Modules Python

### 8.1 `db_config.py`

Configuration centralisée MySQL.

    DB_CONFIG = {
        "host":     "127.0.0.1",
        "port":     3306,
        "user":     "root",
        "password": "",
        "database": "bd_arsp",
        "charset":  "utf8mb4",
    }

### 8.2 `face_core.py`

Classe `FaceCore` — socle technique partagé.

**Responsabilités** :

- Initialiser InsightFace (SCRFD + ArcFace)
- Détecter le visage principal d'une image
- Extraire et normaliser un embedding

**API** :

    core = FaceCore()
    
    # Depuis une image numpy (BGR)
    face = core.extract_from_image(img)
    # → {embedding, bbox, det_score, n_faces} ou None
    
    # Depuis un fichier
    face = core.extract_from_file("photo.jpg")

### 8.3 `recognition.py`

Classe `FaceRecognizer` — reconnaissance depuis fichiers `.npy`.

**Usage** :

    recognizer = FaceRecognizer(seuil=0.40)
    recognizer.load_employees_from_disk("embeddings", metadata={...})
    result = recognizer.recognize_image(img)
    # → RecognitionResult(employe_id, nom, matricule, score, bbox, reconnu)

### 8.4 `recognition_mysql.py`

Classe `FaceRecognizerMySQL` — reconnaissance depuis MySQL.

**Usage** :

    recognizer = FaceRecognizerMySQL(seuil=0.40)
    recognizer.load_employees()   # ← lit depuis MySQL
    result = recognizer.recognize_image(img)

**Différence** : les embeddings viennent de la table `face_templates`
(jointure avec `employes` pour nom + matricule).

### 8.5 `pointage.py`

Logique métier du pointage.

**Fonctions** :

    # Tente d'enregistrer un pointage
    result, mouvement = try_pointage(employe_id, score)
    
    # result ∈ {
    #   ENTREE_OK, SORTIE_OK,
    #   DEJA_COMPLET, COOLDOWN, ERREUR
    # }

**Règles** :

- 1 entrée + 1 sortie max par jour
- Cooldown 30 secondes par employé
- Écriture dans `presences`

### 8.6 `enroll_from_webcam.py`

Enrôlement guidé depuis la webcam.

**Déroulé** :

1. Liste les employés (avec nombre de templates actuels)
2. Demande confirmation si l'employé a déjà des templates
3. Ouvre la webcam
4. Guide l'utilisateur à travers 5 consignes photos :
   - 1/5 : Face neutre, de face
   - 2/5 : Tourner légèrement à GAUCHE
   - 3/5 : Tourner légèrement à DROITE
   - 4/5 : Lever légèrement la tête
   - 5/5 : Expression normale (avec accessoires habituels)
5. ESPACE pour capturer, 'q' pour annuler
6. Insertion des 5 embeddings dans `face_templates`

### 8.7 `webcam_pointage.py`

Script principal de pointage en temps réel.

**Déroulé** :

1. Charge les employés depuis MySQL
2. Ouvre la webcam (index 1 par défaut)
3. Reconnaissance toutes les 5 frames
4. Affichage : nom + matricule + score + message
5. Écriture automatique dans `presences`
6. 'q' pour quitter

---

## 9. API FastAPI

### 9.1 Lancement

    cd face-engin
    python -m uvicorn api.main:app --reload --port 8001

**Note** : le port 8000 peut être occupé par un autre service sur
certaines machines. On utilise **8001** par convention.

**Sortie attendue** :

    [API] Initialisation du moteur de reconnaissance...
    [API] 5 employés chargés.
    INFO:     Uvicorn running on http://127.0.0.1:8001
    INFO:     Application startup complete.

### 9.2 Documentation interactive

Ouvrir dans le navigateur :

    http://127.0.0.1:8001/docs

Swagger UI affiche tous les endpoints avec la possibilité de les
tester directement.

### 9.3 Endpoints

#### `GET /health`

Vérifie que l'API tourne.

    curl http://127.0.0.1:8001/health

**Réponse** :

    {
      "status": "ok",
      "employes_charges": 5,
      "seuil": 0.4
    }

#### `GET /employees`

Liste les employés enrôlés.

    curl http://127.0.0.1:8001/employees

**Réponse** :

    [
      {"employe_id": 1, "nom": "Allegresse Umba Malaka",
       "matricule": "201", "nb_embeddings": 5},
      ...
    ]

#### `POST /recognize`

Reconnaît un visage dans une image uploadée.

    curl -X POST http://127.0.0.1:8001/recognize \
         -F "file=@photo.jpg"

**Réponse (succès)** :

    {
      "employe_id": 4,
      "nom": "Numbi Kabange Guelord",
      "matricule": "204",
      "score": 0.77477,
      "reconnu": true,
      "bbox": [194, 274, 398, 564]
    }

**Réponse (inconnu)** :

    {
      "employe_id": -1,
      "nom": "INCONNU",
      "matricule": "",
      "score": 0.13,
      "reconnu": false,
      "bbox": [...]
    }

**Erreurs** :

| Code | Cause |
|---|---|
| 400 | Fichier non-image ou MIME type incorrect |
| 422 | Aucun visage détecté dans l'image |

### 9.4 Format d'upload

- **Méthode** : `POST`
- **Content-Type** : `multipart/form-data`
- **Champ** : `file` (type `UploadFile`)
- **Types acceptés** : `image/jpeg`, `image/png`, etc.

---

## 10. Intégration PHP

### 10.1 Test simple (cURL)

    <?php
    $ch = curl_init('http://127.0.0.1:8001/recognize');
    $mime = mime_content_type($image_path) ?: 'image/jpeg';
    
    curl_setopt_array($ch, [
        CURLOPT_POST           => true,
        CURLOPT_POSTFIELDS     => [
            'file' => new CURLFile($image_path, $mime, basename($image_path)),
        ],
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 30,
        CURLOPT_HTTPHEADER     => ['Accept: application/json'],
    ]);
    
    $response = curl_exec($ch);
    $http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    $data = json_decode($response, true);

**⚠️ Important** : le 2ème argument de `CURLFile` (MIME type) doit
être explicite. Sinon, FastAPI reçoit `application/octet-stream` et
refuse le fichier (erreur 400).

### 10.2 Utilisation dans Laravel

**Option recommandée** : via `Illuminate\Support\Facades\Http`.

    use Illuminate\Support\Facades\Http;
    
    $response = Http::attach(
        'file',
        file_get_contents($image_path),
        'photo.jpg'
    )->post('http://127.0.0.1:8001/recognize');
    
    $result = $response->json();

**Configuration dans `.env`** :

    FACE_API_URL=http://127.0.0.1:8001

**Utilisation** :

    ->post(env('FACE_API_URL') . '/recognize')

---

## 11. Guide d'utilisation

### 11.1 Premier lancement

**1. Démarrer XAMPP**

    sudo /opt/lampp/lampp start

**2. Activer le venv**

    cd face-engin
    source venv/bin/activate

**3. Lancer FastAPI (dans un terminal dédié)**

    python -m uvicorn api.main:app --reload --port 8001

**4. Lancer le pointage (dans un autre terminal)**

    python webcam_pointage.py

### 11.2 Enrôler un nouvel employé

**Prérequis** : l'employé doit exister dans la table `employes`.

**1. Créer l'employé côté Laravel** (ou via phpMyAdmin/SQL)

**2. Lancer l'enrôlement**

    python enroll_from_webcam.py

**3. Suivre les instructions à l'écran**

L'employé doit :

- Être bien éclairé (pas de contre-jour)
- Regarder la caméra
- Suivre les 5 consignes (visage neutre → gauche → droite → haut → accessoires)

**4. Vérifier en base**

    sudo /opt/lampp/bin/mysql -u root bd_arsp -e "
    SELECT employe_id, COUNT(*) AS nb
    FROM face_templates
    GROUP BY employe_id;
    "

### 11.3 Pointage en temps réel

    python webcam_pointage.py

**Comportement attendu** :

| Situation | Affichage |
|---|---|
| Visage reconnu (1er pointage) | `✅ ENTREE enregistree` |
| Visage reconnu (2e pointage) | `✅ SORTIE enregistree` |
| Visage reconnu (3e+ pointage) | `Deja pointe aujourd'hui` |
| Visage inconnu | `INCONNU  (0.XX)` en rouge |
| Re-détection < 30s | Silencieux (cooldown) |

### 11.4 Vérifier les pointages

    sudo /opt/lampp/bin/mysql -u root bd_arsp -e "
    SELECT e.nom, p.DATE, p.heure, p.mouvement, p.score_reconnaissance
    FROM presences p
    JOIN employes e ON e.id = p.employe_id
    WHERE p.DATE = CURDATE()
    ORDER BY p.heure;
    "

### 11.5 Importer des embeddings depuis .npy

Si tu as enrôlé via `enrollment.py` (mode fichiers) :

    python import_embeddings_to_mysql.py
    python verify_mysql_embeddings.py

---

## 12. Conventions techniques

### 12.1 Sérialisation des embeddings

**Format retenu** : `float32` little-endian (`<f4`)

| Langage | Conversion |
|---|---|
| Python (écriture) | `embedding.astype("<f4").tobytes()` |
| Python (lecture)   | `np.frombuffer(blob, dtype="<f4")` |
| PHP (écriture)     | `pack('g*', ...$floats)` |
| PHP (lecture)      | `unpack('g*', $blob)` |

**Taille attendue** : **2048 octets** (512 × 4).

**Règle** : ne JAMAIS utiliser `>` (big-endian) ou `f8`
(double). Cela casserait la cohérence entre Python et PHP.

### 12.2 Normalisation L2

**Toujours normaliser** avant de stocker ou de comparer :

    norm = np.linalg.norm(embedding)
    embedding_normalise = embedding / norm

**Conséquence** : `similarité(v, v) = 1.0` exactement.

### 12.3 Seuil de reconnaissance

**Valeur actuelle** : `0.40`

**Modification** : dans `webcam_pointage.py`, `api/main.py`, etc.

**Justification** : voir §13 (calibration).

### 12.4 Chemins de fichiers

- **Dev** : chemins relatifs (`embeddings/...`, `test_images/...`)
- **Production** : chemins absolus (configurables via `.env`)

### 12.5 Ports

| Service | Port |
|---|---|
| Apache (Laravel) | 80 |
| MySQL (XAMPP) | 3306 |
| FastAPI | **8001** (le 8000 est souvent occupé) |

---

## 13. Résultats obtenus

### 13.1 Calibration du seuil

**Méthode** : 40 paires genuine (même personne) + 150 paires
impostor (personnes différentes), sur 5 employés × 5 photos.

**Distribution genuine** :

| Statistique | Valeur |
|---|---|
| Nombre | 40 |
| Moyenne | 0.6341 |
| Écart-type | 0.1079 |
| Min | 0.3920 |
| Max | 0.8896 |
| 5e percentile | 0.4750 |

**Distribution impostor** :

| Statistique | Valeur |
|---|---|
| Nombre | 150 |
| Moyenne | 0.0888 |
| Écart-type | 0.0807 |
| Min | -0.0789 |
| Max | 0.2929 |
| 95e percentile | 0.2309 |

**Séparation** :

    Max impostor : 0.2929
    Min genuine  : 0.3920
    → Zone vide : [0.29 , 0.39]
    → Séparation parfaite sur ce jeu

**Seuil retenu** : **0.40**

Justification : légèrement au-dessus du min genuine (marge de
sécurité pour les conditions webcam réelles).

### 13.2 Validation en conditions réelles

**Test webcam** (6 captures, avec accessoires) :

| Cas | Score |
|---|---|
| Employé 4 (contre-jour, lunettes, foulard) | 0.43 |
| Employé 4 (éclairage OK) | 0.60 |
| Employé 4 (photo d'écran) | 0.62 |
| Employé 3 (nouvelle photo) | 0.49 |
| Employé 3 (angle différent) | 0.41 |
| Inconnu | 0.13 |

**Conclusion** : 6/6 corrects, marge confortable de part et d'autre
du seuil 0.40.

### 13.3 Vérification round-trip

**Python ↔ MySQL** : `max|Δ| = 0.000e+00` sur les 25 embeddings.

**PHP ↔ FastAPI** : score 1.0 sur photo d'enrôlement (attendu),
score 0.77 sur photo différente (attendu).

### 13.4 Performance

| Étape | Temps approximatif (CPU) |
|---|---|
| SCRFD (détection) | 80-150 ms |
| ArcFace (embedding) | 50-100 ms |
| Comparaison (25 embeddings) | < 1 ms |
| **Total par frame** | **150-250 ms** (~4-6 FPS) |

Sur CPU uniquement. Optimisable via `buffalo_sc` ou GPU CUDA.

---

## 14. Dépannage

### 14.1 Problèmes MySQL

#### `ERROR 2002: Can't connect to local MySQL server through socket`

**Cause** : le client `mysql` cherche le serveur système, mais seul
XAMPP est actif.

**Solution** : utiliser le client de XAMPP :

    sudo /opt/lampp/bin/mysql -u root bd_arsp

#### Python ne se connecte pas à MySQL

**Cause** : `host='localhost'` au lieu de `host='127.0.0.1'`.

**Solution** : dans `db_config.py`, toujours utiliser `127.0.0.1`.

### 14.2 Problèmes webcam

#### `can't open camera by index`

**Cause** : mauvais index de caméra (Iriun Webcam occupe video0).

**Solution** :

    v4l2-ctl --list-devices
    # Identifier la vraie webcam (Integrated_Webcam_HD)
    # Utiliser l'index correspondant (souvent 1 ou 2)

#### `QFontDatabase: Cannot find font directory`

**Cause** : avertissement OpenCV/Qt sur la gestion des polices.
**Impact** : aucun (avertissement seulement).

**Solution** : ignorer, ou installer les polices :

    sudo apt install fonts-dejavu

### 14.3 Problèmes FastAPI

#### `Address already in use` (port 8000)

**Cause** : un autre service utilise le port 8000.

**Solution** : utiliser un autre port :

    python -m uvicorn api.main:app --reload --port 8001

#### `Fichier non-image : application/octet-stream`

**Cause** : PHP envoie le fichier sans MIME type explicite.

**Solution** : forcer le MIME type :

    new CURLFile($path, 'image/jpeg', basename($path))

### 14.4 Problèmes de reconnaissance

#### Scores trop bas (< 0.40)

**Causes possibles** :

- Éclairage en contre-jour
- Angle trop important
- Photos d'enrôlement de mauvaise qualité

**Solutions** :

- Ré-enrôler avec des conditions variées
- Éviter les contre-jours à l'usage
- Baisser temporairement le seuil à 0.35 (non recommandé en prod)

#### `Aucun visage détecté`

**Causes** :

- Visage trop petit dans l'image
- Image floue
- Visage de profil (> 45°)

**Solution** : l'utilisateur doit se rapprocher et se tourner vers
la caméra.

---

## 15. Roadmap

### Fait ✅

- [x] Environnement Python + InsightFace
- [x] Détection SCRFD
- [x] Embeddings ArcFace 512D
- [x] Comparaison cosinus
- [x] Enrôlement multi-photos (5 par employé)
- [x] Calibration du seuil (0.40)
- [x] Reconnaissance webcam temps réel
- [x] Stockage MySQL (`face_templates`)
- [x] Pointage automatique (`presences`)
- [x] Règle métier entrée/sortie + cooldown
- [x] Enrôlement guidé webcam
- [x] API FastAPI (3 endpoints)
- [x] Test d'intégration PHP → FastAPI

### En cours ⏳

- [ ] Intégration Laravel propre
  - [ ] Service `FaceRecognitionService`
  - [ ] Contrôleur `FaceRecognitionController`
  - [ ] Routes API
  - [ ] Vue Blade avec caméra JS

### À venir 📋

- [ ] Page "Pointages du jour" (interface superviseur)
- [ ] Workflow de validation (le superviseur valide les pointages)
- [ ] Page "Historique employé X"
- [ ] Multi-visages simultanés
- [ ] Optimisation (GPU, `buffalo_sc`, cache)
- [ ] Tests de robustesse (angles extrêmes, faible lumière)
- [ ] Documentation utilisateur finale
- [ ] Déploiement production (Laravel + FastAPI)

---

## Annexes

### A. Commandes utiles

**Démarrer XAMPP**

    sudo /opt/lampp/lampp start

**Voir l'état**

    sudo /opt/lampp/lampp status

**MySQL CLI**

    sudo /opt/lampp/bin/mysql -u root bd_arsp

**Lancer FastAPI**

    python -m uvicorn api.main:app --reload --port 8001

**Lancer le pointage**

    python webcam_pointage.py

**Lancer l'enrôlement**

    python enroll_from_webcam.py

### B. Fichiers critiques à ne pas modifier sans précaution

- `db_config.py` — change la connexion MySQL
- `face_core.py` — change le modèle ML
- `pointage.py` — change la logique métier
- `api/main.py` — change l'API publique

### C. Contacts

**Développeur** : [Parfait Zix  Alias Lufungula Patrick]
**Contexte** : Stage / Projet ARSP
**Date de rédaction** : Septembre 2026
**Dernière mise à jour** : [à compléter]

---

*Documentation redigée dans le cadre du projet ARSP face-engin.*