# Optional local assets

The first version uses stable Unsplash URLs in `lib/data/store_data.dart` so the catalogue works immediately without a large image bundle.

If you want fully local/offline imagery later, add images under:

- `assets/logo/`
- `assets/banners/`
- `assets/categories/`
- `assets/products/`
- `assets/brands/`

Then replace the URL strings in `lib/data/store_data.dart` and register the folders in `pubspec.yaml`.