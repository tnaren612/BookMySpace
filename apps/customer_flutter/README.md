# Customer Flutter App

Marketplace shell for BookMySpace customers.

## Stack

- Flutter + Material 3
- Riverpod
- GoRouter
- `packages/shared_ui`, `shared_models`, `common_utils`

## Run

```bash
cd apps/customer_flutter
flutter pub get
flutter run
```

Env via `--dart-define`:

```bash
flutter run --dart-define=APP_FLAVOR=local --dart-define=API_BASE_URL=http://localhost:8080
```

Phase 1: placeholder Discover / Profile routes only.
