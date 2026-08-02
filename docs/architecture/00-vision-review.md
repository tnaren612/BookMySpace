# Vision Review, Risks & Architecture Recommendations

**Audience:** Founders, eng leads, product  
**Status:** Accepted for Foundation  
**Date:** 2026-08-02

---

## 1. Vision Assessment

The vision is strong and commercially clear: a **Venue Commerce Platform** for India that spans discovery, booking, operations, and payments across heterogeneous space types.

What works well:

- Broad but coherent category coverage (events, coworking, sports, hospitality).
- Explicit production bar (scale, security, multi-tenant, mobile-first).
- Sensible stack for an India-first SaaS (Flutter, Spring Boot, PostgreSQL, Razorpay, WhatsApp).
- Clean Architecture / DDD intent without mandating heavy CQRS.

What needs sharpening before build:

| Gap | Why it matters | Recommendation |
|-----|----------------|----------------|
| Product mode unclear | Marketplace vs owner SaaS vs hybrid changes tenancy, trust, and pricing | Explicit **Hybrid Marketplace + Owner OS** (see §2) |
| Category sprawl | 20+ venue types explode taxonomy, search, and booking rules | **Category plugins** + shared booking kernel |
| SEO on Flutter Web | Flutter Web is weak for organic discovery | Separate **SSR marketing/SEO site** |
| Six services on day 1 | Premature microservices kill velocity | **Modular monolith first** |
| India compliance | DPDP Act, GST invoices, UPI, KYC | Compliance as a first-class domain |
| Trust & safety | Fake listings destroy marketplace liquidity | Verification, reviews, dispute flows early |

---

## 2. Recommended Product Framing

Treat BookMySpace as **three products sharing one platform**:

```
┌─────────────────────────────────────────────────────────┐
│                   BookMySpace Platform                   │
├─────────────────┬───────────────────┬───────────────────┤
│  Marketplace     │  Owner Operating  │  Platform Admin   │
│  (Customers)     │  System (Owners)  │  (Internal)       │
│  Discover/Book   │  List/Calendar/   │  KYC/Moderation/  │
│  Pay/Review      │  Pricing/Payouts  │  Config/Support   │
└─────────────────┴───────────────────┴───────────────────┘
```

### Positioning (inspired by, not cloned from)

| Analogy | What we take | What we discard |
|---------|--------------|-----------------|
| Airbnb | Trust, listings, search, reviews | Home-stay-only inventory model |
| BookMyShow | Fast booking UX, seat/slot feel | Entertainment-only catalog |
| Shopify | Owner tooling & extensibility | Pure self-serve storefronts |
| Zoho | Modular ops SaaS | Enterprise CRM complexity |
| Urban Company | Service reliability & ops | Hyperlocal service marketplace ops |
| OYO | Inventory standardization | Asset-heavy hospitality ops |

**North-star UX rule:** Any primary task completes in ≤ 3 taps/clicks where domain rules allow.

---

## 3. Suggested Improvements to the Original Brief

### 3.1 Architecture

1. **Modular monolith first** — one Spring Boot deployable with packages per bounded context; extract to `services/*` when justified.
2. **Add API contract package** — OpenAPI specs as source of truth (`packages/api_contracts` or `docs/openapi`).
3. **Add gateway later** — Spring Cloud Gateway / nginx only after service split.
4. **Transactional outbox** for domain events before introducing Kafka.
5. **Search evolution path** — PostgreSQL FTS + PostGIS for MVP; OpenSearch when relevance/scale requires it.
6. **Media pipeline** — signed uploads to S3 + CDN; never stream large binaries through app servers.
7. **Idempotency keys** on booking create and payment confirm (non-negotiable).

### 3.2 Product / Domain

1. Introduce a **Venue Category Capability Model** (inventory unit, pricing model, availability model, amenities schema) so Marriage Hall ≠ Meeting Room ≠ Cricket Ground without forking the whole stack.
2. Define **Inventory Unit** explicitly: hall, room, pitch, desk, zone, entire property.
3. Standardize **Booking Modes**: instant book, request-to-book, partial payment, full prepaid, pay-at-venue (feature-flagged).
4. Plan **GST-compliant invoicing** and settlement reports from Phase of payments.
5. Plan **multi-language** (EN + HI first) after core booking works — not before.

### 3.3 Clients

