# BookMySpace — Architecture Decision Document (ADD)

| Field | Value |
|-------|--------|
| **Document** | `docs/ARCHITECTURE.md` |
| **Role** | Binding architecture narrative for BookMySpace |
| **Status** | **Direction approved — this revision for final review** |
| **Date** | 2026-08-02 |
| **Constitution** | [`docs/CONSTITUTION.md`](CONSTITUTION.md) |
| **Decision log** | [`docs/ARCHITECT_DECISIONS.md`](ARCHITECT_DECISIONS.md) |
| **Product law** | [`docs/product/`](product/) (PRD, business rules, RBAC catalog) |

---

## HARD GATE

> **Direction approved.** Do **not** generate application source code, Flutter/Nest scaffolds beyond existing shells, SQL DDL, or Supabase project wiring until this ADD revision is marked **Accepted** after final review.
>
> Legacy Spring Boot under `backend/platform-api` is **superseded**. Cleanup is a post-acceptance follow-up—not part of this documentation task.

**Approved stack (this revision):**

| Layer | Choice |
|-------|--------|
| Mobile / App | Flutter (`apps/app`) — Android, iOS, Web |
| SEO / Marketing | Next.js (`apps/website`) |
| API | NestJS modular monolith (`backend/api`) |
| ORM | Prisma |
| Database | PostgreSQL |
| Auth | Supabase Auth |
| Object storage | Supabase Storage |
| Background jobs | BullMQ (+ transactional outbox) |
| Push | Firebase Cloud Messaging (FCM) |
| Payments | Razorpay |
| Maps | Google Maps Platform |
| Containers | Docker |
| CI/CD | GitHub Actions |

---

# 1. Executive Summary

## 1.1 Vision

BookMySpace is India's **Venue Commerce Platform**: marketplace discovery and booking for customers, an owner operating system for inventory/calendar/pricing/payouts, and platform administration for KYC, moderation, and config.

Heterogeneous venue types (halls, coworking, sports, hospitality, and more) share one **booking kernel** and a **category capability model**—not separate products per category.

**North-star UX:** primary tasks complete in ≤ 3 taps/clicks where domain rules allow.

## 1.2 Goals

1. Correct booking and payment behavior under concurrency and retries.
2. One Flutter app (role-aware) + Next.js SEO site + one versioned Nest API.
3. Multi-tenant isolation for owner data with marketplace search across orgs.
4. AI-assisted engineering velocity via clear modules, OpenAPI, and Prisma.
5. Cost control: managed Auth/Storage early; Redis/OpenSearch/K8s only on triggers.
6. Scale to millions of users **without rewriting** domain boundaries or client contracts.

## 1.3 Non-goals

- Day-one microservices, API gateway, or per-role BFF.
- Day-one Redis, OpenSearch, Kafka, or Kubernetes.
- Flutter Web as the SEO strategy.
- Guest checkout in MVP (auth-first).
- WhatsApp/SMS as primary notification channel day one.
- CQRS everywhere; GraphQL as public API; blobs in PostgreSQL.
- AI auto-publish, auto-ban, or silent mutation of listings/bookings.
- Dual Spring + Nest systems of record.

## 1.4 Guiding principles

1. **Correctness** of booking & money  
2. **Simplicity** of ops and cognitive load  
3. **Maintainability** via bounded contexts  
4. **Security** (tenancy, secrets, webhooks)  
5. **Developer / AI productivity**  
6. **UX** (Material 3, ≤ 3 taps, a11y)  
7. **Performance** via boring primitives first  
8. **Cost efficiency**

**Mantra:** Start simple, stay modular, extract when pain is proven.

**Governance:** All work must comply with the [Project Constitution](CONSTITUTION.md).

---

# 2. High-Level Architecture

## 2.1 Overall system diagram

```
                         ┌──────────────────────────┐
                         │ CDN / Supabase Storage    │
                         │ (→ S3+CDN migration path) │
                         └────────────▲─────────────┘
                                      │ signed URLs
┌──────────────┐               ┌──────┴───────┐            ┌─────────────────┐
│ Flutter app  │──────────────▶│              │───────────▶│ PostgreSQL      │
│ apps/app     │               │  NestJS API  │            │ + Prisma        │
│ Android/iOS/ │               │  modular     │            └─────────────────┘
│ Web          │               │  monolith    │
└──────────────┘               │              │            ┌─────────────────┐
┌──────────────┐  public reads │  modules:    │───────────▶│ Redis           │
│ Next.js      │──────────────▶│  identity,   │            │ (BullMQ broker) │
│ apps/website │               │  venue,      │            └─────────────────┘
│ SEO/market.  │               │  booking,    │
└──────────────┘               │  payment,    │            ┌─────────────────┐
                               │  notify,     │◀──────────▶│ Supabase Auth   │
                               │  search,     │  JWT/JWKS  └─────────────────┘
                               │  admin, AI   │
                               └──────┬───────┘            ┌─────────────────┐
                                      ├───────────────────▶│ Razorpay        │
                                      ├───────────────────▶│ FCM (Firebase)  │
                                      ├───────────────────▶│ Google Maps     │
                                      └───────────────────▶│ AI providers    │
```

