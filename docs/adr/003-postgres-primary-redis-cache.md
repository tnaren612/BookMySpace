# ADR-003: PostgreSQL Primary + Redis Supporting Roles

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

We need relational integrity for bookings, strong reporting, geo queries, and a cache/ephemeral layer for performance and holds.

## Decision

- **PostgreSQL** is the system of record for all business data.
- **Redis** is used only for:
  - Session / refresh token denylist (as needed)
  - Rate limiting
  - Short-lived booking holds
  - Hot read caches with explicit TTLs
- No business source-of-truth data lives only in Redis.

## Consequences

- Clear failure modes (Redis down ≠ data loss; degrade holds/rate-limits carefully)
- Requires cache invalidation discipline

## Alternatives Considered

1. MongoDB primary — rejected; booking constraints are relational.
2. Redis as primary for availability — rejected; durability and audit insufficient.
