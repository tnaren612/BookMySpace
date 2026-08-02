# CI/CD Strategy

## Goals

- Every commit on a PR is buildable and tested for touched areas.
- `main` is always deployable.
- Fast feedback via **path filters**.

## Workflows (Target)

| Workflow | Triggers | Does |
|----------|----------|------|
| `ci-backend.yml` | `backend/**`, `packages/api_contracts/**` | Build, unit, Testcontainers integration, ArchUnit |
| `ci-flutter.yml` | `apps/*_flutter/**`, `packages/**` | Analyze, test, format check |
| `ci-website.yml` | `apps/website/**` | Lint, build, smoke |
| `deploy-staging.yml` | push `main` | Build images, migrate, deploy staging, smoke |
| `deploy-prod.yml` | manual approval / tag | Deploy same digest to prod |

## Quality Gates

PR cannot merge unless:

1. Required CI jobs green
2. No critical vulnerability in dependency scan (policy-tunable)
3. OpenAPI diff reviewed if contracts change
4. Security checklist acknowledged for sensitive paths (CODEOWNERS)

## Artifacts

- Docker image: `bookmyspace/platform-api:<git-sha>`
- Flutter: build artifacts per platform on release tags
- SBOM generation recommended by Phase 8+

## Migrations

- Flyway runs as init job / release step **before** app traffic switch
- Backward-compatible migrations only for zero-downtime (expand/contract pattern)

## Rollback

- Instant: redeploy previous image digest
- DB: roll **forward** with fix migration (no down migrations in prod)

## Secrets

- GitHub Environments: `staging`, `production`
- OIDC to cloud where possible (avoid long-lived cloud keys)