**Rule:** All privileged writes go through NestJS. Clients never hold DB service-role or payment secrets.

## 2.2 Frontend

| Surface | Path | Technology | Job |
|---------|------|------------|-----|
| Transactional app | `apps/app` | Flutter (Android, iOS, Web) | Customer, owner, and admin experiences via **role-aware navigation** and feature modules |
| Marketing / SEO | `apps/website` | Next.js (SSR/SSG/ISR) | City pages, public venue pages, blogs, legal, crawlable HTML |

Shared Dart packages: `shared_ui`, `shared_models`, `common_utils`.  
HTTP: Dio → `/api/v1`. State: Riverpod. Routing: GoRouter. Models: Freezed.

Public Next.js pages deep-link / hand off into the Flutter app for authenticated booking.

## 2.3 Backend

Single deployable **NestJS modular monolith** at `backend/api`:

| Module | Responsibility |
|--------|----------------|
| `identity` | Supabase JWT bridge → User; memberships; RBAC permissions |
| `venue` | Orgs, venues, category capabilities, inventory, media metadata, pricing |
| `booking` | Availability, holds, state machine, cancellations |
| `payment` | Razorpay isolation, webhooks, refunds, ledger refs |
| `notification` | FCM (later email/WhatsApp adapters) |
| `search` | FTS projection + query API |
| `admin` | Platform tools, moderation hooks |
| `ai` | Assistive generation/classification behind flags (not on critical book path) |
| `shared` | Guards, Prisma, Problem Details, outbox, BullMQ, feature flags, logging |

## 2.4 Database

- **PostgreSQL** = system of record for business data.  
- **Prisma** = schema + migrations + type-safe access.  
- Tenancy: shared schema, row-level `organization_id` on owner-owned entities.  
- Users global; bookings join customer + org/venue.  
- **Redis** required for **BullMQ**; also available later for rate-limit / holds / hot cache when product triggers demand (not a second SoR).

## 2.5 External integrations

| System | Role |
|--------|------|
| Supabase Auth | JWT / session issuer |
| Supabase Storage | Media & KYC objects (signed URLs) |
| Razorpay | India payments + webhooks |
| Firebase Cloud Messaging | Push notifications |
| Google Maps Platform | Maps SDK / geocode (coords stored in our DB) |
| AI provider(s) | Opt-in assistive features via `ai` module |
| Sentry + OpenTelemetry | Errors, traces, metrics |

## 2.6 Deployment overview

```
Internet → CDN (Next.js HTML + media)
        → TLS LB / reverse proxy
        → NestJS API (N replicas)
        → BullMQ workers (same image, worker process) 
              ├── PostgreSQL (managed)
              ├── Redis (BullMQ; later cache/holds)
              └── Supabase Auth / Storage APIs
```

Environments: `local` / `dev` / `staging` / `prod`. Prefer separate Supabase projects for staging and prod. No Kubernetes day one.

---

# 3. Technology Decisions

## 3.1 Flutter (`apps/app`)

**Why selected**  
Single codebase for Android, iOS, and Web app shells; Material 3; strong India mobile UX; role-aware modules avoid maintaining three separate apps while sharing design system packages.

**Alternatives considered**  
Three separate Flutter apps · React Native · native Kotlin/Swift · Flutter Web for SEO.

**Pros**  
One release train; shared UI/models; Melos-friendly packages; Riverpod/GoRouter/Freezed already established in foundation work.

**Cons**  
Role complexity inside one app requires disciplined feature flags and route guards; Flutter Web still not used for SEO.

**Future migration strategy**  
If admin density explodes, extract an admin web surface later without rewriting customer/owner flows. Keep deep-link contracts stable.

## 3.2 Next.js (`apps/website`)

**Why selected**  
Founder-approved SEO/marketing framework. SSR/SSG/ISR for city and venue public pages, App Router, strong hosting ecosystem, React familiarity for content teams.

**Alternatives considered**  
Astro · Remix · Flutter Web for public pages.

**Pros**  
Crawlable HTML, previews, ISR for venue pages, ecosystem maturity.

**Cons**  
Second web stack beside Flutter Web; design-token parity is family resemblance, not pixel-identical.

**Future migration strategy**  
Content collections and public read APIs stay stable if the site framework changes; CDN-cache HTML.

## 3.3 NestJS (modular monolith)

**Why selected**  
TypeScript DI, guards, pipes, OpenAPI fit; AI-friendly modules; ACID booking + outbox in one process; replaces Spring Boot as backend direction.

**Alternatives considered**  
Spring Boot · microservices day one · Edge Functions as primary logic · per-client BFF.

**Pros**  
Velocity, transactional correctness, extractable modules, shared TS mental model with Next.js.

**Cons**  
Module discipline required; Node event-loop care; single deploy unit until extraction.

**Future migration strategy**  
Extract `payment` / `notification` / `ai` workers first when blast radius or scale demands; gateway only after ≥ 2 services.

## 3.4 Prisma ORM

