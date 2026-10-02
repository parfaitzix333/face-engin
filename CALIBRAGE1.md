CALIBRATION — 26/09/2026
────────────────────────
Genuine  : moy=0.6341, min=0.3920, 5e pct=0.4750
Impostor : moy=0.0888, max=0.2929, 95e pct=0.2309

GAP : [0.2929 - 0.3920]  (aucun chevauchement)
SEUIL PRÉLIMINAIRE : 0.40

---------------------------------------------------
[✓] Webcam temps réel fonctionne
[✓] Détection + reconnaissance en direct
[✓] Le système résiste aux mauvaises conditions (contre-jour, reflets)
[✓] Le système fonctionne au travers d'un écran (photos de téléphone)
[✓] Le système généralise à d'autres personnes (102 reconnu, pas seulement 101)
[✓] Le système résiste aux angles différents
[✓] Le système rejette correctement les inconnus
[✓] Le seuil 0.40 est bien placé

-------------------------------------------------------
test de 6 images:
-----------------------------------------
Score
  │
0.6│      ●(101 éclairage OK)   ●(101 photo écran)
  │
0.5│           ●(102 nouvelle photo)
  │
0.4├───────────●(102 angle) ─────── SEUIL ──────────
  │      ●(101 contre-jour)
0.3│
  │
0.2│
  │
0.1│                     ●(inconnu)
  │
  └───────────────────────────────────────────────►
        Genuines              Impostor
     (0.41 ─ 0.62)             (0.13)




=============================================================================
=====================étape suivante==============================================
[✓] Base technique (détection, embedding, comparaison)
[✓] Enrôlement
[✓] Reconnaissance temps réel
[✓] Affichage nom + matricule
│
[ ] Enrôlement depuis la webcam (pratique pour les vrais employés)
[ ] Refactor de enrollment.py pour utiliser face_core.py
[ ] Gestion de plusieurs visages simultanés
[ ] Enregistrement des pointages (entrée/sortie)
[ ] Stockage en base MySQL (face_templates)
[ ] API FastAPI (endpoints /recognize, /enroll)
[ ] Intégration Laravel (page web + JS caméra)
[ ] Optimisation vitesse (buffalo_sc, CUDA, etc.)
[ ] Tests de robustesse (angles extrêmes, faible lumière, etc.)



=================================================================================
===========================etape suivante=========================================
[✓] Environnement Python + InsightFace
[✓] SCRFD détection
[✓] ArcFace embeddings 512D
[✓] Comparaison cosinus
[✓] Enrôlement multi-photos (5 employés)
[✓] Calibration seuil (0.40)
[✓] Reconnaissance webcam temps réel
[✓] MySQL : face_templates (25 embeddings)
[✓] MySQL : pointage dans presences
[✓] Règle métier entrée/sortie + cooldown
[✓] Enrôlement webcam (5 photos guidées)
[✓] FastAPI (3 endpoints)
[✓] PHP → FastAPI (cURL)
[→] Intégration Laravel propre


=================================================================================
===========================etape suivante=========================================
Plan pour l'intégration Laravel
----------------------------

Phase 1 — Service Laravel qui appelle FastAPI
   ├─ app/Services/FaceRecognitionService.php
   └─ Configuration URL FastAPI dans .env

Phase 2 — Controller + Route
   ├─ app/Http/Controllers/FaceRecognitionController.php
   └─ routes/web.php : POST /api/face/recognize

Phase 3 — Vue Blade avec caméra JS
   ├─ resources/views/face/pointage.blade.php
   └─ resources/js/face-camera.js (getUserMedia + POST)

Phase 4 — Tableau de bord pointage
   ├─ Page "Pointages du jour"
   └─ Page "Historique employé X"