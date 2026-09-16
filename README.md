# Makkah Superstore Catalogue

A polished, responsive Flutter Web catalogue for Makkah Superstore. The app is intentionally catalogue-only: there is no cart, checkout, login, payment, delivery, or online ordering flow.

## Run in VS Code

1. Install the Flutter SDK and the Flutter extension for VS Code.
2. Open this folder in VS Code.
3. Run:

```bash
flutter pub get
flutter run -d chrome
```

You can also use `flutter build web` for a production build.

## Project notes

- All products, categories, offers, brands, branches, and reviews are local Dart data in `lib/data/store_data.dart`.
- Navigation and app theme live in `lib/app.dart`.
- Reusable UI components are in `lib/widgets/components.dart`.
- Main catalogue and information screens are in `lib/screens/screens.dart`.
- Your supplied Makkah Superstore logo is included at `assets/logo/makkah_superstore_logo.jpg`.
- Product imagery currently uses stable Unsplash image URLs so the demo works without a large binary asset bundle. Replace the URL strings with local `assets/` paths later if needed.