**Why selected**  
Type-safe schema, migrations, Nest ergonomics, AI-legible models.

**Alternatives considered**  
TypeORM · Drizzle · Kysely · JPA.

**Pros**  
DX, migrations, generated types.

**Cons**  
N+1 risk; advanced Postgres may need `$queryRaw`; ORM swap painful without ports.

**Future migration strategy**  
Repositories/ports per module; raw SQL for exclusion constraints / advanced geo.

## 3.5 PostgreSQL

**Why selected**  
Relational constraints, transactions, audit, marketplace queries, FTS path.

**Alternatives considered**  
Mongo primary · schema/DB-per-tenant.

**Pros**  
Correctness; mature backups; clear tenancy indexes.

**Cons**  
Hot-row contention on popular venues—design inventory units carefully.

**Future migration strategy**  
Read replicas → partitioning history → optional RLS defense-in-depth → rare dedicated DBs for enterprise only.

## 3.6 Supabase Auth

**Why selected**  
OTP/session UX without building an IdP. Nest validates JWTs; **permissions live in our DB**.

**Alternatives considered**  
Custom JWT · Auth0/Cognito/Keycloak · Clerk · RLS-only thin API.

**Pros**  
Fast, secure auth MVP; pairs with Storage.

**Cons**  
Vendor coupling; Auth availability dependency; identity linking still ours.

**Future migration strategy**  
Swap OIDC issuer/JWKS; keep User/Membership/Permission tables stable.

## 3.7 Supabase Storage

**Why selected**  
Signed upload/download URLs; Nest off the binary path; early vendor cohesion.

**Alternatives considered**  
S3+CloudFront day one · R2/GCS · blobs in Postgres (forbidden).

**Pros**  
Speed, cost, simple org/user key prefixes.

**Cons**  
Egress limits; product API lock-in; need allowlists + later malware scan.

**Future migration strategy**  
`MediaStoragePort` → S3+CDN with key-preserving migration.

## 3.8 BullMQ (background jobs)

**Why selected**  
Founder-approved job runner on Redis for retries, delayed jobs, concurrency control, and named queues (notifications, outbox dispatch, AI, reconciliation, hold expiry). Complements **transactional outbox** in Postgres for reliable event publication.

**Alternatives considered**  
In-process only · Nest `@Cron` alone · Kafka/SQS day one · Graphile Worker.

**Pros**  
Visible queues, retries/backoff, delayed jobs, horizontal worker scale.

**Cons**  
Redis becomes a required dependency earlier than “cache-only” deferral; ops for Redis HA in prod.

**Future migration strategy**  
Keep outbox as write-side guarantee; BullMQ (or later SQS) as dispatch transport. Swap broker behind a job port if needed.

**Pattern:** Business transaction writes row + outbox row → dispatcher enqueues BullMQ job → idempotent handler.

## 3.9 Firebase Cloud Messaging

**Why selected**  
Push for customer/owner transactional updates. **Firebase is FCM only**—not Firestore or Firebase Auth as SoR.

**Alternatives considered**  
OneSignal · WhatsApp day one · SMS-only.

**Pros**  
Cheap mobile delivery; adapter-ready for email/WhatsApp later.

**Cons**  
Permission UX; not a complete channel strategy alone.

**Future migration strategy**  
`Notifier` port → email/WhatsApp adapters with template governance.

## 3.10 Razorpay

**Why selected**  
India UPI/cards/netbanking; webhook-centric truth; isolated payment module.

**Alternatives considered**  
Stripe-only · Paytm/PhonePe primary · payment logic inside booking without isolation.

**Pros**  
Correct rails; audit trail; extractable module.

**Cons**  
Webhook ops and reconciliation required.

**Future migration strategy**  
Extract payment service; multi-acquirer only when a second provider is real.

## 3.11 Google Maps

**Why selected**  
Expected India discovery UX; Flutter plugins; store `lat`/`lng` in our DB.

**Alternatives considered**  
Mapbox · self-hosted OSM.

**Pros**  
Familiar UX; mature SDKs.

**Cons**  
Cost—cache geocodes; restrict API keys.

**Future migration strategy**  
Maps port; keep coordinates in Postgres (PostGIS later if needed).

## 3.12 Docker

**Why selected**  
Local Postgres+Redis; reproducible API/worker images; avoid K8s day one.

**Alternatives considered**  
Bare-metal only · Kubernetes day one.

**Pros**  
Parity, simple promote-by-digest.

**Cons**  
Image hygiene; Compose ≠ full prod topology.

**Future migration strategy**  
Multi-service Compose on extraction; orchestrator when justified.

## 3.13 GitHub Actions

**Why selected**  
Path-filtered CI for API, Flutter, Next.js; staging from `main`; prod via approval/tag.

**Alternatives considered**  
GitLab CI · single mega-job.

**Pros**  
Fast feedback; Environments secrets; OIDC-ready.

**Cons**  
Filter maintenance; CI minutes.

**Future migration strategy**  
Preview envs, SBOM, canary; retire Spring/Java workflows after cleanup.

---

# 4. Repository Structure

