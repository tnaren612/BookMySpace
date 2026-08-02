# Docker (Phase 1)

## Local dependencies

```bash
# from repo root
cp infrastructure/docker/.env.example infrastructure/docker/.env
docker compose -f infrastructure/docker/docker-compose.yml --env-file infrastructure/docker/.env up -d
docker compose -f infrastructure/docker/docker-compose.yml ps
```

Services (Phase 1 only):

| Service | Image | Port |
|---------|-------|------|
| PostgreSQL | `postgres:16-alpine` | 5432 |
| Redis | `redis:7-alpine` | 6379 |

Health checks and named volumes are configured in `docker-compose.yml`.

**Not included in Phase 1:** Kafka, OpenSearch, Mailhog, platform-api container.

Stop:

```bash
docker compose -f infrastructure/docker/docker-compose.yml down
```
