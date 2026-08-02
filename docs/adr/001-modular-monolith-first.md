# ADR-001: Modular Monolith First

- **Status:** Accepted
- **Date:** 2026-08-02
- **Deciders:** CTO / Architecture

## Context

The brief proposes six Spring Boot services from day one (`auth`, `booking`, `venue`, `payment`, `notification`, `search`). The product is greenfield, the team will be small initially, and correctness of booking/payment matters more than independent deployability.

## Decision

Build a **single deployable** Spring Boot 3 application (`backend/platform-api`) organized as **bounded-context packages** that mirror future services.

Physical folders under `services/*` remain reserved and are populated only when a context is extracted.

## Consequences

**Positive**

- Faster feature delivery and simpler local dev (one process)
- Easier ACID transactions for booking + outbox
- Clear extraction path without rewriting domain code

**Negative**

- Requires package discipline to avoid a “big ball of mud”
- Single deploy unit until extraction

**Mitigations**

- ArchUnit tests for package dependency rules
- No cross-context JPA relations
- ADRs required before any extraction

## Alternatives Considered

1. **Microservices day one** — rejected: ops and distributed transaction cost too high.
2. **Nanoservices per category** — rejected: taxonomy should be data/plugins, not deployables.
