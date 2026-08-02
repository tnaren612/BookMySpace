# Deployment Strategy

## Runtime Shape (Phases 1–8)

```
Internet
   │
   ▼
CDN (website static + media)
   │
   ▼
Load Balancer / Reverse Proxy (TLS)
   │
   ▼
platform-api (N containers/tasks)
   │
   ├── PostgreSQL (Managed)
   ├── Redis (Managed)
   └── S3-compatible storage
```

Start on a single region closest to primary users (e.g. `ap-south-1`). Multi-region is a later scale project.

## Packaging

- Backend: Docker multi-stage build, non-root user, distroless/alpine JRE 21
- Flutter web app shell: static hosting / CDN
- Website SSR: container or platform hosting (Vercel/Cloud Run/etc.)
- Local: `infrastructure/docker/docker-compose.yml` for Postgres, Redis, Mailhog, API

## Release Strategy

| Stage | Strategy |
|-------|----------|
| Early | Rolling update (replace tasks) |
| Growth | Blue/green or canary (10% → 50% → 100%) |
| Schema | Expand → deploy → contract |

## Health

- `GET /actuator/health/liveness`
- `GET /actuator/health/readiness` (DB + Redis checks)
- Orchestrator only routes ready instances

## Zero-Downtime Checklist

- [ ] Migrations backward compatible with currently running app
- [ ] Feature flags for risky behavior
- [ ] Webhook endpoints remain available during drain
- [ ] Connection pools tolerate rolling bounce

## Disaster Recovery (Baseline Targets)

| Metric | Early target |
|--------|--------------|
| RPO | ≤ 1 hour (managed automated backups) |
| RTO | ≤ 4 hours |
| Backups | Daily + PITR if provider supports |
| Restore drill | Quarterly |

## What We Delay

- Kubernetes until multiple services + team readiness (Compose/ECS/Cloud Run is fine first)
- Multi-region active-active
- Service mesh
