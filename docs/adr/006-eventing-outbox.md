# ADR-006: Domain Events + Transactional Outbox

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Booking confirmation must reliably trigger notifications, search updates, and (later) analytics without dual-write bugs.

## Decision

- Publish **domain events** from aggregates (e.g. `BookingConfirmed`).
- Persist events in an **outbox table in the same DB transaction** as the state change.
- A worker polls/streams the outbox and dispatches to notification/search handlers.
- Introduce Kafka/RabbitMQ only when outbox volume or multi-service fan-out requires it.

## Consequences

- At-least-once delivery → handlers must be idempotent
- Simple to operate inside the modular monolith

## Alternatives Considered

1. Dual write to DB + message broker — rejected (inconsistency).
2. Kafka day one — rejected as premature infrastructure.
