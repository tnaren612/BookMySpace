# ADR-005: API Versioning via URL Prefix

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Mobile apps cannot force-upgrade instantly. Breaking API changes must be controlled.

## Decision

- Public HTTP APIs live under `/api/v1/...`
- Non-breaking changes (add optional field, add endpoint) stay in `v1`
- Breaking changes require `/api/v2` and a published deprecation window (minimum 90 days for mobile)
- Headers: `X-API-Version` echo for diagnostics; version source of truth is the URL

Detailed rules: `docs/strategies/api-versioning-strategy.md`

## Consequences

- Controllers/packages may host multiple versions temporarily
- Contract tests pin response shapes per version

## Alternatives Considered

1. Header-only versioning — harder to observe/debug; rejected as primary.
2. Per-resource versions — too chaotic.
