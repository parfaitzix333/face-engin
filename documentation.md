# Intégration de l'API FACE-INGIN-ZIX dans Laravel, React et Django

Ce document explique comment connecter une application à l'API FastAPI de reconnaissance faciale du projet. L'API analyse une image et retourne le résultat de reconnaissance; l'application intégratrice reste responsable de l'authentification, de l'autorisation et de l'enregistrement éventuel d'un pointage.

## 1. Architecture et périmètre

Le flux recommandé est le suivant :

```text
Navigateur (React ou Blade)
        | image capturée ou choisie
        v
Backend de l'application (Laravel ou Django)
        | POST multipart/form-data
        v
FastAPI (réseau interne, port 8001)
```

Le navigateur devrait appeler le backend de l'application, et non FastAPI directement. Cela évite d'exposer l'API de reconnaissance, facilite l'authentification et évite de configurer CORS pour FastAPI.

L'API disponible dans `api/main.py` expose uniquement :

| Méthode | Route | Fonction |
|---|---|---|
| `GET` | `/health` | État du service, nombre d'employés chargés et seuil courant |
| `GET` | `/employees` | Liste des employés enrôlés |
| `POST` | `/recognize` | Reconnaissance d'une image transmise sous le champ multipart `file` |

Les routes d'enrôlement et de pointage ne sont pas exposées par cette API. Après une reconnaissance positive, Laravel ou Django doit appliquer ses propres règles métier avant d'écrire un pointage.

## 2. Démarrer et vérifier FastAPI

Depuis la racine de `face-engin`, avec l'environnement virtuel activé et MySQL configuré :

```bash
python -m uvicorn api.main:app --host 127.0.0.1 --port 8001
```

Le chargement du moteur et des employés a lieu au démarrage. L'import de `api.main` initialise le reconnaisseur et accède à MySQL; le service nécessite donc une base accessible et les modèles InsightFace présents ou téléchargeables.

Vérifier le service :

```bash
curl -i http://127.0.0.1:8001/health
curl -i http://127.0.0.1:8001/employees
```

Documentation interactive FastAPI : <http://127.0.0.1:8001/docs>.

### Contrat de `POST /recognize`

Envoyer un fichier image en `multipart/form-data`, avec le nom de champ `file`. Types MIME image courants acceptés : `image/jpeg`, `image/png`, etc.

Exemple :

```bash
curl -i -X POST http://127.0.0.1:8001/recognize \
  -F 'file=@test_images/personne_A_1.jpg;type=image/jpeg'
```

Réponse en cas de visage détecté (`200 OK`) :

```json
{
  "employe_id": 101,
  "nom": "Nom de l'employé",
  "matricule": "201",
  "score": 0.82,
  "reconnu": true,
  "bbox": [120, 70, 340, 310]
}
```

Les valeurs sont illustratives. `reconnu` indique si la correspondance satisfait le seuil configuré; un résultat `reconnu: false` n'est pas une erreur HTTP. `bbox` contient les coordonnées du visage dans l'image et `score` le score retourné par le reconnaisseur.

Erreurs prévues :

| Statut | Signification |
|---|---|
| `400` | Le fichier n'est pas déclaré comme image ou son contenu est illisible |
| `422` | Aucun visage n'a été détecté |
| `5xx` | Erreur interne ou dépendance indisponible; vérifier les journaux FastAPI et MySQL |

FastAPI retourne généralement le détail d'erreur dans une propriété JSON `detail`.







=======================================================
## 3. Intégration Laravel
=======================================================

Les exemples conviennent à Laravel 10/11. Conserver l'adresse FastAPI dans la configuration serveur, pas dans le code JavaScript du navigateur.

### 3.1 Configuration

Dans `.env` de Laravel :

```dotenv
FACE_API_URL=http://127.0.0.1:8001
```

Dans `config/services.php` :

```php
'face_api' => [
    'url' => env('FACE_API_URL', 'http://127.0.0.1:8001'),
],
```

Si Laravel et FastAPI tournent dans des conteneurs distincts, `127.0.0.1` désigne le conteneur Laravel lui-même. Utiliser alors le nom DNS interne du service FastAPI, par exemple `http://face-api:8001`.

### 3.2 Service HTTP

