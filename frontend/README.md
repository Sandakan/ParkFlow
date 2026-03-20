# ParkFlow Client (Flutter)

Official repository: [github.com/Sandakan/ParkFlow](https://github.com/Sandakan/ParkFlow)

## Development Setup

### 1. API Key Security (Google Maps)

Google Maps API keys should **never** be hardcoded in the repository. We use platform-specific local files to store these keys, which are excluded from version control.

#### Android Setup

1. Open `android/local.properties`.
2. Add your API key:

```properties
MAPS_API_KEY=your_google_maps_api_key_here
```

#### iOS Setup

1. Create a file named `Secrets.xcconfig` in `ios/Flutter/`.
2. Add your API key:

```text
MAPS_API_KEY=your_google_maps_api_key_here
```

#### Web Setup

Secure your Web API key using **HTTP Referrer Restrictions** in the Google Cloud Console.

1. Open `web/index.html`.
2. Replace `YOUR_MAPS_API_KEY` with your actual key in the script tag.
3. **DO NOT** commit your key to Git if the repository is public.
4. In [Google Cloud Console](https://console.cloud.google.com/apis/credentials), restrict your key to only work on your authorized domains (e.g., `localhost` for testing).

### 2. Running the App

```bash
flutter pub get
flutter run -d chrome --dart-define=BASE_URL=http://localhost:8200/api/v1
```

## Architecture (Layered Architecture)

The project follows a clean, layered architecture for maintainability and scalability.

* **lib/presentation/**: UI Screens, Widgets, and Riverpod Notifiers/Providers.
* **lib/services/**: Business logic services that coordinate between repositories.
* **lib/repositories/**: Data access layer (Remote and Local implementations).
* **lib/models/**: Data models and entities (using `freezed` for immutability).
* **lib/core/**: App-wide constants, themes, and networking configuration (Dio).
* **lib/l10n/**: Localization files (`.arb`).

## Key Technologies

- **State Management:** Riverpod
* **Networking:** Dio
* **Maps:** Google Maps Flutter
* **Serialization:** Freezed & JSON Serializable