## 4.1 Approved folder tree

```text
bookmyspace/
├── apps/
│   ├── app/                      # Flutter — Android, iOS, Web (role-aware)
│   │   ├── lib/
│   │   │   ├── app/              # bootstrap, GoRouter, theme
│   │   │   ├── core/             # Dio, auth session, errors, flags
│   │   │   └── features/         # feature-first slices
│   │   ├── test/
│   │   ├── integration_test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   └── website/                  # Next.js — marketing & SEO
│       ├── src/ (or app/)
│       ├── public/
│       ├── package.json
│       └── README.md
│
├── backend/
│   └── api/                      # NestJS modular monolith
│       ├── src/
│       │   ├── main.ts
│       │   ├── worker.ts         # BullMQ worker entry (same codebase)
│       │   ├── modules/
│       │   │   ├── identity/
│       │   │   ├── venue/
│       │   │   ├── booking/
│       │   │   ├── payment/
│       │   │   ├── notification/
│       │   │   ├── search/
│       │   │   ├── admin/
│       │   │   └── ai/
│       │   └── shared/           # prisma, authz, outbox, queue, flags, errors
│       ├── prisma/
│       ├── test/
│       ├── Dockerfile
│       └── package.json
│
├── packages/
│   ├── shared_ui/                # Flutter design system
│   ├── shared_models/            # Shared Dart models
│   ├── common_utils/             # Pure Dart helpers
│   └── api_contracts/            # OpenAPI v1+ (HTTP SoT)
│
├── infrastructure/
│   ├── docker/                   # Compose: Postgres + Redis
│   └── github-actions/
│
├── docs/
│   ├── CONSTITUTION.md
│   ├── ARCHITECTURE.md           # THIS FILE
│   ├── ARCHITECT_DECISIONS.md
│   ├── product/
│   ├── adr/                      # Historical; stack specifics superseded
│   ├── standards/
│   ├── strategies/
│   └── security/
│
├── melos.yaml
└── README.md
```

`services/` may remain as **empty extraction placeholders** but is not required in the day-one tree above.

**Legacy note:** Older `customer_flutter` / `owner_flutter` / `admin_web` / Spring `platform-api` paths are superseded by `apps/app` and `backend/api` after acceptance cleanup.

## 4.2 Folder explanations

| Path | Purpose |
|------|---------|
| `apps/app` | Single Flutter client; customer / owner / admin via authz + routes |
| `apps/website` | Next.js SEO and marketing |
| `backend/api` | Nest API + worker codebase |
| `backend/api/src/modules/*` | Bounded contexts |
| `backend/api/src/shared` | Cross-cutting kernel |
| `packages/*` | Shared Dart + OpenAPI contracts |
| `infrastructure/docker` | Local Postgres + Redis for BullMQ |
| `docs/CONSTITUTION.md` | Non-negotiable governance |
| `docs/ARCHITECTURE.md` | Architecture narrative (this file) |

---

# 5. Flutter Architecture (`apps/app`)

## 5.1 Feature-first structure

```text
lib/
├── app/
├── core/
└── features/
    ├── auth/
    ├── home/
    ├── search/
    ├── venue_detail/
    ├── booking/
    ├── payments/
    ├── owner/          # owner-ops features (gated by org permissions)
    ├── admin/          # platform admin features (gated by platform permissions)
    └── profile/
```

Each feature: `data/` · `domain/` · `presentation/`.  
Features do not import other features’ presentation. Shared UI → `packages/shared_ui`.

## 5.2 Role-aware shell

- After auth, load principal permissions from API.  
- GoRouter redirects by permission (not by hard-coded “app flavor” alone).  
- Customer, owner, and admin UX share one binary with clear module boundaries and feature flags.

## 5.3 Riverpod

- DI and async state boundary.  
- App-wide: session, Dio, feature flags.  
- Feature-scoped notifiers for screens.  
- Override in tests; no service locator.

## 5.4 GoRouter

- Declarative routes, deep links, auth redirects.  
- Shell navigators for primary tabs per role experience.  
- Next.js public pages hand off via universal links / custom scheme into booking routes.

## 5.5 Repository pattern

- Domain ports; data layer Dio + Freezed DTOs.  
- Widgets never call Dio directly.

## 5.6 Offline strategy

Online-first MVP: calm offline UI; no offline booking confirmation; server remains availability SoR. Optional short-lived read caches for cards only.

## 5.7 State management

Riverpod `AsyncValue` + Freezed immutable states. Forms validate locally; server codes via ErrorMapper.

## 5.8 Error handling

1. Offline → retry  
2. `401` → refresh → login  
3. Known Problem Details `code` → localized copy  
4. Else generic + correlation id  

Sentry for crashes; never log auth headers.

## 5.9 Responsive design

Mobile-first; owner/admin web breakpoints for rail/nav and denser tables. Touch targets ≥ 48dp.

## 5.10 Material 3 & theme

Material 3 + motion. Tokens in `shared_ui`. Light and dark mandatory. Next.js aims for brand family resemblance.

---

# 6. Backend Architecture

## 6.1 Modular monolith

