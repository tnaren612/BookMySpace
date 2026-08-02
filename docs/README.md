# Documentation Index

BookMySpace foundation documentation. **No business feature code lives here** — this is the operating system for how we build.

## Architecture

| Doc | Description |
|-----|-------------|
| [00-vision-review.md](architecture/00-vision-review.md) | Vision critique, improvements, risks, decision rationale |
| [01-system-architecture.md](architecture/01-system-architecture.md) | System context, boundaries, tenancy, data flow |
| [02-folder-structure.md](architecture/02-folder-structure.md) | Complete monorepo & package layout |
| [03-multi-tenancy.md](architecture/03-multi-tenancy.md) | Tenant model for marketplace + owner SaaS |

## Architecture Decision Records

| ADR | Decision |
|-----|----------|
| [001](adr/001-modular-monolith-first.md) | Modular monolith first, extract later |
| [002](adr/002-flutter-clients-and-seo-website.md) | Flutter apps + SSR marketing site |
| [003](adr/003-postgres-primary-redis-cache.md) | PostgreSQL + Redis roles |
| [004](adr/004-jwt-rbac-auth.md) | JWT, refresh tokens, RBAC |
| [005](adr/005-api-versioning.md) | URL versioning `/api/v1` |
| [006](adr/006-eventing-outbox.md) | Domain events + transactional outbox |
| [007](adr/007-search-strategy.md) | Postgres FTS → OpenSearch when needed |
| [008](adr/008-observability.md) | Structured logs, metrics, tracing |
| [009](adr/009-monorepo-tooling.md) | Monorepo tooling choices |
| [010](adr/010-payment-isolation.md) | Payment service isolation & idempotency |

## Standards

| Doc | Description |
|-----|-------------|
| [coding-standards.md](standards/coding-standards.md) | Language & style rules |
| [naming-conventions.md](standards/naming-conventions.md) | Files, packages, APIs, DB |
| [testing-strategy.md](standards/testing-strategy.md) | Unit, integration, E2E |
| [git-branching.md](standards/git-branching.md) | Branching & PR rules |
| [security-checklist.md](security/security-checklist.md) | Pre-ship security gates |

## Strategies

| Doc | Description |
|-----|-------------|
| [environment-strategy.md](strategies/environment-strategy.md) | Local / staging / prod |
| [logging-strategy.md](strategies/logging-strategy.md) | Log levels, PII, correlation |
| [error-handling-strategy.md](strategies/error-handling-strategy.md) | API & client errors |
| [api-versioning-strategy.md](strategies/api-versioning-strategy.md) | Compatibility rules |
| [cicd-strategy.md](strategies/cicd-strategy.md) | Pipelines & quality gates |
| [deployment-strategy.md](strategies/deployment-strategy.md) | Docker, rollouts, rollback |

## Roadmap

| Doc | Description |
|-----|-------------|
| [phase-roadmap.md](roadmap/phase-roadmap.md) | Phase 1–20 prioritized plan |

## Product (PRD)

| Doc | Description |
|-----|-------------|
| [product/README.md](product/README.md) | PRD index — single source of truth for product scope |
| [product/00-prd-overview.md](product/00-prd-overview.md) | Executive summary, goals, USP |
| [product/12-product-backlog.md](product/12-product-backlog.md) | Prioritized epics → features → stories |
| [product/stories/](product/stories/) | 315 user stories + acceptance criteria by module |

## How to Use These Docs

1. **Before coding:** Read vision review + ADR-001 + coding standards.
2. **Before product/sprint work:** Start from [product/README.md](product/README.md) and the prioritized [backlog](product/12-product-backlog.md).
3. **Before a PR:** Run through security checklist + naming conventions.
4. **Before a new service/package:** Open or update an ADR.
5. **Before release:** Environment + deployment + CI/CD strategies.
