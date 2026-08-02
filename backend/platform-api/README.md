# BookMySpace Platform API

Modular monolith (ADR-001). Java 21 · Spring Boot 3 · Gradle (Kotlin DSL).

## Packages

| Package | Role |
|---------|------|
| `bootstrap` | Spring Boot entrypoint, config, security boundaries |
| `shared` | Cross-cutting kernel (correlation id, Problem Details) |
| `identity` | Users, sessions, RBAC (Phase 3+) |
| `venue` | Orgs & venue catalog (Phase 5+) |
| `booking` | Holds & bookings (Phase 7–8+) |
| `payment` | Razorpay (Phase 9+) |
| `notification` | Delivery (Phase 10+) |
| `search` | Discovery projections (Phase 11+) |

## Prerequisites

- JDK 21+
- Docker (for Postgres + Redis via Compose)

## Run locally

```bash
# from repo root
docker compose -f infrastructure/docker/docker-compose.yml up -d

cd backend/platform-api
./gradlew bootRun
```

Health: `GET http://localhost:8080/actuator/health`  
Readiness: `GET http://localhost:8080/actuator/health/readiness`

## Tests

```bash
./gradlew test
```

## Notes

- Phase 1 excludes DataSource/Redis auto-configuration so the shell boots without live DB.
- JWT filter chain is reserved in `SecurityConfig`; auth flows start in Phase 3.
- No booking/payment/venue business logic in this phase.
