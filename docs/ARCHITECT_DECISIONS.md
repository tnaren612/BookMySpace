# BookMySpace — Architect Decisions (Source of Truth)

| Field | Value |
|-------|--------|
| **Document** | `docs/ARCHITECT_DECISIONS.md` |
| **Role** | Permanent CTO source of truth for technology & architecture decisions |
| **Status** | **Direction approved — final review via `docs/ARCHITECTURE.md`** |
| **Date** | 2026-08-02 |
| **Product** | India's Venue Commerce Platform (Marketplace + Owner OS + Platform Admin) |
| **Narrative ADD** | [`docs/ARCHITECTURE.md`](ARCHITECTURE.md) |
| **Constitution** | [`docs/CONSTITUTION.md`](CONSTITUTION.md) |
| **Optimization axes** | Simplicity · Maintainability · Performance · Scalability · Dev Productivity · AI-assisted development · UX · Security · Cost Efficiency |

---

## STOP — No implementation until final ADD acceptance

> **HARD GATE:** Architecture **direction is approved**. Do **not** scaffold NestJS features, generate SQL, introduce Supabase projects, or delete Spring Boot until `docs/ARCHITECTURE.md` is marked **Accepted** after final review.
>
> Discarding Spring under `backend/platform-api` is a **follow-up after acceptance**.
>
> Product requirements under `docs/product/` remain valid for *what* to build. This file + `ARCHITECTURE.md` govern *how*.

---

## Table of contents