One deployable; hard module boundaries; collaboration via application services + domain events (outbox → BullMQ). No cross-module repository joins across contexts.

## 6.2 NestJS modules

Per module: `api` · `application` · `domain` · `infrastructure`.  
Thin controllers; fat application services; pure domain helpers; Prisma only in infrastructure.

## 6.3 Prisma

- Schema + migrations owned by `backend/api`.  
- Explicit transactions for hold/confirm/payment.  
- Controllers never touch PrismaClient directly.

## 6.4 Validation & DTOs

- Boundary validation (single standard: class-validator **or** Zod—pick at scaffold).  
- DTOs ≠ Prisma models; role-aware response shaping.  
- Money: integer minor units + `INR`. Timestamps: ISO-8601 UTC.

## 6.5 Authentication flow

```
Client ↔ Supabase Auth (OTP/session)
     → Bearer JWT
     → Nest JWKS validation
     → map sub → User
     → load roles + permission set
     → TenantContext / Principal on request
```

## 6.6 Authorization

Permission-based RBAC (see § Permission-based RBAC). Org id from membership/resource—never from client alone.

## 6.7 Logging

Structured JSON: `correlationId`, `userId`, `organizationId`, business `event`. No secrets/PII dumps/payment payloads.

## 6.8 Exception handling

Domain errors → global filter → RFC 7807 Problem Details (`code`, `correlationId`).  
`400` validation · `401`/`403` authz · `409` conflicts · `500` generic.

## 6.9 Background jobs (BullMQ)

| Queue (examples) | Jobs |
|------------------|------|
| `outbox` | Publish domain events to handlers |
| `notifications` | FCM send, later email/WhatsApp |
| `booking` | Hold expiry, payment window expiry |
| `payments` | Reconciliation sweeps |
| `search` | Projection upserts |
| `ai` | Async generation/classification |

Workers share codebase (`worker.ts`); scale replicas independently from HTTP. All handlers **idempotent**.

## 6.10 API versioning

See § API versioning strategy. Base path `/api/v1`.

---

# 7. Database Design

> Design rules only — **no tables or SQL in this document.**

## 7.1 Conceptual relationships

```
User ──< Membership >── Organization ──< Venue ──< InventoryUnit
                         │
Booking (User + Org/Venue/Unit) ──< BookingEvent
Payment refs · OutboxMessage · IdempotencyRecord · AuditLog
FeatureFlag · Permission grants · Search projection · Media metadata
```

## 7.2 Naming

Tables/columns `snake_case`; PK `id` UUID; FK `{entity}_id`; indexes `idx_*`; uniques `uq_*`.

## 7.3 Migrations

Prisma Migrate only in prod. Expand → deploy → contract. Roll forward. Gate migrations before traffic switch.

## 7.4 Indexing

Always index `organization_id` and booking/availability access paths; FTS/geo on search projection; justify exotic indexes in migration comments.

## 7.5 Booking constraints

DB exclusion/unique on slot ranges · state machine · transactions · idempotency · optimistic versions · TTL holds (DB rows; Redis holds optional later for speed).

## 7.6 Soft delete

`deleted_at` for user-visible entities; partial uniques as needed; hard delete only for ephemera or DPDP erasure.

## 7.7 Audit fields

`id`, `created_at`, `updated_at`; org-owned → `organization_id`; append-only event/audit/webhook tables immutable.

---

# 8. Security

## 8.1 Authentication

Supabase JWT; HTTPS; short-lived access; secure device storage; rate-limit OTP/login.

## 8.2 Authorization

Permission checks on every privileged operation; automated cross-tenant tests; admin audit log.

## 8.3 Secrets

Env / GitHub Environments / secret manager; rotate on leak; never commit.

## 8.4 OWASP-aligned practices

Parameterized queries; BOLA prevention via AuthZ; CORS allowlist; security headers; dependency audit; no stack traces to clients.

## 8.5 Rate limiting

Edge/app limits on auth, search, booking, payment; Redis counters when multi-instance requires.

## 8.6 Input validation

Schema at boundary; body size limits; server recomputes payable amounts.

## 8.7 File upload security

See § Signed file upload pipeline.

---

# 9. Performance

## 9.1 Caching

CDN for Next.js + media. Redis primarily for BullMQ; product caches/holds when triggers hit. Postgres indexes first.

## 9.2 Pagination

Cursor for feeds; offset OK for small admin lists; cap `page_size`.

## 9.3 Lazy loading

Flutter lazy lists/images; card DTOs for lists; detail endpoints for full payloads.

## 9.4 Image optimization

Bounded uploads; derivatives (thumb/card/full); CDN; Next.js `Image` for marketing.

## 9.5 API response targets (p95 aspirational)

| Class | Target |
|-------|--------|
| Health | < 50 ms |
| Public/search cards | < 300 ms |
| Authenticated CRUD | < 500 ms |
| Hold/confirm | < 800 ms (correctness > speed) |
| Payment initiate | < 1000 ms (excl. user 3DS/UPI time) |

## 9.6 Database optimization

Fight N+1; narrow transactions; search projection via async jobs; read replicas under load.

