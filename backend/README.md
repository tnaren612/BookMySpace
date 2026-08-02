# Backend

## platform-api

Modular monolith Spring Boot 3 application (Java 21). Phase 1 bootstrap is live.

Bounded context packages (boundaries only in Phase 1):

- `identity` → future `services/auth-service`
- `venue` → future `services/venue-service`
- `booking` → future `services/booking-service`
- `payment` → future `services/payment-service`
- `notification` → future `services/notification-service`
- `search` → future `services/search-service`

See `backend/platform-api/README.md`, `docs/architecture/01-system-architecture.md`, and ADR-001.
