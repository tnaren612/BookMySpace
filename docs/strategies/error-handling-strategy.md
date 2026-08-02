# Error Handling Strategy

## API Errors (Backend)

Use **RFC 7807 Problem Details**:

```json
{
  "type": "https://api.bookmyspace.in/problems/slot-unavailable",
  "title": "Slot Unavailable",
  "status": 409,
  "detail": "The selected time range is no longer available.",
  "code": "BOOKING_SLOT_UNAVAILABLE",
  "correlationId": "0f8c2c9e-...",
  "errors": []
}
```

### Rules

| Rule | Detail |
|------|--------|
| Stable `code` | Machine-readable; clients branch on `code`, not `detail` text |
| No stack traces | In client responses (prod/staging) |
| Validation | `400` with `errors[]` field-level entries |
| Auth | `401` unauthenticated; `403` unauthorized |
| Conflict | `409` for booking/payment conflicts |
| Idempotency replay | Return original result for same key; do not invent new errors |
| Unexpected | `500` with generic detail + logged correlation id |

### Domain → HTTP mapping

Central exception handler maps domain exceptions → Problem Details. Domains throw intentional types; they do not know HTTP.

## Flutter / Client Errors

Map to user-friendly messages via a single `ErrorMapper`:

1. Network offline → retry UI
2. `401` → refresh; if fail → login
3. Known `code` → localized string
4. Unknown → generic + support correlation id

Never show raw JSON to users.

## Retries

| Operation | Retry? |
|-----------|--------|
| Safe GET | Yes, exponential backoff |
| Booking confirm / payment | Only with same Idempotency-Key |
| Webhooks processing | Yes, idempotent handler |

## User-visible copy

Prefer calm, actionable language:

- “That slot was just taken. Pick another time.”
- “Payment is processing. We’ll notify you shortly.”

Avoid blame and technical jargon.
