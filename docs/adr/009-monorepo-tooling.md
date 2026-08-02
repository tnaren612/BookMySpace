# ADR-009: Monorepo Tooling

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Multiple Flutter apps, shared Dart packages, one Java backend, and a Node SSR site share one repository.

## Decision

| Area | Tool |
|------|------|
| Git | Single monorepo |
| Dart packages | Melos (or `path` deps initially; Melos by Phase 2) |
| Java | Gradle (Kotlin DSL), single `platform-api` module first; multi-module when extracted |
| Website | pnpm or npm workspaces inside `apps/website` |
| CI | Path-filtered GitHub Actions workflows |
| Containers | Docker Compose for local dependencies |

## Consequences

- Atomic cross-stack PRs possible
- CI must use path filters to stay fast

## Alternatives Considered

1. Polyrepo — rejected for early-stage coordination cost.
2. Bazel — overkill for current team size.
