# Implementation Roadmap — Phase 1 to Phase 20

Each phase is **independently developable and testable**. Do not start Phase N+1 until Phase N exit criteria pass.

**Rule:** No skipped foundations. Phases build the platform spine before category sprawl.

---

## Phase Overview

| Phase | Name | Outcome |
|-------|------|---------|
| 1 | Monorepo & toolchain bootstrap | Empty apps/packages build; CI skeleton |
| 2 | Platform API skeleton + shared kernel | Bootable Spring app, health, config |
| 3 | Identity & RBAC | Register/login/refresh/roles |
| 4 | Design system & app shells | Flutter themes, routing, auth screens |
| 5 | Organization & venue catalog | Owner can create org + venue draft |
| 6 | Media uploads | Signed S3 upload + CDN read path |
| 7 | Availability & holds | Slot model + Redis/DB hold TTL |
| 8 | Booking state machine | Hold → pending → confirmed/cancelled |
| 9 | Payments (Razorpay) | Order, webhook, idempotent capture |
| 10 | Notifications | Email + FCM on booking events |
| 11 | Customer discovery MVP | Search/list/detail + book path |
| 12 | Owner calendar OS | Calendar, accept/reject, basic pricing |
| 13 | Reviews & trust basics | Ratings + listing verification flags |
| 14 | Admin console MVP | Moderation, user/org lookup |
| 15 | SEO website | City/category/venue SSR pages |
| 16 | WhatsApp + preference center | Template notifications + opt-outs |
| 17 | Settlements & GST invoices | Owner payout reports + invoices |
| 18 | Category capability expansion | Sports/coworking plugins beyond halls |
| 19 | Search hardening | Ranking, geo, OpenSearch decision gate |
| 20 | Scale & extraction readiness | Perf, SLOs, optional service extract |

---

## Phase 1 — Monorepo & Toolchain Bootstrap

**Goal:** Engineers can clone and run empty shells.

**Deliverables**

- Root README, `.gitignore`, `.editorconfig`
- Flutter create stubs for customer/owner/admin
- Gradle skeleton folder for `backend/platform-api` (empty boot later in P2)
- Melos or path deps for packages
- CI workflows that run on path filters (even if no-op jobs)
- Docker Compose: Postgres + Redis only

**Exit criteria**

- [ ] `flutter analyze` passes on empty apps
- [ ] Compose brings up Postgres/Redis
- [ ] Docs linked from root README

**Independent test:** CI green on docs-only and empty app PR.

---

## Phase 2 — Platform API Skeleton + Shared Kernel

**Goal:** One Spring Boot 3 / Java 21 app boots.

**Deliverables**

- `backend/platform-api` with packages: `bootstrap`, `shared`
- Actuator health/readiness
- Problem Details error handler stub
- Correlation id filter
- Flyway baseline
- ArchUnit skeleton
- OpenAPI empty v1 doc

**Exit criteria**

- [ ] App starts against Compose
- [ ] `/actuator/health` OK
- [ ] Unit test for correlation filter / error handler

---

## Phase 3 — Identity & RBAC

**Goal:** Secure accounts with JWT + refresh + roles.

**Deliverables**

- Register, login, refresh, logout
- Password hashing
- Platform + org role model (org CRUD can be minimal)
- Rate-limited auth endpoints
- Integration tests (Testcontainers)

**Exit criteria**

- [ ] Refresh rotation + reuse revocation tested
- [ ] RBAC denies unauthorized route
- [ ] Security checklist auth section complete

---

## Phase 4 — Design System & App Shells

**Goal:** Beautiful, accessible Flutter shells (no business depth yet).

**Deliverables**

- `packages/shared_ui` Material 3 tokens (light/dark)
- GoRouter shells for customer & owner
- Auth UI wired to Phase 3 APIs
- Typography, spacing, motion guidelines implemented in components
- Accessibility pass on auth + home placeholders

**Exit criteria**

- [ ] Light/dark golden tests for core components
- [ ] Login → home navigation works against staging/local API
- [ ] Touch targets & screen reader labels verified on auth

---

## Phase 5 — Organization & Venue Catalog

**Goal:** Owner can manage draft venues.

**Deliverables**

- Organization create/membership
- Venue CRUD (draft/publish states)
- Category taxonomy v1 (limited set: banquet/meeting/community)
- Tenant isolation tests

**Exit criteria**

- [ ] Cross-tenant read/write denied
- [ ] Owner app lists venues for own org only
- [ ] Publish requires minimum fields (validated)

---

## Phase 6 — Media Uploads

**Goal:** Photos without passing binaries through API memory.

**Deliverables**

- Presigned upload URLs
- Media metadata records
- Image size/type validation
- CDN/public read strategy documented + implemented

**Exit criteria**

- [ ] Upload → appear on venue draft
- [ ] Unauthorized upload path fails
- [ ] Large file rejected cleanly

---

## Phase 7 — Availability & Holds

**Goal:** Prevent double booking at the inventory layer.

**Deliverables**

- Inventory units + availability rules
- Hold API with TTL
- Redis hold + DB constraints
- Concurrent conflict tests

**Exit criteria**

- [ ] Two parallel holds for same slot → one wins
- [ ] Expired hold releases capacity
- [ ] Load smoke on hold endpoint

---

## Phase 8 — Booking State Machine

**Goal:** End-to-end booking without payment capture yet (or mock pay).

**Deliverables**

- States: `HELD` → `PENDING_PAYMENT` → `CONFIRMED` / `CANCELLED` / `EXPIRED`
- Idempotent confirm
- Outbox events for state changes
- Customer + owner booking lists

**Exit criteria**