1. [How to use this document](#1-how-to-use-this-document)
2. [Decision log status](#2-decision-log-status)
3. [Optimization principles](#3-optimization-principles)
4. [Challenged assumptions](#4-challenged-assumptions)
5. [D1 — Overall system shape](#d1--overall-system-shape)
6. [D2 — Backend runtime & ORM](#d2--backend-runtime--orm)
7. [D3 — Auth (Supabase Auth + Nest)](#d3--auth-supabase-auth--nest)
8. [D4 — Object storage](#d4--object-storage)
9. [D5 — Database, tenancy & booking concurrency](#d5--database-tenancy--booking-concurrency)
10. [D6 — Flutter client architecture](#d6--flutter-client-architecture)
11. [D7 — Clients & SEO website](#d7--clients--seo-website)
12. [D8 — Payments (Razorpay)](#d8--payments-razorpay)
13. [D9 — Notifications](#d9--notifications)
14. [D10 — Maps](#d10--maps)
15. [D11 — Caching (Redis deferred)](#d11--caching-redis-deferred)
16. [D12 — Search](#d12--search)
17. [D13 — Events & async](#d13--events--async)
18. [D14 — Monorepo structure](#d14--monorepo-structure)
19. [D15 — API style](#d15--api-style)
20. [D16 — CI/CD & Docker](#d16--cicd--docker)
21. [D17 — Observability](#d17--observability)
22. [D18 — AI-assisted development conventions](#d18--ai-assisted-development-conventions)
23. [D19 — Cost efficiency](#d19--cost-efficiency)
24. [D20 — Security baseline](#d20--security-baseline)
25. [D21 — Relationship to PRD & old Spring docs](#d21--relationship-to-prd--old-spring-docs)
26. [Target evolution roadmap](#26-target-evolution-roadmap)
27. [Approval checklist](#27-approval-checklist)

---

## 1. How to use this document

- **Binding after approval:** Engineering must align implementation and subsequent ADRs with this file.
- **Decision template:** Every decision below includes Decision, Alternatives, Pros, Cons, Why chosen, and Migration strategy.
- **Supersession:** Spring-era ADRs and architecture docs that prescribe Spring Boot, custom JWT issuance, day-one Redis, or S3-as-default remain useful for *product/domain intent* but are **not binding for backend stack**. See [D21](#d21--relationship-to-prd--old-spring-docs).
- **Challenge culture:** Prefer the simplest design that can later scale to millions of users/bookings without a rewrite of domain boundaries.

---

## 2. Decision log status

| ID | Decision area | Status |
|----|---------------|--------|
| D1 | Modular NestJS monolith (not microservices / not BFF) | Direction approved |
| D2 | NestJS + TypeScript + Prisma + PostgreSQL | Direction approved |
| D3 | Supabase Auth; Nest validates JWT; app-level tenancy first | Direction approved |
| D4 | Supabase Storage (signed URLs); S3 migration path | Direction approved |
| D5 | Org row-level tenancy; DB constraints for booking races | Direction approved |
| D6 | Single Flutter `apps/app` + Material 3 + Riverpod + GoRouter + Freezed + Dio | Direction approved |
| D7 | Flutter app (role-aware) + **Next.js** SEO site | Direction approved |
| D8 | Razorpay isolated module; webhooks; idempotency | Direction approved |
| D9 | FCM first; email/WhatsApp later | Direction approved |
| D10 | Google Maps Platform | Direction approved |
| D11 | Redis **required for BullMQ**; product cache/holds still trigger-based | Direction approved |
| D12 | Postgres FTS (+ geo) first; OpenSearch later | Direction approved |
| D13 | Transactional outbox + **BullMQ** workers (no Kafka day one) | Direction approved |
| D14 | Monorepo: `apps/app`, `apps/website` (Next.js), `backend/api` | Direction approved |
| D15 | Versioned REST + OpenAPI as contract | Direction approved |
| D16 | Docker Compose local; GitHub Actions path-filtered CI | Direction approved |
| D17 | Structured logs + OpenTelemetry + error tracking | Direction approved |
| D18 | AI module (assistive) + AI-friendly boundaries | Direction approved |
| D19 | Supabase tiering; avoid premature clusters | Direction approved |
| D20 | Secrets, tenancy, webhook verification baseline | Direction approved |
| D21 | PRD valid; Spring ADRs superseded for stack | Direction approved |

**Overall document status:** Direction approved — final acceptance tracked on `docs/ARCHITECTURE.md`.

---

## 3. Optimization principles

When two options conflict, prefer in this order unless a decision below explicitly overrides:

1. **Correctness** of booking & money (never sacrifice for speed of delivery)
2. **Simplicity** of ops and cognitive load for a small team + AI agents
3. **Maintainability** of clear module boundaries
4. **Security** (tenancy, secrets, webhooks)
5. **Dev productivity / AI-assisted velocity**
6. **UX** (≤3 taps for primary tasks; Material 3 premium feel)
7. **Performance & scalability** via boring primitives first
8. **Cost efficiency** (pay for managed services that remove undifferentiated work)

---

## 4. Challenged assumptions

This section deliberately pushes back on naive defaults or prompt defaults where debt would result.

| Assumption | Verdict | Why |
|------------|---------|-----|
| Microservices or per-domain services day one | **Reject** | Booking + payment need ACID; small team; extraction later from packages is cheaper than distributed transactions now. |
| Keep Spring Boot (prior ADRs) | **Reject for backend direction** | User-approved TypeScript stack; Nest + Prisma is better for AI codegen, shared language with SEO site, and faster iteration. Spring code is **legacy pending discard after approval**. |
| Custom JWT issuer + refresh rotation (old ADR-004) | **Reject as day-one build** | Supabase Auth supplies OTP/social, refresh, and session UX. Nest validates JWTs and owns **authorization** (RBAC/tenancy). Revisit custom IdP only if multi-enterprise SSO demands it. |
| Rely on Supabase RLS as primary tenancy for all app data | **Reject as primary** | Nest owns booking/payment invariants. RLS against the same DB is optional defense-in-depth later; app-level `organization_id` filters + tests are mandatory first. Direct client→Postgres for business writes is forbidden. |
| Redis day one (old ADR-003) | **Defer** (agree with reset) | Postgres + careful booking locks cover MVP. Introduce Redis when rate-limits, slot holds, or hot caches prove necessary (see D11). |
| OpenSearch / Kafka day one | **Defer** | FTS + outbox scale further than teams expect; brokers add ops tax. |
| Flutter Web for SEO public pages | **Reject** | Crawlability and social previews matter for India discovery growth; keep a separate SSR/SSG site (D7). |
| Astro as default SEO framework | **Superseded — founder chose Next.js** | `apps/website` is **Next.js** (SSR/SSG/ISR) for SEO/marketing. Flutter Web remains non-SEO. |
| Separate BFF per client | **Reject early** | One Nest API with role-aware DTOs; BFFs appear only if payload/latency divergence becomes severe. |
| `flutter_hooks` / `auto_route` instead of Riverpod + GoRouter | **Keep approved stack** | Not clearly better for AI-assisted development; Riverpod + GoRouter + Freezed is widely documented and codegen-friendly. |
| Dual-write Spring + Nest during transition | **Reject** | After approval, plan a clean cutover: Nest becomes SoR; do not run two backends for the same domain. |

**Accepted without challenge (reasoned):** Flutter Material 3 apps; Nest modular monolith; PostgreSQL; Razorpay; FCM; Google Maps; Docker + GitHub Actions; org-scoped row tenancy concepts from `docs/architecture/03-multi-tenancy.md`.

---

## D1 — Overall system shape

### Decision

Build a **single deployable NestJS modular monolith** (`backend/api`) with **bounded-context modules** (identity bridge, venue, booking, payment, notification, search, admin). Reserve `services/*` for future physical extraction. **No API gateway / BFF day one.** Clients talk to one versioned HTTP API.

### Alternatives considered

| Option | Summary |
|--------|---------|
| A | Microservices (auth, booking, venue, payment, notification, search) |
| B | Modular NestJS monolith (chosen) |
| C | Nest + separate BFF per Flutter app |
| D | Serverless-only (Supabase Edge + DB triggers as primary app logic) |

### Pros (chosen)

- One process for local/dev; ACID bookings + outbox in one transaction
- Package boundaries mirror future services without network tax
- AI agents reason about one backend tree
- Scales to high load via vertical + read replicas long before service split

### Cons

- Requires module discipline (lint/architecture tests)
- Single deploy unit until extraction
- Hot modules can share a noisy neighbor until split

### Why this was chosen

Simplest shape that still reaches millions of users if modules stay pure. Microservices fail early-stage velocity and payment consistency. BFF multiplies endpoints without product value yet. Edge-function-as-backend buries booking invariants in hard-to-test SQL/triggers.

### Future migration strategy

Extract payment or notification first when: independent scaling, separate blast radius, or team ownership demands it. Move module → `services/<name>` behind the same OpenAPI contract; introduce a gateway only after ≥2 services need shared auth/rate-limit.

---

## D2 — Backend runtime & ORM

### Decision

**NestJS + TypeScript + Prisma** against **PostgreSQL**. Domain logic in Nest modules/services; Prisma for schema, migrations, and type-safe queries. Prefer explicit transactions for booking/payment.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Spring Boot 3 + JPA (prior direction) | Superseded — not binding |
| NestJS + TypeORM | Rejected — weaker migration UX; more footguns |
| NestJS + Drizzle | Viable alternative; slightly more SQL control, less ecosystem/DX for Nest beginners/AI |
| Fastify (raw) + Prisma | Rejected — reinvent Nest modules, guards, DI, OpenAPI |
| Supabase client as sole data access from Flutter | Rejected — bypasses server invariants |

### Pros

- TypeScript end-to-end with website tooling mental model
- Prisma schema is AI-legible and migration-friendly
- Nest guards/pipes/modules map cleanly to tenancy & RBAC
- Excellent hiring/AI training data density

### Cons

- Prisma N+1 / complex query patterns need discipline
- Some advanced Postgres features need `$queryRaw`
- Cold-start less relevant (long-running API) but Node event-loop care required for CPU-heavy work

### Why this was chosen

Best balance of productivity, AI-assisted codegen, and maintainability for this product. Drizzle is a close second if the team wants SQL-first; **not** chosen unless founders prefer raw SQL ergonomics over Prisma DX. Spring is discarded as direction (implementation removal is post-approval).

### Future migration strategy

- ORM swap (Prisma → Drizzle/Kysely) is painful; avoid by encapsulating repositories per module.
- Runtime swap (Nest → other) only if Node becomes a proven bottleneck; extract hot paths as workers first.

---

## D3 — Auth (Supabase Auth + Nest)

### Decision

- **Supabase Auth** issues sessions / JWTs (email OTP, phone OTP as product needs, OAuth later).
- **NestJS** validates Supabase JWTs (JWKS), maps `sub` → platform `User`, and enforces **RBAC + org membership**.
- **Tenancy:** application-level `organization_id` scoping is mandatory. **Postgres RLS is optional later**, not the primary authorization path for Nest-owned tables.
- Clients never receive service-role keys. Service role stays server-side only (Nest / CI).

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Custom JWT + refresh (old ADR-004) | Deferred — reinvent auth UX/security |
| Keycloak / Auth0 / Cognito day one | Deferred — cost/ops until enterprise SSO |
| Supabase RLS-only, thin Nest | Rejected — booking/payment logic belongs in app |
| Clerk | Viable SaaS alt; Supabase wins for India stack cohesion with Storage |

### Pros

- Fast delivery of login, refresh, password/OTP flows
- Less custom crypto and session storage
- Aligns with Storage and possible future Realtime

### Cons

- Vendor coupling for identity
- JWT claims must be carefully synced with app roles (Supabase `app_metadata` vs our Membership table — prefer **our DB as SoR for roles**)
- Outage/dependency on Supabase Auth availability
- Must still build account linking, KYC ties, and org invites ourselves

### Why this was chosen

Auth is undifferentiated heavy lifting. Supabase accelerates MVP while Nest retains control of **who can mutate which org’s inventory**. Roles live in BookMySpace Postgres (memberships/permissions); JWT only proves identity.

### Security trade-offs (explicit)

| Risk | Mitigation |
|------|------------|
| Stolen access token | Short-lived JWT; HTTPS; secure storage on device |
| Client spoofs `organizationId` | Ignore client org claim; resolve from membership |
| Service role leak | Never ship to apps; rotate immediately if exposed |
| Confused deputy via RLS bypass | Nest uses DB credentials that are **not** end-user RLS principals for writes; app filters + tests |
| Webhook/user spoof | Separate from auth: see payments/storage |

### Future migration strategy

If leaving Supabase Auth: introduce OIDC-compatible IdP; Nest already validates JWT → swap issuer/JWKS; keep User/Membership tables stable. Export users via Supabase admin APIs during migration window.

---

## D4 — Object storage

### Decision

**Supabase Storage** for venue media and KYC docs with **signed upload/download URLs** issued by Nest. Object keys prefixed `org/{organizationId}/...` or `user/{userId}/...`. App servers never proxy large binaries.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| AWS S3 + CloudFront direct | Strong long-term; more IAM/CDN setup day one |
| GCS / R2 | Viable; less India-dev familiarity than S3 |
| Store blobs in Postgres | Forbidden |

### Pros

- One vendor surface with Auth for early team
- Signed URLs keep Nest out of bandwidth path
- Adequate for MVP image volumes

### Cons

- Egress/CDN limits on lower tiers
- Vendor lock-in vs S3 API (Supabase is S3-compatible-ish via underlying stack but treat as product API)
- Need explicit virus/type validation pipeline later

### Why this was chosen

Cost and speed for early media. Matches “avoid premature infra.” S3 remains the scale/CDN endgame if media traffic or compliance requires it.

### Future migration strategy

Abstract behind `MediaStoragePort` in Nest. Migrate objects with key-preserving copy to S3 + CDN; update URL minting only. DB stores storage provider + object key, not hard-coded host URLs when avoidable.

---

## D5 — Database, tenancy & booking concurrency

### Decision

- **PostgreSQL** is the system of record for all business data.
- **Prisma** migrations own schema.
- **Multi-tenancy:** shared schema, **row-level `organization_id`** on owner-owned entities; platform Users are global; Bookings reference customer user + organization/venue (marketplace join). Aligns with `docs/architecture/03-multi-tenancy.md` concepts (stack-agnostic).
- **Never** trust client-supplied org id as authority.
- **Booking concurrency (conceptual):**
  - Unique / exclusion constraints on inventory slot ranges (or equivalent serialized hold rows)
  - Explicit booking state machine
  - Transactional create with conflict → deterministic error
  - Idempotency keys on booking create & payment confirm
  - Optimistic version column on contested aggregates where useful
  - Short-lived holds may start as DB rows with TTL; Redis holds only after D11 triggers

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Schema-per-tenant | Rejected — marketplace search nightmare |
| DB-per-tenant | Rejected until enterprise contract |
| MongoDB primary | Rejected — relational constraints for bookings |
| Availability only in Redis | Rejected — durability/audit insufficient |

### Pros

- Marketplace queries stay simple
- Strong constraints prevent double-booking classes of bugs
- Clear audit and GST/reporting foundation

### Cons

- Hot venues can contend on rows — design inventory units carefully
- Must index `(organization_id, ...)` everywhere relevant
- Soft-delete + DPDP erasure workflows needed later

### Why this was chosen

Correctness and marketplace UX beat isolation theater. Org row-level tenancy is the proven model for hybrid marketplace + SaaS.

### Future migration strategy

Add Postgres RLS as defense-in-depth; read replicas for search/list; partition booking history by time when volume demands; dedicated DB only for rare enterprise deals.

---

## D6 — Flutter client architecture

### Decision

**Single Flutter app** at `apps/app` (Android, iOS, Web) with **role-aware** customer / owner / admin experiences:

| Concern | Choice |
|---------|--------|
| UI | Material 3, premium motion, ≤3-tap primary flows |
| State | Riverpod |
| Routing | GoRouter (permission-aware redirects) |
| Models | Freezed (+ json_serializable) |
| HTTP | Dio (auth interceptor, idempotency headers) |
| App | `apps/app` only |
| Shared | `packages/shared_ui`, `shared_models`, `common_utils` via Melos |

Feature-first folders (`features/<name>`) + thin `core/` (api client, auth session, errors, flags).

### Alternatives considered (challenged)

| Option | Verdict |
|--------|---------|
| Three separate Flutter apps | Superseded — founder chose single app tree |
| Bloc / Cubit | Fine; Riverpod preferred |
| auto_route | GoRouter sufficient |
| GraphQL client | Rejected until API shape demands it |

### Pros

- One release train; shared design system; simpler monorepo
- Codegen-friendly for AI

### Cons

- Role complexity requires strict permission guards and feature modules
- Freezed/build_runner CI friction

### Why this was chosen

Founder-approved repository shape; avoids maintaining three app binaries while preserving Material 3 + Riverpod + GoRouter.

### Future migration strategy

If admin density explodes, extract admin web later without rewriting customer/owner flows.

---

## D7 — Clients & SEO website

### Decision

| Surface | Technology | Job |
|---------|------------|-----|
| Transactional app | Flutter `apps/app` (Android/iOS/Web) | Customer, owner, admin via role-aware modules |
| Public SEO / marketing | **Next.js** (SSR/SSG/ISR) in `apps/website` | City pages, venue public pages, blogs, crawlable HTML |

Public pages deep-link / hand off into Flutter for authenticated booking. **Flutter Web is not the SEO strategy.**

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Flutter Web for all public pages | Rejected — SEO |
| Astro SSR | Superseded — founder chose Next.js |
| Separate React admin day one | Deferred (admin lives in Flutter app first) |
| RN/Capacitor | Rejected — Flutter already chosen |

### Pros

- Organic growth channel for India city/venue queries
- Next.js hosting/ISR ecosystem; shared TS familiarity with Nest

### Cons

- Two web stacks (Next.js + Flutter Web)
- Design token parity is “family resemblance,” not pixel-identical

### Why this was chosen

Founder approval: Next.js for SEO/marketing; single Flutter app for transactional UX.

### Future migration strategy

CDN cache HTML; public read API/OpenAPI stable if site framework evolves.

---

## D8 — Payments (Razorpay)

### Decision

- **Razorpay** for India rails (UPI, cards, netbanking, refunds).
- Payment logic in an **isolated Nest module** (future extractable service).
- **Never** trust client “payment success”; **webhook + server verification** is source of truth.
- Verify webhook signatures; store raw events; process **idempotently**.
- Idempotency keys on initiate/confirm; ledger-style payment records; daily reconciliation job concept.
- No PAN/card data stored (PCI scope minimization).

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Paytm / PhonePe primary | Secondary later; Razorpay is broader platform default |
| Stripe-only | Weak India UPI coverage relative to Razorpay |
| Inline payment inside booking service without isolation | Rejected |

### Pros

- Correctness under retries and double-taps
- Clear blast radius and audit trail
- Matches PRD payment stories

### Cons

- More upfront module design
- Webhook ops (retries, poison messages) must be monitored

### Why this was chosen

Financial correctness is existential (P0). Isolation + idempotency is non-negotiable regardless of Nest vs Spring.

### Future migration strategy

Extract `payment-service` when volume or compliance demands; keep webhook ingress stable. Multi-acquirer abstraction only when a second provider is real.

---

## D9 — Notifications

### Decision

- **FCM** for push (customer + owner apps) first.
- Notification module sends via provider adapters; triggered from **outbox** handlers.
- **Email** and **WhatsApp** Business API later (cost controls, template governance).
- User notification preferences before WhatsApp scale-up.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| WhatsApp day one for all tx messages | Deferred — cost & template risk |
| OneSignal abstracting FCM | Optional later |
| SMS-only | Fallback channel, not primary UX |

### Pros

- Push covers transactional booking updates cheaply
- Adapter pattern allows channel expansion

### Cons

- Android/iOS permission UX
- WhatsApp eventual complexity (opt-in, pricing)

### Why this was chosen

Matches India mobile-first UX without burning SMS/WhatsApp budget before product-market fit.

### Future migration strategy

Add channels behind `Notifier` interface; digests to reduce cost; extract notification worker under load.

---

## D10 — Maps

### Decision

**Google Maps Platform** for maps SDK in Flutter, geocoding/places as needed, and distance/display. Store `lat`/`lng` (and PostGIS later if needed) in Postgres; do not make Google the system of record for venues.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Mapbox | Viable; Google has stronger India familiarity for users |
| OpenStreetMap self-host | Ops-heavy early |
| Lat/lng only without map UI | Insufficient for discovery UX |

### Pros

- Expected UX for Indian consumers
- Mature Flutter plugins

### Cons

- Cost at scale (cache geocodes; curb autocomplete abuse)
- API key restriction mandatory (bundle ID / HTTP referrer)

### Why this was chosen

Product discovery journeys require maps; Google is the pragmatic default.

### Future migration strategy

Wrap map/geocode behind a port; swap providers if pricing forces it; keep coordinates in DB.

---

## D11 — Redis (BullMQ required; cache/holds trigger-based)

### Decision

**Redis is required day one** as the BullMQ broker (see D13). Product uses of Redis remain explicit and trigger-based:

1. Slot-hold contention causes measurable booking latency/lock pain → short-lived holds
2. API rate-limiting needs a distributed counter across instances
3. Hot read paths need sub-50ms cache after query optimization
4. Multi-instance ephemeral shared state

Redis is **never** business SoR. Booking correctness remains Postgres constraints + state machine.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| No Redis until cache pain | Rejected — BullMQ needs Redis |
| Redis-as-cache day one for everything | Rejected — junk-drawer risk |
| Kafka instead of BullMQ | Rejected for day one |

### Pros

- Reliable job retries/delayed work via BullMQ
- Same Redis can later serve rate-limit/holds without new broker

### Cons

- Redis HA required in production earlier than “cache-only” plan

### Why this was chosen

Founder-approved BullMQ for background jobs; outbox + queue is the async backbone.

### Future migration strategy

Key prefixes `org:{id}:` / `user:{id}:` / `bull:` ; document TTLs per product use case.

---

## D12 — Search

### Decision

**PostgreSQL FTS + structured filters + geo (bounding box / distance)** for MVP. Maintain a `venue_search_document` (or equivalent) projection updated via outbox. **OpenSearch/Elasticsearch later** when relevance tuning, latency, or scale outgrows SQL.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| OpenSearch day one | Premature ops |
| Algolia/Meilisearch day one | Cost; consider mid-tier if FTS UX fails |
| Client-only filter | Rejected |

### Pros

- One database to operate
- Good enough for early catalog sizes
- Aligns with prior ADR-007 intent (stack-agnostic)

### Cons

- Advanced ranking, typo tolerance, synonyms harder in SQL
- Heavy write fan-out to projection must stay disciplined

### Why this was chosen

Discovery quality can iterate in SQL far longer than teams assume; OpenSearch is an extraction, not a foundation dependency.

### Future migration strategy

Search module already isolated; dual-write/outbox into OpenSearch; cut reads when parity ok.

---

## D13 — Events & async (outbox + BullMQ)

### Decision

- **Domain events** + **transactional outbox** in Postgres (write-side guarantee).
- **BullMQ** on Redis for named queues, retries, delayed jobs, worker scaling.
- Pattern: mutate + outbox in one transaction → dispatcher enqueues BullMQ → idempotent handlers.
- Queues include: outbox dispatch, notifications, booking TTL, payments reconcile, search projection, AI.
- **No Kafka/SQS day one.**
- Handlers **idempotent** (at-least-once).

### Alternatives considered

| Option | Verdict |
|--------|---------|
| In-process only / Nest cron alone | Insufficient for retries & scale |
| Dual write DB + queue without outbox | Rejected — inconsistency |
| Kafka day one | Rejected |
| Prisma middleware side effects only | Rejected |

### Pros

- Reliable async; visible queues; horizontal workers; fits modular monolith

### Cons

- Redis required; queue ops/monitoring needed

### Why this was chosen

Founder-approved BullMQ; keeps booking/payment writes transactional while unlocking durable async work.

### Future migration strategy

Outbox publisher may later emit to SQS/PubSub/Kafka; **outbox remains write-side guarantee**.

---

## D14 — Monorepo structure

### Decision

Remain a **single monorepo**. Founder-approved target layout:

```text
bookmyspace/
├── apps/
│   ├── app/                     # Flutter (Android, iOS, Web) — role-aware
│   └── website/                 # Next.js marketing & SEO
├── backend/
│   └── api/                     # NestJS modular monolith
│       ├── src/modules/{identity,venue,booking,payment,notification,search,admin,ai}
│       ├── src/shared/          # guards, prisma, errors, outbox, BullMQ, flags
│       ├── prisma/
│       └── Dockerfile
├── packages/{shared_ui,shared_models,common_utils,api_contracts}
├── infrastructure/docker/       # Postgres + Redis (BullMQ)
├── docs/{CONSTITUTION.md,ARCHITECTURE.md,ARCHITECT_DECISIONS.md,...}
├── melos.yaml
└── README.md
```

**Tooling:** Melos for Dart; npm/pnpm for Nest + Next.js; path-filtered GitHub Actions.

**Note on current repo:** Spring `platform-api` and older multi-app Flutter paths are **superseded pending post-acceptance cleanup**.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Polyrepo | Rejected early |
| Keep `platform-api` name for Nest | Optional rename; `backend/api` is clearer |
| Bazel | Overkill |
| Turborepo for everything | Optional later for JS; not required to start |

### Pros

- Atomic cross-stack PRs
- AI agents see full system
- Matches existing apps/packages layout

### Cons

- CI complexity (mitigate with path filters)
- Need clear CODEOWNERS later

### Why this was chosen

Repo already shaped as monorepo with Flutter apps; Nest replaces Spring in-place conceptually without scattering products.

### Future migration strategy

Extract services into `services/*`; optional JS tooling upgrade (pnpm workspaces/turbo) when package count grows.

---

## D15 — API style

### Decision

- **REST**, URL versioned: `/api/v1/...`
- **OpenAPI 3** in `packages/api_contracts` is the contract source; Nest implements it (decorators or contract-first workflow).
- Consistent error envelope; idempotency-key header on booking/payment POSTs.
- Pagination cursor/limit standards; no public GraphQL initially.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| GraphQL day one | Extra cache/auth complexity |
| gRPC to mobile | Poor browser/Flutter Web ergonomics early |
| Header versioning only | Less discoverable than URL v1 |

### Pros

- Flutter Dio + codegen friendly
- Cacheable GETs for public reads
- Clear breaking-change policy

### Cons

- Some over/under fetching vs GraphQL
- Version discipline required

### Why this was chosen

Boring, AI-friendly, aligns with old ADR-005 intent without Spring.

### Future migration strategy

`/api/v2` for breaks; deprecate v1 with sunset headers. Add BFF or GraphQL only for proven chatty UI needs.

---

## D16 — CI/CD & Docker

### Decision

- **Docker Compose** for local Postgres (and Redis when triggered).
- **Dockerfile** for Nest API; Flutter CI via official stable channel.
- **GitHub Actions** path-filtered workflows: `ci-api` (Nest), `ci-flutter`, `ci-website`.
- Environments: `dev` / `staging` / `prod` with separate Supabase projects or clear project isolation.
- No Kubernetes day one; single VM/container PaaS acceptable until scale.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| K8s day one | Rejected |
| GitLab CI | Fine; GitHub already present |
| Railway/Fly/Render | Allowed as host; decisions stay vendor-neutral |

### Pros

- Fast feedback; low ops
- Matches cost-efficiency axis

### Cons

- Will outgrow single-node deploy — plan horizontal API replicas behind load balancer when needed

### Why this was chosen

Ship product, not a platform company. CI exists; retarget Java workflow → Node after approval.

### Future migration strategy

Add deploy workflow, migrations gate, preview envs; containers → orchestrated service when multi-service extraction happens.

---

## D17 — Observability

### Decision

From first Nest production deploy:

| Pillar | Choice |
|--------|--------|
| Logs | Structured JSON (requestId, userId, organizationId) |
| Traces | OpenTelemetry → managed backend (e.g. Honeycomb/Grafana Cloud/Jaeger) |
| Metrics | RED metrics for API; booking/payment business counters |
| Errors | Sentry (or equivalent) for Nest + Flutter |
| Uptime | External health checks on `/health` |

No PII/secrets in logs; never log full payment payloads.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Logs only | Insufficient for booking races |
| Full APM suite day one | Buy when pain appears; OTEL keeps options open |

### Pros

- Debuggable payment/booking issues
- AI-assisted incident response needs structured signals

### Cons

- Vendor cost at scale — sample traces

### Why this was chosen

Operational truth for marketplace trust; cheap compared to silent double-charges.

### Future migration strategy

Swap OTEL exporters freely; add product analytics separately from operational telemetry.

---

## D18 — AI-assisted development conventions

### Decision

Optimize the codebase for humans **and** coding agents:

1. **Small modules** with one bounded context per Nest folder; no cross-module Prisma relation sprawl.
2. **Explicit ports** for Supabase Auth, Storage, Razorpay, FCM, Maps.
3. **OpenAPI + Prisma schema** as machine-readable truths.
4. **Freezed/Dio models** generated from contracts where practical.
5. **Thin controllers**, fat application services, pure domain helpers.
6. **Architecture tests** (e.g. dependency-cruiser / ESLint boundaries) analogous to prior ArchUnit intent.
7. **Docs:** this file + PRD; avoid contradictory stack docs (mark superseded).
8. Prefer boring patterns over clever metaprogramming.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Maximal clean architecture ceremony | Rejected — slows AI and humans |
| “Generate everything, no boundaries” | Rejected — tenancy/payment bugs |

### Pros

- Faster feature throughput with agents
- Safer refactors

### Cons

- Slight ceremony (ports, boundaries)

### Why this was chosen

AI velocity without sacrificing booking/payment correctness.

### Future migration strategy

Tighten codegen pipelines; add AI runbooks per module as the team learns failure modes.

---

## D19 — Cost efficiency

### Decision

- Start on **Supabase tier** that covers Auth + DB + Storage for early traffic; separate prod project.
- **One Postgres** (Supabase-managed or Compose→managed) as SoR; avoid extra clusters.
- Defer Redis, OpenSearch, Kafka, Kubernetes.
- Cap Maps autocomplete; cache geocodes.
- WhatsApp/SMS only with template budgets.
- Prefer Astro static hosting for marketing.
- Monitor egress (Storage/Maps) monthly.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Multi-cloud everything day one | Rejected |
| Self-host Auth+S3+Postgres on one VPS | Possible later for cost; higher security ops burden now |

### Pros

- Runway preserved for product learning
- Managed Auth/Storage reduce eng hours (often more expensive than SaaS bills)

### Cons

- Supabase bill can spike with egress — set alerts
- Migration off Supabase later has a cost (accepted)

### Why this was chosen

Premature infra is the usual startup failure mode; this platform’s risk is **correctness**, not missing Kafka.

### Future migration strategy

Reserved capacity / higher tiers; move Storage to S3+CDN; Redis when triggered; dedicated search when triggered.

---

## D20 — Security baseline

### Decision

| Area | Rule |
|------|------|
| Secrets | Env/secret manager only; never commit; rotate on leak |
| AuthN | Supabase JWT validation on Nest; HTTPS everywhere |
| AuthZ | RBAC + membership; org id from server, not client |
| Tenancy tests | Automated cross-tenant denial tests required for org APIs |
| Webhooks | Signature verify (Razorpay); idempotent processing; raw store |
| Storage | Signed URLs; private buckets for KYC; content-type allowlists |
| Admin | Platform roles only; audit log for cross-org access |
| Dependencies | Lockfiles + CI audit |
| DPDP | Consent, retention, export/delete planned with product (not optional forever) |

### Alternatives considered

| Option | Verdict |
|--------|---------|
| RLS-only security | Rejected as sole control |
| Long-lived API keys in apps | Forbidden |

### Pros

- Matches existential risks in vision review (tenant leak, payment spoof)

### Cons

- Ongoing discipline; security is not a phase-0 checkbox alone

### Why this was chosen

Marketplace trust dies on data leaks and payment bugs.

### Future migration strategy

Penetration test before scale marketing; WAF/rate-limit at edge; optional RLS; bug bounty later.

---

## D21 — Relationship to PRD & old Spring docs

### Decision — supersession policy

| Document set | Status after this file is Accepted |
|--------------|-------------------------------------|
| `docs/product/**` | **Still valid** for product scope, UX (≤3 taps), India rails, stories. Tech alignment notes that say “Spring / ADR-004 custom JWT / Redis day one” should be read as **product intent + old stack**; implement against **this file**. |
| `docs/ARCHITECT_DECISIONS.md` (this) | **Authoritative** for stack & architecture decisions. |
| `docs/adr/001`–`010` | **Partially superseded.** Domain intents that remain: modular monolith, Flutter+SEO site, Postgres SoR, FTS→OpenSearch, outbox, Razorpay isolation, REST versioning, observability, monorepo. **Superseded stack specifics:** Spring Boot, custom JWT issuer, Redis-as-default, S3-as-default media, Gradle-centric tooling. |
| `docs/architecture/00-vision-review.md` | Product framing **still useful**; Spring/Redis day-one recommendations **overridden** here. |
| `docs/architecture/01-system-architecture.md`, `02-folder-structure.md` | Spring folder layout **superseded** by D14; rewrite only after approval if needed. |
| `docs/architecture/03-multi-tenancy.md` | **Concepts retained** (org row-level); implementation becomes Nest/Prisma. |
| `docs/architecture/phase-1-implementation-report.md` | Historical record of Spring Phase-1 bootstrap; **not** a mandate to continue Spring. |
| `docs/standards/**`, `docs/strategies/**` | Keep principles; update stack names in a later docs pass **after** approval (out of scope for this task). |

**Rule:** If any old ADR conflicts with this document on runtime, auth issuer, cache day-one, storage vendor, or monorepo backend path, **this document wins** once Accepted.

**PRD alignment:** Hybrid marketplace + owner OS + admin; Razorpay; FCM; maps; org tenancy; booking correctness; SEO website — all preserved. Implementation language/runtime is Nest/TS/Flutter as above.

### Alternatives considered

| Option | Verdict |
|--------|---------|
| Rewrite all old ADRs now | Deferred — single SoT file first reduces contradiction |
| Delete old ADRs immediately | Deferred until approval + docs cleanup pass |

### Pros

- One clear gate for founders
- Preserves product investment in PRD

### Cons

- Temporary doc drift until cleanup pass

### Why this was chosen

User asked for this file as permanent SoT without rewriting the entire docs tree.

### Future migration strategy

After approval: mark each old ADR status to `Superseded by ARCHITECT_DECISIONS.md` (section Dx); update PRD “architectural alignment” table; remove or archive Spring code in a dedicated follow-up PR.

---

## 26. Target evolution roadmap

```text
Final ADD acceptance (ARCHITECTURE.md)
    → Nest modular monolith + Prisma + Supabase Auth/Storage
    → Flutter apps/app + Next.js website
    → Outbox + BullMQ (Redis), Postgres FTS, Razorpay, FCM, Maps
    → AI module (assistive, flagged)
    → OpenSearch / extracted payment|notification when justified
    → Gateway only after multi-service reality
```

Scale to millions is achieved by: correct data model, indexes, horizontal API/worker replicas, DB replicas, then selective extraction — **not** by starting with six services.

---

## 27. Approval checklist

**Direction approved.** Final acceptance = `docs/ARCHITECTURE.md` sign-off.

- [x] NestJS modular monolith; discard Spring as backend direction
- [x] Supabase Auth + app-level tenancy; Supabase Storage
- [x] Next.js for `apps/website`
- [x] Single Flutter `apps/app` (role-aware)
- [x] BullMQ + Redis for jobs; outbox write-side guarantee
- [x] Postgres FTS first; category capability model retained
- [ ] **Final:** Accept `docs/ARCHITECTURE.md` open questions / sign-off
- [ ] Acknowledge **no implementation** until ADD status → **Accepted**
- [ ] Schedule follow-up: archive Spring `platform-api`, consolidate Flutter apps, retarget CI

**Sign-off (to be filled on ARCHITECTURE.md):**

| Role | Name | Date | Decision |
|------|------|------|----------|
| Founder | | | See ARCHITECTURE.md |
| CTO (AI permanent) | Cursor Grok — BookMySpace | 2026-08-02 | Direction proposed → aligned with ADD |

---

*End of ARCHITECT_DECISIONS.md — aligned with ARCHITECTURE.md; wait for final ADD acceptance before implementation.*