Créer `app/Services/FaceRecognitionService.php` :

```php
<?php

namespace App\Services;

use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Http;
use RuntimeException;

class FaceRecognitionService
{
    public function recognize(UploadedFile $image): array
    {
        $path = $image->getRealPath();
        $contents = file_get_contents($path);

        if ($contents === false) {
            throw new RuntimeException('Impossible de lire le fichier image.');
        }

        try {
            $response = Http::timeout(30)
                ->attach(
                    'file',
                    $contents,
                    $image->getClientOriginalName(),
                    ['Content-Type' => $image->getMimeType()]
                )
                ->post(rtrim(config('services.face_api.url'), '/') . '/recognize');
        } catch (ConnectionException $exception) {
            throw new RuntimeException('Le service de reconnaissance est indisponible.', 0, $exception);
        }

        if ($response->failed()) {
            throw new RuntimeException(
                'Erreur du service de reconnaissance : ' . $response->body(),
                $response->status()
            );
        }

        return $response->json();
    }
}
```

### 3.3 Contrôleur et route

Le contrôleur valide l'entrée et relaie la réponse JSON. Ajouter le middleware d'authentification et d'autorisation adapté à l'application.

```php
<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\FaceRecognitionService;
use Illuminate\Http\Request;
use RuntimeException;

class FaceRecognitionController extends Controller
{
    public function recognize(Request $request, FaceRecognitionService $service)
    {
        $validated = $request->validate([
            'file' => ['required', 'image', 'max:10240'],
        ]);

        try {
            return response()->json($service->recognize($validated['file']));
        } catch (RuntimeException $exception) {
            return response()->json([
                'message' => 'La reconnaissance n’a pas pu être effectuée.',
            ], 502);
        }
    }
}
```

Dans `routes/api.php` :

```php
use App\Http\Controllers\Api\FaceRecognitionController;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->post(
    '/face/recognize',
    [FaceRecognitionController::class, 'recognize']
);
```

Adaptez `auth:sanctum` au mécanisme d'authentification déjà employé. La route sera alors `POST /api/face/recognize`.

### 3.4 Test Laravel du relais

Avec `Http::fake`, le test ne nécessite pas de démarrer FastAPI :

```php
<?php

namespace Tests\Feature;

use Illuminate\Http\Client\Request as ClientRequest;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class FaceRecognitionTest extends TestCase
{
    public function test_it_relays_an_image_to_the_face_api(): void
    {
        Http::fake([
            '127.0.0.1:8001/recognize' => Http::response([
                'employe_id' => 101,
                'nom' => 'Employé Exemple',
                'matricule' => '201',
                'score' => 0.82,
                'reconnu' => true,
                'bbox' => [120, 70, 340, 310],
            ], 200),
        ]);

        $response = $this->withHeaders(['Accept' => 'application/json'])
            ->post('/api/face/recognize', [
            'file' => UploadedFile::fake()->image('visage.jpg'),
        ]);

        $response->assertOk()
            ->assertJsonPath('employe_id', 101)
            ->assertJsonPath('reconnu', true);

        Http::assertSent(fn (ClientRequest $request) =>
            str_ends_with($request->url(), '/recognize')
            && $request->method() === 'POST'
        );
    }

    public function test_it_rejects_a_non_image_upload(): void
    {
        $response = $this->withHeaders(['Accept' => 'application/json'])
            ->post('/api/face/recognize', [
            'file' => UploadedFile::fake()->create('note.txt', 1, 'text/plain'),
        ]);

        $response->assertUnprocessable()
            ->assertJsonValidationErrors('file');
    }
}
```

Selon la configuration de l'application, authentifier le client de test avec `actingAs(...)` ou configurer la route de test sans middleware. Lancer :

```bash
php artisan test --filter=FaceRecognitionTest
```












===================================================================
## 4. Intégration React
===================================================================

React ne doit pas contenir l'adresse privée de FastAPI ni appeler directement ce service en production. Il envoie l'image à la route Laravel ou Django, qui relaie le fichier côté serveur.

Exemple minimal de composant d'upload :

