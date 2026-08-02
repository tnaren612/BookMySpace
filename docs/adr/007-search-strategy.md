# ADR-007: Search — Postgres FTS First, OpenSearch Later

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Venue discovery needs text, filters, geo, and ranking. Elastic/OpenSearch is powerful but operationally heavy.

## Decision

- **Phase MVP:** PostgreSQL Full-Text Search + PostGIS (or lat/lng bounding boxes) + curated filters.
- Maintain a `venue_search_document` projection updated via outbox events.
- **Extract OpenSearch** when: relevance tuning needs exceed SQL, index size/query latency regresses, or multi-field ranking becomes product-critical.

`services/search-service` remains a logical boundary from day one (package), physical service later.

## Consequences

- Faster MVP, one less cluster
- Some advanced ranking deferred

## Alternatives Considered

1. OpenSearch day one — deferred.
2. Client-side filtering only — rejected for scale.