1. Keep `customer_flutter` and `owner_flutter` as Flutter (Material 3).
2. Implement `admin_web` as Flutter Web **or** a thin React admin — prefer Flutter Web first for shared design system, revisit if admin complexity explodes.
3. Implement `website/` as **Next.js or Astro SSR** for SEO landing, city pages, venue public pages (crawlable). App deep-links into Flutter.
4. Add design tokens in `packages/shared_ui` shared across Flutter apps.

### 3.4 Ops & Scale

1. One Postgres cluster with logical separation by schema/package tables; Redis for sessions, rate limits, hot availability caches.
2. Background jobs via Spring `@Async` / Quartz initially; dedicated workers later.
3. Feature flags (Unleash / custom) for category rollouts and booking modes.
4. Observability from day one: structured JSON logs, OpenTelemetry traces, Prometheus metrics.

---

## 4. Risks (Prioritized)

| Priority | Risk | Impact | Mitigation |
|----------|------|--------|------------|
| P0 | Double booking / race on slots | Trust collapse | DB constraints + optimistic locking + Redis hold + idempotency |
| P0 | Premature microservices | Slow delivery, ops hell | Modular monolith ADR |
| P0 | Payment/refund inconsistency | Financial loss, chargebacks | Isolated payment module, outbox, reconciliation jobs |
| P0 | Weak auth / token theft | Account takeover | Short-lived access JWT, rotating refresh, device binding optional |
| P1 | Taxonomy explosion across venue types | Unmaintainable product | Capability plugins, not per-category apps |
| P1 | Flutter Web SEO | Poor organic growth | SSR website for public pages |
| P1 | Multi-tenant data leak | Existential security incident | Tenant guards, automated tests, row-level policies |
| P1 | WhatsApp / SMS cost blowups | Unit economics break | Template governance, digests, preference center |
| P2 | Search quality across heterogeneous inventory | Low conversion | Ranking features + filters + geo; OpenSearch later |
| P2 | Fake listings / fraud | Marketplace death spiral | Owner KYC, listing verification, photo moderation |
| P2 | DPDP Act non-compliance | Legal risk | Consent, retention, data export/delete APIs |
| P2 | Team over-abstraction (CQRS everywhere) | Lost velocity | CQRS only for proven hot paths (search/read models) |
| P3 | Over-building admin before liquidity | Wasted effort | Thin admin until supply/demand loops exist |

---

## 5. Architecture Changes (Recommended vs Original)

| Original | Recommended Change | Why |
|----------|-------------------|-----|
| 6 deployable services immediately | 1 modular monolith → extract | Velocity + consistency; boundaries still exist as packages |
| Flutter for all public web | Flutter apps + SSR `website/` | SEO & shareable venue URLs |
| Redis as generic cache | Explicit roles: session, rate-limit, slot-hold, cache | Prevents Redis becoming a junk drawer |
| CQRS optional | **Forbidden by default**; allowlisted | Avoid accidental complexity |
| Feature-first Flutter only | Feature-first + shared core (auth, networking, design system) | DRY without coupling features |
| No explicit media service | Signed S3 upload + CDN (no service until needed) | Simpler, cheaper, scalable |
| No explicit audit | Audit log table + immutable booking history | Enterprise & dispute readiness |
| Single “user” concept | Platform User + Membership (org roles) | Owners, staff, customers, admins |

### Target evolution

```
Phase 1–6:   Modular Monolith + Postgres + Redis + Flutter apps + SSR site
Phase 7–12:  Extract payment & notification if load/team requires
Phase 13–20: Extract search; consider booking read replicas / CQRS read model
```

---

## 6. Decision Rationale Summary

| Decision | Why |
|----------|-----|
| Hybrid marketplace + owner OS | Matches India venue market (owners need ops; customers need discovery) |
| Modular monolith first | Same DDD boundaries, 10× less ops cost early |
| Category capability model | Scales to 20+ venue types without 20 codebases |
| SSR website | SEO is a growth channel; Flutter Web is an app runtime |
| Idempotent booking/payment | Correctness over cleverness under concurrency |
| Outbox events | Reliable async without distributed transactions |
| Strict tenancy tests | Security is a product feature |
| Phased roadmap (1–20) | Independent, testable increments |

---

## 7. Non-Goals (Foundation Phase)

- No Flutter screens
- No Spring controllers / entities
- No database migrations / tables
- No Razorpay integration code
- No “demo” features

Foundation ends when docs, ADRs, standards, CI skeleton, and empty module shells are ready for Phase 1 implementation.
