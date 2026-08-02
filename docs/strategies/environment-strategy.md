# Environment Strategy

## Environments

| Name | Purpose | Data | Stability |
|------|---------|------|-----------|
| **local** | Developer machines | Synthetic / docker seeds | Breakable |
| **ci** | Ephemeral testcontainers | Ephemeral | Automated |
| **staging** | Pre-prod validation | Anonymized / synthetic | Prod-like config |
| **production** | Live users | Real | Controlled change |

Optional later: `dev` shared cloud sandbox for demos.

## Configuration Rules

1. **Same artifact, different config** — promote the same Docker image digest staging → prod.
2. Config via environment variables / secret manager; never bake secrets into images.
3. Provide `*.env.example` with **names only** (no real values).
4. Feature flags can differ by environment.
5. Razorpay **test keys** in local/staging; live keys only in production.

## Suggested Variables (names)

```
APP_ENV=local|staging|production
SERVER_PORT=8080
DATABASE_URL=
DATABASE_USER=
DATABASE_PASSWORD=
REDIS_URL=
JWT_ACCESS_SECRET=
JWT_ACCESS_TTL_SECONDS=
JWT_REFRESH_TTL_SECONDS=
S3_ENDPOINT=
S3_BUCKET=
S3_ACCESS_KEY=
S3_SECRET_KEY=
RAZORPAY_KEY_ID=
RAZORPAY_KEY_SECRET=
RAZORPAY_WEBHOOK_SECRET=
FCM_CREDENTIALS_JSON=
SMTP_HOST=
WHATSAPP_API_URL=
WHATSAPP_TOKEN=
CORS_ALLOWED_ORIGINS=
LOG_LEVEL=
OTEL_EXPORTER_OTLP_ENDPOINT=
```

## Seed Data

- Local: deterministic seed script (venues, orgs, users) for UX work.
- Staging: resettable seed; never copy prod PII without anonymization approval.

## Access Control

| Env | Who |
|-----|-----|
| local | All engineers |
| staging | Engineers + QA + PM |
| production | On-call + restricted deploy role; break-glass audited |

## Promotion Flow

```
PR → CI → merge main → build image → deploy staging → smoke → approve → deploy prod
```
