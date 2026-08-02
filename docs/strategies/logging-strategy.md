# Logging Strategy

## Principles

1. **Structured JSON logs** in staging/prod.
2. **Correlation ID** on every request (`X-Correlation-Id`); generate if missing.
3. **Tenant context** fields when available: `userId`, `organizationId`, `bookingId`.
4. **No secrets, tokens, passwords, card data, OTP codes** in logs.
5. **PII minimization** — log last-4 phone / hashed email only when needed for support.

## Levels

| Level | Use |
|-------|-----|
| ERROR | Failures needing action; include error code |
| WARN | Recoverable anomalies (retry, fallback) |
| INFO | Business milestones (booking confirmed, payment captured) |
| DEBUG | Dev diagnostics; disabled in prod by default |
| TRACE | Extremely verbose; local only |

## Standard Fields

```json
{
  "timestamp": "2026-08-02T00:00:00.000Z",
  "level": "INFO",
  "service": "platform-api",
  "env": "staging",
  "correlationId": "...",
  "userId": "...",
  "organizationId": "...",
  "message": "Booking confirmed",
  "bookingId": "...",
  "event": "booking.confirmed"
}
```

## Client Logging

- Flutter: remote error reporting (Sentry) for crashes; avoid logging auth headers.
- Include app version, platform, correlation id from last API call.

## Retention

| Env | Retention (starting point) |
|-----|----------------------------|
| local | stdout only |
| staging | 7–14 days |
| production | 30 days hot; longer cold archive if compliance requires |

## Anti-Patterns

- Logging full request/response bodies by default
- `e.printStackTrace()` without structure
- Different log formats per module