- [ ] Idempotency key returns same booking
- [ ] Illegal transitions rejected
- [ ] Outbox row written in same transaction

---

## Phase 9 — Payments (Razorpay)

**Goal:** Real money path with webhook truth.

**Deliverables**

- Create order aligned to booking amount
- Webhook verification + idempotent processing
- Confirm booking on capture
- Refund primitive (admin/owner policy TBD)
- Reconciliation job v1

**Exit criteria**

- [ ] Webhook replay safe
- [ ] Amount mismatch blocked
- [ ] Security checklist payments section complete

---

## Phase 10 — Notifications

**Goal:** Users learn about booking changes reliably.

**Deliverables**

- Outbox dispatcher → FCM + Email
- Templates for confirm/cancel
- Idempotent delivery keys
- Failure retry with backoff

**Exit criteria**

- [ ] Confirm triggers one push + one email (no duplicates on retry)
- [ ] Preference stub (enable/disable push)

---

## Phase 11 — Customer Discovery MVP

**Goal:** Marketplace loop works for one category cluster.

**Deliverables**

- Search/list with filters (city, date, capacity, category)
- Venue detail
- Book → pay → confirmation UX (≤3 taps where possible)
- Postgres FTS projection

**Exit criteria**

- [ ] New user can discover and book a published venue on staging
- [ ] p95 search acceptable on seed data
- [ ] Analytics events hooked (basic)

---

## Phase 12 — Owner Calendar OS

**Goal:** Owners operate day-to-day inventory.

**Deliverables**

- Calendar UI (day/week)
- Block times / manual bookings
- Pricing rules v1
- Booking acceptance mode (instant vs request) feature flag

**Exit criteria**

- [ ] Owner blocks time → customer cannot hold
- [ ] Request-to-book path works if flag on
- [ ] Owner UX usability test (5 users) notes filed

---

## Phase 13 — Reviews & Trust Basics

**Goal:** Reduce fake/low-quality supply risk.

**Deliverables**

- Post-stay/event reviews
- Owner response
- Listing verification badge workflow (manual admin)
- Basic fraud signals (duplicate images later)

**Exit criteria**

- [ ] Only completed bookings can review
- [ ] Unpublished venues excluded from search

---

## Phase 14 — Admin Console MVP

**Goal:** Platform operators can support and moderate.

**Deliverables**

- Admin auth (platform roles)
- Org/user/venue lookup
- Force unpublish
- Audit log viewer

**Exit criteria**

- [ ] Support can find booking by id/phone hash
- [ ] Admin actions audited
- [ ] Non-admin cannot access admin APIs

---

## Phase 15 — SEO Website

**Goal:** Organic acquisition surface.

**Deliverables**

- SSR home, city, category, venue public pages
- Sitemap/robots
- Deep links into customer app
- Core Web Vitals budget

**Exit criteria**

- [ ] Venue page crawlable without JS auth
- [ ] Meta/OG tags correct
- [ ] Lighthouse SEO score threshold met on templates

---

## Phase 16 — WhatsApp + Preference Center

**Goal:** India-grade messaging with cost control.

**Deliverables**

- WhatsApp Business templates for booking confirmations
- User notification preferences
- Rate/budget guards
- Delivery status logging

**Exit criteria**

- [ ] Opt-out respected
- [ ] Template failures alert
- [ ] Cost dashboard basic metrics

---

## Phase 17 — Settlements & GST Invoices

**Goal:** Owner trust via money clarity.

**Deliverables**

- Owner earnings ledger views
- GST invoice generation (as applicable)
- Payout export / Razorpay Route or manual settlement process documented
- Accountant role (optional)

**Exit criteria**

- [ ] Owner can explain last payout from UI
- [ ] Invoice PDF/HTML stored securely
- [ ] Finance reconciliation matches Razorpay exports

---

## Phase 18 — Category Capability Expansion

**Goal:** Add sports & coworking without forking booking kernel.

**Deliverables**

- Capability plugins: pitch hourly, desk pass, hall event day-rate
- Category-specific amenity schemas
- UI adapters in Flutter for new filters

**Exit criteria**

- [ ] New category booked on staging without core booking rewrite
- [ ] Feature flags per category
- [ ] Docs updated for capability model

---

## Phase 19 — Search Hardening

**Goal:** Conversion-grade discovery.

**Deliverables**

- Ranking features (quality, conversion, distance)
- Geo radius improvements
- Synonym/city normalization
- **Decision gate:** stay on Postgres vs extract OpenSearch

**Exit criteria**

- [ ] Offline eval set of queries improved vs Phase 11 baseline
- [ ] ADR updated with search decision
- [ ] Latency SLO defined and met on staging

---

## Phase 20 — Scale & Extraction Readiness

**Goal:** Prove path to millions; extract only if needed.

**Deliverables**

- Load tests (search, hold, confirm)
- SLO/error budget policy
- Read replica for heavy GETs if needed
- Optional extraction of `payment` or `notification` service
- Runbooks for incidents (booking, payment, auth)
- Security pen-test remediation pass

**Exit criteria**

- [ ] Load test report signed off
- [ ] RPO/RTO drill completed
- [ ] Extraction playbook documented (even if not executed)
- [ ] Platform ready for multi-city growth marketing push

---

## Cross-Cutting (Every Phase)

- Update ADRs when decisions change
- Keep security checklist current
- Prefer feature flags over long-lived branches
- Measure: booking conversion, API p95, crash-free sessions

## Explicit Non-Roadmap (Defer)

- Hyperlocal on-demand “staffed services” like Urban Company ops
- Multi-country tax engines
- Full CQRS everywhere
- Custom Kubernetes operators
- AI chatbots as core booking path
