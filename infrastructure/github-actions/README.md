# GitHub Actions notes

Path-filtered workflows live in `.github/workflows/`:

| Workflow | Paths |
|----------|-------|
| `ci-backend.yml` | `backend/**`, `packages/api_contracts/**` |
| `ci-flutter.yml` | Flutter apps + Dart packages |
| `ci-website.yml` | `apps/website/**` (placeholder until SSR scaffold) |

Reusable composite actions can be added here later.