---

# 10. Scalability

| Scale | Shape |
|-------|--------|
| **~1k users** | 1–2 API replicas, 1 worker, Postgres, Redis (BullMQ), Supabase Auth/Storage, Postgres FTS |
| **~100k users** | API+worker horizontal scale, read replica, CDN, Redis also for rate-limit/hot cache if triggered, extract notify/payment if blast radius demands |
| **~1M users** | OpenSearch, booking read models (allowlisted), S3+CDN if egress binds, partition history, gateway only after multi-service, pen-test/WAF |

**Unchanged across scales:** module names, org row tenancy, OpenAPI evolution via versions, Flutter feature-first app, Next.js public read model, outbox + BullMQ pattern.

---

# 11. DevOps

## 11.1 Docker

Compose: Postgres + Redis. Multi-stage Dockerfile for API/worker. Non-root. Tag by git SHA.

## 11.2 CI/CD (GitHub Actions)

| Workflow | Scope |
|----------|--------|
| `ci-api` | Nest lint/test/integration |
| `ci-flutter` | `apps/app` + packages |
| `ci-website` | Next.js lint/build |
| `deploy-staging` | migrate → deploy API/worker → smoke |
| `deploy-prod` | manual/tag, same digest |

## 11.3 Environments

Isolated secrets; separate Supabase projects for staging/prod preferred; feature flags for risky behavior.

## 11.4 Monitoring

RED metrics; booking/payment counters; OTEL traces; uptime on `/health`; BullMQ queue depth/fail alerts; webhook failure alerts.

## 11.5 Logging

Structured JSON; retention staging 7–14d; prod ~30d hot.

## 11.6 Backup & DR

Managed Postgres backups + PITR when available. Early targets: RPO ≤ 1h, RTO ≤ 4h. Quarterly restore drill. App rollback = previous digest; DB roll forward.

---

# 12. Testing Strategy

| Layer | Backend | Flutter | Next.js |
|-------|---------|---------|---------|
| Unit | Domain, use cases, pure mappers | Notifiers, mappers, ErrorMapper | Utils |
| Widget | — | Critical widgets + `shared_ui` goldens | — |
| API / contract | OpenAPI spectests, Problem Details | — | — |
| Integration | Nest + Postgres Testcontainers + Redis/BullMQ | Dio mocked / wiremock | Public API smoke |
| E2E | Few journeys: auth → search → hold → pay sandbox → confirm | `integration_test` selective | Crawl + Lighthouse on key templates |

**Mandatory:** tenancy denial, booking concurrency/idempotency, webhook replay, permission checks, outbox/BullMQ idempotent handlers.

---

# 13. Coding Standards

## 13.1 Naming

| Kind | Convention |
|------|------------|
| Folders (Dart features/packages) | `snake_case` |
| Dart files | `snake_case.dart` |
| Nest files | `*.module.ts`, `*.controller.ts`, `*.service.ts` |
| Classes | PascalCase |
| Providers | `fooProvider` |
| Permissions | `resource:action` strings |
| DB | `snake_case` |
| Branches | `feat/`, `fix/`, `docs/`, `security/`, `ci/` |
| Commits | Conventional Commits |

## 13.2 Branch strategy

Trunk-based on `main`; short-lived PRs; squash preferred; CI green; no force push to `main`.

## 13.3 Code review checklist

- [ ] Constitution compliance  
- [ ] Booking/money correctness if touched  
- [ ] Permission + tenancy checks  
- [ ] Tests included  
- [ ] OpenAPI updated if public API changed  
- [ ] No secrets/PII in logs  
- [ ] Idempotency for booking/payment mutations  
- [ ] Feature flag for risky behavior  
- [ ] a11y + light/dark for UI  

---

# 14. Risks

| Type | Risk | Mitigation |
|------|------|------------|
| Technical | Double-booking | Constraints, state machine, idempotency, TTL jobs |
| Technical | Redis/BullMQ outage | Outbox retains events; retry; HA Redis in prod |
| Technical | Nest cutover from Spring | Clean cutover post-accept; no dual SoR |
| Product | Category sprawl | Capability model |
| Product | Weak SEO | Next.js SSR/ISR public pages |
| Product | Fraud listings | KYC, moderation, AI flags assistive only |
| Security | Tenant leak | Server AuthZ + automated tests |
| Security | Webhook forgery | Signature verify + idempotency |
| Security | AI PII leakage | Scrub prompts; budget caps; no PAN/secrets |
| Scaling | Hot venues | Inventory design; optional Redis holds |
| Scaling | FTS ceiling | OpenSearch via outbox when triggered |

---

# 15. Future Evolution (≈5 years)

**Y0–1:** Nest monolith, Prisma, Supabase Auth/Storage, Flutter app, Next.js, BullMQ+outbox, FTS, Razorpay, FCM, Maps, assistive AI behind flags.  
**Y1–2:** Horizontal scale; Redis cache/holds; possible S3; extract notify/payment; WhatsApp governance.  
**Y2–3:** OpenSearch; allowlisted read models; enterprise OIDC; mature DPDP.  
**Y3–5:** Multi-service + gateway; regional expansion if needed; deeper category marketplace—**without** rewriting tenancy model or public contracts.

