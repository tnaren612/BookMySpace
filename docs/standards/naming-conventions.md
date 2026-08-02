# Naming Conventions

## General

| Kind | Convention | Example |
|------|------------|---------|
| Repo | lowercase | `bookmyspace` |
| Docs files | kebab-case | `error-handling-strategy.md` |
| ADR files | `NNN-short-title.md` | `001-modular-monolith-first.md` |
| Env vars | SCREAMING_SNAKE | `DATABASE_URL` |
| Feature flags | dotted | `booking.instant_book` |

---

## Java

| Kind | Convention | Example |
|------|------------|---------|
| Packages | `com.bookmyspace.{context}.{layer}` | `com.bookmyspace.booking.domain` |
| Classes | PascalCase | `BookingService` |
| Methods/fields | camelCase | `confirmBooking` |
| Constants | SCREAMING_SNAKE | `MAX_HOLD_MINUTES` |
| Use cases | Verb + Noun | `ConfirmBookingUseCase` |
| Ports | `XxxRepository`, `XxxGateway` | `PaymentGateway` |
| Domain events | Past tense | `BookingConfirmed` |
| DTOs | `XxxRequest` / `XxxResponse` | `CreateHoldRequest` |
| Exceptions | `XxxException` | `SlotUnavailableException` |
| Tables (JPA) | snake_case | `booking_holds` |

---

## Dart / Flutter

| Kind | Convention | Example |
|------|------------|---------|
| Files | snake_case | `venue_detail_screen.dart` |
| Classes | PascalCase | `VenueDetailScreen` |
| Members | camelCase | `isLoading` |
| Constants | camelCase or SCREAMING | prefer `maxHoldMinutes` |
| Providers | noun + Provider | `venueDetailProvider` |
| Features folders | snake_case | `features/venue_detail` |
| Packages | snake_case | `shared_ui` |

---

## HTTP APIs

| Kind | Convention | Example |
|------|------------|---------|
| Base | `/api/v1` | `/api/v1/venues` |
| Resources | plural nouns | `/bookings/{id}` |
| Actions | verb sub-resource sparingly | `/bookings/{id}/cancel` |
| Query params | camelCase or snake — **pick snake_case** | `organization_id`, `page_size` |
| Headers | kebab | `Idempotency-Key`, `X-Correlation-Id` |

Path params: `{id}` UUIDs unless a public slug is intentional (`/venues/by-slug/{slug}`).

---

## Database

| Kind | Convention | Example |
|------|------------|---------|
| Tables | plural snake_case | `venues`, `booking_events` |
| Columns | snake_case | `organization_id` |
| PK | `id` (UUID) | |
| FK | `{table_singular}_id` | `venue_id` |
| Indexes | `idx_{table}_{cols}` | `idx_venues_org_id` |
| Unique | `uq_{table}_{cols}` | `uq_memberships_org_user` |
| Enums | DB enum or check + app enum | document mapping |

---

## Git

| Kind | Convention | Example |
|------|------------|---------|
| Branches | `type/short-desc` | `feat/booking-hold` |
| Commits | Conventional Commits | `feat(booking): add slot hold TTL` |

Types: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `ci`, `perf`, `security`.
