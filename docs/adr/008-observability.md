# ADR-008: Observability Baseline

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Production SaaS without logs/metrics/traces cannot be operated safely.

## Decision

| Signal | Standard |
|--------|----------|
| Logs | Structured JSON (Logback / Log4j2), correlation id |
| Metrics | Micrometer → Prometheus |
| Traces | OpenTelemetry (API + critical client spans) |
| Errors | Sentry or equivalent for clients + backend |
| Uptime | Health `/actuator/health` liveness & readiness |

PII redaction rules in logging strategy are mandatory.

## Consequences

- Slight overhead; required for enterprise readiness
- Local stack may use stdout only; staging/prod export collectors

## Alternatives Considered

1. Printf logs only — rejected.
2. Full commercial APM day one — optional later; OTEL keeps portability.
