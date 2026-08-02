# Architecture Decision Records

ADRs document significant, durable decisions. New ADRs use the next number and status `Proposed` → `Accepted` / `Superseded`.

| ADR | Title | Status |
|-----|-------|--------|
| [001](001-modular-monolith-first.md) | Modular monolith first | Accepted |
| [002](002-flutter-clients-and-seo-website.md) | Flutter clients + SSR website | Accepted |
| [003](003-postgres-primary-redis-cache.md) | PostgreSQL + Redis roles | Accepted |
| [004](004-jwt-rbac-auth.md) | JWT + refresh + RBAC | Accepted |
| [005](005-api-versioning.md) | URL API versioning | Accepted |
| [006](006-eventing-outbox.md) | Domain events + outbox | Accepted |
| [007](007-search-strategy.md) | Postgres FTS → OpenSearch | Accepted |
| [008](008-observability.md) | Observability baseline | Accepted |
| [009](009-monorepo-tooling.md) | Monorepo tooling | Accepted |
| [010](010-payment-isolation.md) | Payment isolation & idempotency | Accepted |

## Template

```markdown
# ADR-NNN: Title

- **Status:** Proposed | Accepted | Superseded by ADR-XXX
- **Date:** YYYY-MM-DD

## Context
## Decision
## Consequences
## Alternatives Considered
```