---

# 16. AI Module Architecture

## 16.1 Principles (product law)

- Assistive only; **never** on the critical synchronous book/pay path.  
- No auto-publish; no auto-ban solely from AI (moderator queue).  
- User must confirm suggestions before persistence.  
- PII/PAN/secrets scrubbed; budget caps and kill switch via feature flags.

## 16.2 Placement

Nest module `modules/ai` with ports:

- `AiCompletionPort` / `AiModerationPort`  
- Application services for: listing description assist, amenity suggestions, search synonym assist, fraud anomaly flags, owner insight narratives, review summaries (later).

## 16.3 Runtime shape

```
HTTP (opt-in, permissioned, flagged)
  → AiApplicationService (validate, scrub, authorize)
  → enqueue BullMQ `ai` job  OR  short sync call if latency budget allows
  → provider adapter
  → store suggestion artifact (not published venue state)
  → client shows suggestion → user edits/confirms → venue/booking modules write SoR
```

## 16.4 Data & safety

- Log prompt template id + acceptance metrics—not raw sensitive payloads.  
- Org-scoped insights only from that org’s metrics.  
- Disable via `ff.ai.*` flags instantly.

---

# 17. Feature Flag Strategy

## 17.1 Goals

Safe rollout of booking modes, categories, payments, AI, and experimental UX without binary deploys as the only control.

## 17.2 Design

| Item | Rule |
|------|------|
| Naming | Dotted keys: `booking.instant_book`, `ai.description_assist` |
| Storage | DB-backed flags (+ optional provider later); cached in API with short TTL |
| Evaluation | By env, percentage, org id, platform role, app version |
| Ownership | Platform admin permission `admin:flags` |
| Client | Bootstrap flags endpoint; Riverpod exposure; never trust client to enable privileged server behavior |
| Server | Every flagged path re-checks server-side |

## 17.3 Mandatory flag candidates

- Booking modes (instant / request-to-book / pay-at-venue)  
- Category capability enablement  
- Razorpay live vs stricter sandbox behaviors in staging  
- AI features individually  
- WhatsApp channel  

## 17.4 Anti-patterns

Flags as permanent dead code; client-only gates for security; uncleared flags after full rollout (schedule cleanup).

---

# 18. Event-Driven Internal Architecture

## 18.1 Pattern

**Domain events + transactional outbox + BullMQ dispatch** (not Kafka day one).

```
Use case transaction:
  1. Mutate aggregates (booking/payment/venue)
  2. Insert OutboxMessage(s) same transaction
Commit
  → Outbox poller/publisher enqueues BullMQ jobs
  → Handlers consume at-least-once, idempotently
```

## 18.2 Example events

`BookingHeld` · `BookingPendingPayment` · `BookingConfirmed` · `BookingCancelled` · `BookingExpired` · `PaymentCaptured` · `PaymentRefunded` · `VenuePublished` · `VenueUnpublished` · `MediaUploaded`

## 18.3 Handler rules

- Idempotent (handler dedupe keys / event id).  
- No business writes that skip AuthZ invariants.  
- Failures retry with backoff; poison messages inspectable.  
- Cross-context communication prefers events over reaching into another module’s tables.

## 18.4 Evolution

When throughput demands, outbox publisher emits to SQS/PubSub/Kafka; **outbox remains the write-side guarantee**.

---

# 19. Booking State Machine

Aligned with product business rules (`BR-BOOK-*`):

```text
                 ┌──────────┐
         hold    │   HELD   │──TTL──▶ EXPIRED
            ───▶ │          │──cancel──▶ CANCELLED
                 └────┬─────┘
                      │ confirm (instant) / owner accept (request)
                      ▼
              ┌─────────────────┐
              │ PENDING_PAYMENT │──TTL/fail/cancel──▶ CANCELLED / EXPIRED
              └────────┬────────┘
                       │ Razorpay webhook: payment captured
                       ▼
                 ┌───────────┐
                 │ CONFIRMED │──policy cancel──▶ CANCELLED (refund per policy)
                 └───────────┘
```

**Rules:**

- Illegal transitions → Problem Details conflict/validation error.  
- Hold TTL default 10 minutes (configurable; request-to-book soft-reserve longer).  
- Payment capture webhook is truth for `CONFIRMED`.  
- Double-booking prevention layers: DB constraints, versions, idempotency, TTL workers; Redis hold keys optional under load.  
- Capacity inventory decrements atomically where applicable.

---

# 20. Permission-Based RBAC

## 20.1 Model

1. **Authenticate** globally (Supabase → User).  
2. **Authorize** via permission strings, not role name checks scattered in code.  
3. Roles (platform + org) **grant** permissions; code checks `permission`.  
4. Catalog source: `docs/product/06-roles-permissions.md`.

## 20.2 Role families