```jsx
import { useState } from 'react';

export function FaceRecognitionForm() {
  const [image, setImage] = useState(null);
  const [result, setResult] = useState(null);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  async function submit(event) {
    event.preventDefault();
    if (!image) return;

    setLoading(true);
    setError('');
    setResult(null);

    const body = new FormData();
    body.append('file', image);

    try {
      const response = await fetch('/api/face/recognize', {
        method: 'POST',
        body,
        credentials: 'same-origin',
        headers: {
          Accept: 'application/json',
          // Ajouter ici le jeton CSRF ou Bearer exigé par le backend.
        },
      });
      const data = await response.json();

      if (!response.ok) {
        throw new Error(data.message ?? data.detail ?? `Erreur HTTP ${response.status}`);
      }

      setResult(data);
    } catch (requestError) {
      setError(requestError.message || 'Échec de la requête.');
    } finally {
      setLoading(false);
    }
  }

  return (
    <form onSubmit={submit}>
      <label>
        Image du visage
        <input
          type="file"
          accept="image/*"
          capture="user"
          onChange={(event) => setImage(event.target.files?.[0] ?? null)}
        />
      </label>
      <button type="submit" disabled={!image || loading}>
        {loading ? 'Analyse...' : 'Reconnaître'}
      </button>
      {error && <p role="alert">{error}</p>}
      {result && (
        <section aria-live="polite">
          <p>{result.reconnu ? 'Employé reconnu' : 'Identité non confirmée'}</p>
          <p>{result.nom} ({result.matricule})</p>
          <p>Score : {result.score}</p>
        </section>
      )}
    </form>
  );
}
```

Ne définissez pas manuellement l'en-tête `Content-Type` pour `FormData`; le navigateur doit ajouter lui-même le séparateur multipart. Si React et son backend sont sur des origines différentes, configurer CORS sur le backend de l'application et envoyer les identifiants/jetons selon son mécanisme d'authentification. Préférer une URL relative lorsque le frontend est servi par le même domaine.

### Test React

Tester au minimum les états suivants avec l'outil de test déjà utilisé par le frontend (par exemple Vitest et React Testing Library) :

1. Choisir une image et soumettre : la requête contient un `FormData` avec `file` et le résultat reconnu s'affiche.
2. Réponse `200` avec `reconnu: false` : afficher une identité non confirmée, sans considérer la requête comme échouée.
3. Réponse `422` ou réseau indisponible : afficher une erreur et réactiver le bouton après la fin de la requête.
4. Aucun fichier choisi : le bouton reste désactivé.

Un test de navigateur manuel peut aussi être fait avec une image de test : ouvrir l'onglet Réseau, vérifier `POST /api/face/recognize`, le statut HTTP et la réponse JSON. Ne pas utiliser une vraie photo d'employé dans les journaux ou captures de test partagés.








====================================================================
## 5. Intégration Django
======================================================================

Installer `requests` dans l'environnement Django si nécessaire :

```bash
pip install requests
```

Configurer l'URL FastAPI dans les paramètres de déploiement (ne pas la fournir au frontend) :

```python
# settings.py
FACE_API_URL = "http://127.0.0.1:8001"
```

### 5.1 Vue relais

Exemple dans `views.py` :

```python
import requests
from django.conf import settings
from django.http import JsonResponse
from django.views.decorators.http import require_POST


@require_POST
def recognize_face(request):
    uploaded = request.FILES.get("file")
    if uploaded is None:
        return JsonResponse({"message": "Le champ file est obligatoire."}, status=400)

    if not uploaded.content_type or not uploaded.content_type.startswith("image/"):
        return JsonResponse({"message": "Le fichier doit être une image."}, status=400)

    try:
        response = requests.post(
            f"{settings.FACE_API_URL.rstrip('/')}/recognize",
            files={
                "file": (
                    uploaded.name,
                    uploaded.file,
                    uploaded.content_type,
                )
            },
            timeout=30,
        )
    except requests.RequestException:
        return JsonResponse({"message": "Le service de reconnaissance est indisponible."}, status=502)

    try:
        payload = response.json()
    except ValueError:
        return JsonResponse({"message": "Réponse invalide du service de reconnaissance."}, status=502)

    return JsonResponse(payload, status=response.status_code)
```

Dans `urls.py` :

