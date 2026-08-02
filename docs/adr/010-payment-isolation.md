# ADR-010: Payment Isolation & Idempotency

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Razorpay webhooks, retries, and user double-taps create duplicate payment risk. Financial correctness is existential.

## Decision

- Payment logic lives in its own bounded context (package → future `payment-service`).
- All payment mutations require **idempotency keys**.
- Webhooks are verified (signature), stored raw, processed idempotently.
- Booking state transitions on payment events are explicit and audited.
- Never trust client-reported “payment success” alone — webhook/server confirmation is source of truth.
- Reconciliation job compares provider vs local ledger daily.

## Consequences

- More upfront design in payment module
- Safer extraction later; clear PCI scope reduction (no card data stored)

## Alternatives Considered

1. Inline payment calls inside booking service without outbox — rejected.
2. Storing card PANs — forbidden.