- **Platform:** `PLATFORM_SUPER_ADMIN`, `PLATFORM_ADMIN`, `PLATFORM_MODERATOR`, `PLATFORM_SUPPORT`, …  
- **Organization:** `ORG_OWNER`, `ORG_MANAGER`, `ORG_STAFF`, `ORG_ACCOUNTANT`  
- **Marketplace:** `CUSTOMER` (+ later vendor/franchise roles)

## 20.3 Permission examples

`venue:write` · `venue:publish` · `calendar:write` · `booking:cancel` · `marketplace:book` · `admin:moderate` · `admin:flags` · `media:write`

## 20.4 Enforcement

- Nest guards/interceptors load permission set once per request.  
- Org-scoped routes resolve membership then check permission **and** resource org match.  
- Staff permissions cannot exceed inviter’s role (product rule).  
- Flutter hides UI by permission but **server always enforces**.

---

# 21. Project Constitution Reference

This ADD is subordinate to and implements:

**[`docs/CONSTITUTION.md`](CONSTITUTION.md)**

| Article | Summary |
|---------|---------|
| I | Correctness of booking & money first |
| II | Modular monolith + category capability model |
| III | Supabase Auth + Nest permission RBAC; no client org trust |
| IV | Flutter `apps/app` + Next.js SEO; ≤ 3 taps; a11y |
| V | OpenAPI contracts; `/api/v1`; flags; expand/contract migrations |
| VI | AI-legible boundaries and ports |
| VII | Amendments require founder approval |

PRs that violate the Constitution are out of scope regardless of local convenience.

---

# 22. API Versioning Strategy

## 22.1 Format

```text
https://api.bookmyspace.in/api/v1/...
```

Integer majors only (`v1`, `v2`). OpenAPI per version under `packages/api_contracts/openapi/v1/`.

## 22.2 Compatibility

**Non-breaking (allowed in v1):** add optional response field; add endpoint; add optional request field with default; add enum values only if clients ignore unknowns (prefer flags for new booking modes).

**Breaking (needs v2):** remove/rename field; change type/meaning; make optional required; change auth scheme; change existing error `code` semantics.

## 22.3 Deprecation

Announce via changelog + `Deprecation` / `Sunset` headers; **≥ 90 days** overlap for mobile; remove only when telemetry shows negligible traffic.

## 22.4 Client rules

Apps pin to a major version; ignore unknown fields; unknown error codes → generic handler. Idempotency-Key and X-Correlation-Id are part of the platform contract for mutating booking/payment APIs.

---

# 23. Signed File Upload Pipeline

```text
1. Client requests upload intent (venue media or KYC) with contentType + size
2. Nest authorizes (permission + org/user ownership)
3. Nest validates allowlist (type/size) and creates Media metadata row (PENDING)
4. Nest mints short-lived signed upload URL (Supabase Storage)
   key: org/{organizationId}/...  OR  user/{userId}/...
5. Client uploads DIRECTLY to Storage (API does not proxy bytes)
6. Client confirms upload OR Storage webhook/worker verifies object
7. Nest marks Media AVAILABLE; optionally enqueues derivative job (BullMQ)
8. Public read uses CDN/signed download as policy dictates
   KYC buckets remain private
```

**Security controls:** private KYC; content-type allowlists; size caps; short TTL signatures; no service-role in clients; later malware scanning worker; `MediaStoragePort` for S3 migration.

---

# 24. Category Capability Model (retained)

Venue categories plug into a shared kernel via capabilities—not forked apps:

| Capability dimension | Examples |
|----------------------|----------|
| Inventory unit | hall, room, pitch, desk, zone, entire property |
| Pricing model | hourly, daily, package, seats |
| Availability model | slot grid, overnight, capacity pool |
| Amenities schema | category-specific filterable attributes |
| Booking mode flags | instant, request-to-book, partial pay |

New categories = configuration + validation plugins inside `venue` / `booking`, not new deployables.

---

## Open Questions (final review)

Direction is approved; confirm these before implementation:

1. Mark this ADD revision **Accepted**?  
2. Confirm monorepo tree with **single** Flutter `apps/app` (role-aware) vs revisit multi-app split?  
3. Confirm **Next.js** for `apps/website` (this revision)?  
4. Confirm **BullMQ + Redis** as required day-one infra (not cache-deferred Redis)?  
5. Prisma validation library preference: **class-validator** vs **Zod**?  
6. Postgres hosting: Supabase-managed vs separate managed Postgres (Auth/Storage only on Supabase)?  
7. MVP auth: email OTP only vs **phone OTP** included?  
8. Deploy host preference: Fly / Render / Cloud Run / ECS / VM / other?  
9. Spring `platform-api` cleanup: immediate archive after Accept vs Nest parity first?  
10. Universal-link domain for Next.js → Flutter handoff locked?  
11. DPDP MVP: export/delete APIs now vs consent logging + backlog?  
12. AI provider preference for MVP (OpenAI / other) and monthly budget cap?

### Sign-off

| Role | Name | Date | Decision |
|------|------|------|----------|
| Founder | | | Approved / Changes requested |
| Notes | | | |

---

*End of Architecture Decision Document — documentation only; wait for final acceptance before implementation.*
