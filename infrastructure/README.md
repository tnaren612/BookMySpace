# Infrastructure

| Path | Purpose |
|------|---------|
| `docker/` | Local Compose (Postgres + Redis) |
| `environments/` | Names-only env templates |
| `github-actions/` | Notes for reusable CI (workflows live in `.github/workflows`) |

Never commit real secrets. Copy `*.env.example` → local `.env`.
