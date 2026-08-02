# System Architecture

**Status:** Target architecture for Phases 1–12  
**Related:** ADR-001 (modular monolith), ADR-002 (clients), ADR-003 (data)

---

## 1. Context Diagram

```
                   ┌──────────────┐
                   │  CDN / S3    │
                   └──────▲───────┘
                          │ media
┌────────────┐     ┌──────┴───────┐     ┌─────────────────┐
│ customer   │────▶│              │────▶│ PostgreSQL      │
│ Flutter    │     │  BookMySpace │     │ (primary store) │
└────────────┘     │  API         │     └─────────────────┘
┌────────────┐     │  (Modular    │     ┌─────────────────┐
│ owner      │────▶│   Monolith)  │────▶│ Redis           │
│ Flutter    │     │              │     │ cache/holds/rl  │
└────────────┘     │  packages:   │     └─────────────────┘
┌────────────┐     │  auth,venue, │     ┌─────────────────┐
│ admin web  │────▶│  booking,    │────▶│ Razorpay        │
└────────────┘     │  payment,    │     └─────────────────┘
┌────────────┐     │  notify,     │     ┌─────────────────┐
│ website    │─API─▶│  search      │────▶│ FCM / Email /   │
│ (SSR SEO)  │     │              │     │ WhatsApp        │
└────────────┘     └──────────────┘     └─────────────────┘
```

Public venue pages are rendered by `apps/website` for SEO; transactional flows deep-link into Flutter apps.

---

## 2. Bounded Contexts (Logical Services)

Even inside one deployable, these are **hard package boundaries**:

| Context | Responsibility | Owns data |
|---------|----------------|-----------|
| **Identity & Access** | Users, sessions, MFA later, RBAC, org membership | users, roles, refresh_tokens, memberships |
| **Venue Catalog** | Orgs, venues, categories, amenities, media metadata, pricing rules | venues, inventory_units, media, policies |
| **Availability & Booking** | Calendars, holds, bookings, cancellations, state machine | slots, holds, bookings, booking_events |
| **Payments & Settlements** | Intent, capture, refund, payout references | payments, refunds, ledger refs |
| **Notifications** | Templates, delivery, preferences, retries | notification_outbox, preferences |
| **Search** | Indexing projections, query API | search documents (DB FTS → OpenSearch) |
| **Trust & Safety** (later) | KYC, moderation, disputes | verifications, cases |
| **Platform Admin** | Config, feature flags, support tools | platform_config |

**Rule:** No cross-context table joins in repositories. Cross-context collaboration via application services or domain events.

---

## 3. Modular Monolith Package Map (Backend)

```
com.bookmyspace
├── bootstrap/           # Spring Boot app, config, security filter chain
├── shared/              # kernel: IDs, errors, money, time, pagination
├── identity/
├── venue/
├── booking/
├── payment/
├── notification/
└── search/
```

Each context package:

```
{context}/
├── api/                 # Controllers / DTOs (inbound adapters)
├── application/         # Use cases / commands / queries
├── domain/              # Entities, value objects, domain services, ports
└── infrastructure/      # JPA, Redis, Razorpay, FCM adapters
```

When extraction happens, a package becomes a `services/{name}-service` with minimal API changes (ADR-001).

---

## 4. Client Architecture

### Flutter apps (`customer_flutter`, `owner_flutter`)

Feature-first:

```
lib/
├── app/                 # bootstrap, router, theme
├── core/                # networking, auth session, errors, storage
├── design_system/       # or depend on packages/shared_ui
└── features/
    ├── auth/
    ├── home/
    ├── search/
    ├── venue_detail/
    ├── booking/
    ├── payments/
    └── profile/
```

Each feature:

```
features/{name}/
├── data/
├── domain/
├── presentation/
└── {name}.dart          # barrel export if needed
```

State: **Riverpod**  
Routing: **GoRouter**  
Models: **Freezed**  
HTTP: **Dio** + interceptors (auth, correlation id, errors)

### Website (`apps/website`)

SSR/SSG for:

- Home, city landing pages, category pages
- Public venue profile (crawlable)
- Blog / help / legal

Uses public read APIs; no privileged mutations.

---

## 5. Multi-Tenancy (Summary)

See [03-multi-tenancy.md](03-multi-tenancy.md).

- **Platform tenant** = BookMySpace operators  
- **Organization** = venue owner business (tenant boundary for owner data)  
- **Customer** = platform user (not siloed per org; can book across orgs)

Owner APIs are org-scoped. Marketplace APIs are platform-scoped with public/published venue filters.

---

## 6. Critical Flows (Conceptual)

### Hold → Book → Pay

```
1. Client requests hold(inventory_unit, range)
2. Booking ctx: validate availability + CREATE hold (TTL) + Redis key
3. Client confirms booking (idempotency-key)
4. Booking: convert hold → booking(PENDING_PAYMENT)
5. Payment: create Razorpay order (idempotent)
6. Webhook: payment captured → booking CONFIRMED
7. Outbox: BookingConfirmed → Notification + Search index update
```

### Double-booking defense (layered)

1. Exclusion constraint / unique booking ranges (Postgres)
2. Optimistic version on inventory calendar
3. Short-lived Redis hold
4. Idempotency keys on confirm APIs
5. Reconciliation job for webhook gaps

---

## 7. Cross-Cutting Concerns

| Concern | Approach |
|---------|----------|
| AuthN | JWT access + refresh rotation |
| AuthZ | RBAC + org membership + resource ownership checks |
| Validation | Bean Validation / Freezed + form validators |
| Errors | Problem Details (RFC 7807) JSON |
| Idempotency | `Idempotency-Key` header on mutating booking/payment APIs |
| Correlation | `X-Correlation-Id` propagated end-to-end |
| Rate limit | Redis token bucket per IP / user / device |
| Feature flags | Config service / flags table |
| Audit | Append-only audit for admin & booking state changes |

---

## 8. Scalability Path

| Stage | Shape |
|-------|-------|
| 0–10k MAU | Single API + Postgres + Redis, vertical scale |
| 10k–500k | Read replicas, CDN, extract notification & payment |
| 500k–millions | Search service, booking read models, shard by region/org if needed |

We design schemas and APIs to allow this path **without rewriting clients**.

---

## 9. What We Explicitly Avoid (For Now)

- Kubernetes complexity before Docker Compose + a single cloud VM/ECS is insufficient
- Kafka before outbox + worker polling is insufficient
- Per-category microservices
- Shared database joins across contexts
- Client-side trust of prices or availability