```python
from django.urls import path
from .views import recognize_face

urlpatterns = [
    path("api/face/recognize", recognize_face, name="face-recognize"),
]
```

Protéger cette vue par l'authentification et les permissions du projet (par exemple `login_required` ou une permission DRF). La protection CSRF reste active pour les formulaires utilisant une session Django.

### 5.2 Test Django de la vue

Le mock ci-dessous vérifie le relais sans lancer FastAPI :

```python
from unittest.mock import Mock, patch

from django.core.files.uploadedfile import SimpleUploadedFile
from django.test import TestCase, override_settings
from django.urls import reverse


@override_settings(FACE_API_URL="http://127.0.0.1:8001")
class FaceRecognitionViewTests(TestCase):
    @patch("myapp.views.requests.post")
    def test_relays_uploaded_image(self, post):
        upstream = Mock()
        upstream.status_code = 200
        upstream.json.return_value = {
            "employe_id": 101,
            "nom": "Employé Exemple",
            "matricule": "201",
            "score": 0.82,
            "reconnu": True,
            "bbox": [120, 70, 340, 310],
        }
        post.return_value = upstream
        image = SimpleUploadedFile(
            "visage.jpg", b"image-test", content_type="image/jpeg"
        )

        response = self.client.post(reverse("face-recognize"), {"file": image})

        self.assertEqual(response.status_code, 200)
        self.assertTrue(response.json()["reconnu"])
        post.assert_called_once()
        self.assertEqual(post.call_args.kwargs["timeout"], 30)
        self.assertIn("file", post.call_args.kwargs["files"])

    def test_rejects_missing_file(self):
        response = self.client.post(reverse("face-recognize"), {})

        self.assertEqual(response.status_code, 400)
```

Remplacer `myapp.views` par le chemin Python réel de la vue. Exécuter :

```bash
python manage.py test myapp
```

## 6. Vérifications d'intégration de bout en bout

Ces vérifications nécessitent FastAPI en cours d'exécution, MySQL accessible, au moins un employé enrôlé et une image de test valide.

```bash
# Service démarré
curl -f http://127.0.0.1:8001/health

# Liste des employés (peut être vide si aucun template n'est chargé)
curl -f http://127.0.0.1:8001/employees

# Reconnaissance d'une image avec visage
curl -i -X POST http://127.0.0.1:8001/recognize \
  -F 'file=@test_images/personne_A_1.jpg;type=image/jpeg'

# Erreur attendue : fichier non-image, statut 400
curl -i -X POST http://127.0.0.1:8001/recognize \
  -F 'file=@README.md;type=text/plain'
```

Tester aussi une vraie image sans visage : l'API doit répondre `422`. Une image contenant un visage non enrôlé devrait généralement répondre `200` avec `reconnu: false`; ce cas vérifie le contrat de décision et non une erreur de transport.

Critères d'acceptation pour Laravel/Django :

- le backend rejette une requête sans fichier ou un fichier non-image;
- le backend transmet le fichier au champ `file` de FastAPI;
- le JSON de reconnaissance est relayé au frontend;
- les erreurs `400`, `422`, `502` et `5xx` sont présentées sans exposer les détails internes de la base ou du serveur;
- aucun pointage n'est enregistré lorsqu'aucune identité n'est reconnue;
- les règles de doublon, cooldown et entrée/sortie sont appliquées côté serveur si le pointage est activé.

## 7. Sécurité et données biométriques

- Garder FastAPI sur une interface/réseau privé; ne pas publier le port `8001` sur Internet.
- L'API actuelle ne comporte pas d'authentification. Restreindre l'accès réseau au backend Laravel/Django ou placer un proxy authentifié devant elle avant tout déploiement partagé.
- Utiliser HTTPS entre navigateur et backend, et entre services si le réseau de déploiement l'exige.
- Limiter la taille, le type et la fréquence des uploads; ne pas conserver les images reçues sans nécessité documentée.
- Traiter les images faciales et les résultats d'identification comme des données sensibles : définir les habilitations, la durée de conservation et la base légale/consentement applicables.
- Le score seul ne doit pas déclencher une décision importante sans contrôle métier approprié. Le seuil actuel est configuré à `0.40` dans `api/main.py`; il doit être validé sur des données représentatives avant production.
