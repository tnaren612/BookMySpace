# BookMySpace

India's Venue Commerce Platform — discover, book, manage, and operate every type of rentable space.

> **Status:** Phase 1 complete — monorepo toolchain, modular-monolith API shell, Flutter empty shells, Postgres+Redis Compose, path-filtered CI.

## Vision

Build a production-grade, multi-tenant SaaS that combines marketplace discovery (Airbnb / BookMyShow), owner operations (Shopify / Zoho), and reliable booking commerce (OYO / Urban Company) for every rentable venue category in India.

## Monorepo Layout

```
bookmyspace/
├── apps/                      # Client applications
│   ├── customer_flutter/      # Customer mobile + web app
│   ├── owner_flutter/         # Venue owner / operator app
│   ├── admin_web/             # Platform admin console
│   └── website/               # Marketing + SEO surface (SSR — framework TBD)
├── backend/
│   └── platform-api/          # Modular monolith (Spring Boot 3 / Java 21)
├── services/                  # Reserved extraction targets (READMEs only)
├── packages/                  # shared_ui, shared_models, common_utils, api_contracts
├── docs/                      # Architecture & standards
├── infrastructure/            # Docker Compose, env templates
└── .github/workflows/         # Path-filtered CI
```

## Quick Links

| Document | Purpose |
|----------|---------|
| [docs/README.md](docs/README.md) | Documentation index |
| [docs/architecture/01-system-architecture.md](docs/architecture/01-system-architecture.md) | Target architecture |
| [docs/architecture/02-folder-structure.md](docs/architecture/02-folder-structure.md) | Complete folder design |
| [docs/architecture/phase-1-implementation-report.md](docs/architecture/phase-1-implementation-report.md) | Phase 1 delivery report |
| [docs/roadmap/phase-roadmap.md](docs/roadmap/phase-roadmap.md) | Phase 1–20 roadmap |
| [docs/adr/](docs/adr/) | Architecture Decision Records |

## Tech Stack (Confirmed)

| Layer | Choice |
|-------|--------|
| Mobile / App UI | Flutter, Material 3, Riverpod, GoRouter |
| Backend | Spring Boot 3, Java 21, Gradle (Kotlin DSL) |
| Database | PostgreSQL 16 |
| Cache | Redis 7 |
| Auth | JWT + Refresh Token + RBAC (Phase 3) |
| Deploy | Docker Compose (local deps), GitHub Actions |

## Core Principle

**Start simple, stay modular, extract when pain is proven.**

Phase 1–6 ship as a **modular monolith** with clear packages. See [ADR-001](docs/adr/001-modular-monolith-first.md).

## Developer Setup (Phase 1)

### Prerequisites

- **JDK 21**
- **Flutter** stable (3.24+)
- **Docker Desktop** (Compose v2)
- Git

### 1. Start local data plane

```bash
cp infrastructure/docker/.env.example infrastructure/docker/.env
docker compose -f infrastructure/docker/docker-compose.yml --env-file infrastructure/docker/.env up -d
docker compose -f infrastructure/docker/docker-compose.yml ps
```

Postgres: `localhost:5432` · Redis: `localhost:6379`

### 2. Run platform-api

```bash
cd backend/platform-api
./gradlew bootRun
```

- Health: http://localhost:8080/actuator/health
- Readiness: http://localhost:8080/actuator/health/readiness

```bash
./gradlew test
```

### 3. Run Flutter shells

```bash
cd apps/customer_flutter && flutter pub get && flutter run
# or apps/owner_flutter / apps/admin_web (admin: flutter run -d chrome)
```

```bash
flutter analyze
flutter test
```

### 4. Environment templates

Copy names-only templates from `infrastructure/environments/*.env.example`. **Never commit `.env` or secrets.**

## License

Proprietary — All rights reserved.
