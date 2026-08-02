# 00 — PRD Overview

**Document ID:** PRD-00  
**Status:** Active  
**Tagline:** One Platform. Every Bookable Space.

---

## Table of contents

1. [Executive summary](#1-executive-summary)
2. [Problem statement](#2-problem-statement)
3. [Market opportunity](#3-market-opportunity)
4. [Vision & mission](#4-vision--mission)
5. [Product framing](#5-product-framing)
6. [Unique selling proposition](#6-unique-selling-proposition)
7. [Competitive landscape](#7-competitive-landscape)
8. [Product goals](#8-product-goals)
9. [Success criteria](#9-success-criteria)
10. [Venue & inventory coverage](#10-venue--inventory-coverage)
11. [Target users](#11-target-users)
12. [Assumptions](#12-assumptions)
13. [Traceability map](#13-traceability-map)
14. [Out of scope (explicit)](#14-out-of-scope-explicit)

---

## 1. Executive summary

BookMySpace is an **India-first Venue Commerce Platform** that unifies discovery, booking, payments, and operations for heterogeneous bookable spaces — marriage halls, meeting rooms, sports grounds, training institutes, coworking desks, banquet halls, community spaces, and more.

It is **three products on one platform**:

1. **Marketplace** — customers discover, compare, book, pay, and review spaces.
2. **Owner Operating System** — venue businesses manage inventory, calendars, pricing, staff, payouts, and customer relationships.
3. **Platform Admin** — BookMySpace operators handle KYC, moderation, support, configuration, and growth tooling.

**North-star UX rule:** Any primary task completes in ≤ 3 taps/clicks where domain rules allow.

---

## 2. Problem statement

| Stakeholder | Today’s pain |
|-------------|--------------|
| Customers | Fragmented discovery (WhatsApp, brokers, Google); opaque pricing; no reliable availability; weak trust |
| Hall / banquet owners | Phone-driven bookings; double-bookings; no calendar OS; poor payment collection; GST paperwork chaos |
| Training institutes | Batch/slot management spreadsheets; no self-serve booking; weak occupancy insight |
| Sports ground owners | Hourly pitch conflicts; cash-only; no online discovery beyond local word-of-mouth |
| Vendors (decorators, caterers) | Hard to attach to venue bookings; no standardized marketplace for add-ons |
| Platform operators | No single system of record for supply quality, disputes, or unit economics |

**Result:** High friction, low conversion, leakage to offline brokers, and zero shared liquidity across space categories.

---

## 3. Market opportunity

- India’s event, sports, coworking, and institutional space markets are large, fragmented, and digitally under-served.
- Mobile-first consumers expect BookMyShow-like booking speed with Airbnb-like trust.
- Owners need Shopify-like tooling without enterprise CRM complexity.
- India-specific rails (UPI, Razorpay, WhatsApp, GST, DPDP) are table stakes — not add-ons.

BookMySpace wins by owning the **booking kernel + category capability model**, then expanding category plugins without forking the stack.

---

## 4. Vision & mission

### Vision

Become the default operating system for every bookable space in India — and later, select international markets — where finding, booking, and running a venue is as easy as ordering food online.

### Mission

Enable customers to book the right space with confidence, and enable owners to fill inventory profitably — through one secure, multi-tenant, mobile-first platform.

### Positioning statement

> For people who need a space and businesses who own one, BookMySpace is the hybrid marketplace and owner OS that makes every bookable space discoverable, bookable, and operable — **One Platform. Every Bookable Space.**

---

## 5. Product framing

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

Inspired by (not cloned from): Airbnb (trust), BookMyShow (speed), Shopify (owner tooling), Zoho (modular ops), with Urban Company–grade reliability mindset — without hyperlocal staffed-service ops.

---

## 6. Unique selling proposition

| USP pillar | What it means |
|------------|---------------|
| **Category-agnostic booking kernel** | Halls, pitches, desks, rooms share one hold→book→pay spine with capability plugins |
| **Hybrid marketplace + owner OS** | Liquidity for customers + daily ops for owners in one account model |
| **India-native commerce** | INR, UPI/Razorpay, GST invoices, WhatsApp templates, DPDP-ready consent |
| **Trust by design** | KYC, verification badges, reviews tied to completed bookings, dispute trails |
| **SEO + app dual surface** | Crawlable SSR public pages + Flutter transactional apps |
| **≤3-tap primary paths** | Discovery → hold → pay optimized for mobile |

---

## 7. Competitive landscape

| Competitor / analog | Strength | Gap BookMySpace exploits |
|---------------------|----------|---------------------------|
| Offline brokers / WhatsApp | High trust locally | No scale, no calendar integrity, no GST OS |
| Venue-specific apps | Vertical depth | Single category; no shared demand |
| Generic listing portals | SEO inventory | Weak booking correctness & owner ops |
| Airbnb | Trust + discovery | Home-stay model; not India venue ops |
| BookMyShow | Booking UX | Entertainment-only inventory |
| OYO / asset-heavy models | Standardization | CapEx-heavy; not owner SaaS |
| Pure CRM / Zoho | Ops modules | No marketplace liquidity |

**Competitive advantage:** Shared inventory + booking correctness + owner SaaS + India payment/compliance rails, expanded via category plugins rather than parallel products.

---

## 8. Product goals

### 8.1 Short-term (MVP → V1)

| ID | Goal | Type |
|----|------|------|
| BG-01 | Complete end-to-end book path for banquet/meeting/community venues in 1–2 launch cities | Business |
| BG-02 | Zero silent double-bookings on confirmed inventory | Technical / Trust |
| BG-03 | Owner can create org, list venue, set availability, accept money, see bookings | Business |
| BG-04 | Customer can search, view, hold, pay (UPI), receive confirmation | UX |
| BG-05 | GST-ready invoice primitives and Razorpay webhook truth | Technical / Compliance |

### 8.2 Medium-term (V2–V3)

| ID | Goal | Type |
|----|------|------|
| BG-06 | Expand sports + training + coworking capability plugins | Business |
| BG-07 | Reviews, verification, WhatsApp, settlements, SEO city pages driving organic demand | Growth |
| BG-08 | Subscription tiers monetize owner OS; marketplace commission on bookings | Revenue |
| BG-09 | Vendor marketplace attaches services to venue bookings | Business |

### 8.3 Long-term (Enterprise → International)

| ID | Goal | Type |
|----|------|------|
| BG-10 | Enterprise orgs: multi-venue, white-label, API access, franchise partners | Business |
| BG-11 | Multi-language (EN+HI first), then vernacular expansion | UX |
| BG-12 | Selective international markets with localized payments/tax (post India PMF) | Business |

### 8.4 Technical goals (product constraints)

| ID | Goal |
|----|------|
| BG-T1 | Align delivery with eng Phases 1–20; do not invent parallel microservice roadmap |
| BG-T2 | Preserve modular monolith + outbox + FTS-first decisions until ADR change |
| BG-T3 | Idempotent booking/payment; tenant isolation as product feature |
| BG-T4 | Observability and SLOs as release gates |

### 8.5 UX goals

| ID | Goal |
|----|------|
| BG-U1 | ≤3 taps for primary book path where rules allow |
| BG-U2 | Material 3 design system; accessible (WCAG 2.2 AA target) |
| BG-U3 | Empty/loading/error states designed for every major screen |
| BG-U4 | Dark mode supported via shared tokens |

---

## 9. Success criteria

### Product launch (MVP) — must all be true

1. A new customer can discover a published venue, hold a slot, pay via Razorpay/UPI, and receive confirmation (push + email).
2. An owner can block inventory and prevent conflicting customer holds.
3. Concurrent hold tests show only one winner for the same slot.
4. Cross-tenant access denied in automated tests.
5. Admin can look up booking/org and force-unpublish a listing.
6. Crash-free sessions and API p95 within NFR budgets on staging.

### Business success (first 6–12 months post-MVP)

| Metric | Target (indicative; finalize with founders) |
|--------|-----------------------------------------------|
| Monthly booked GMV (launch cities) | Founder decision — see open questions |
| Booking conversion (detail → confirmed) | ≥ 8% MVP baseline, improve quarterly |
| Owner activation (publish + 1 availability week) | ≥ 40% of signed orgs in 14 days |
| Double-booking incidents | 0 confirmed silent doubles |
| NPS (customer / owner) | Track from V1; target > 30 by V2 |

---

## 10. Venue & inventory coverage

### Category clusters (capability plugins)

| Cluster | Examples | Inventory unit | Availability model | Pricing model (v1+) |
|---------|----------|----------------|--------------------|---------------------|
| Events / banquet | Marriage hall, banquet, community hall | Hall / wing / lawn | Day or multi-slot event | Day-rate, package, partial pay |
| Meetings | Meeting room, conference hall | Room | Hourly / half-day / day | Hourly or package |
| Sports | Cricket ground, football turf, badminton | Pitch / court | Hourly slots | Hourly |
| Training | Coaching academy, training institute rooms | Room / batch slot | Recurring slots | Per session / package |
| Work | Coworking desk, private cabin | Desk / cabin / zone | Day pass / membership window | Pass / seat-hour |
| Hospitality-lite | Party lawn, rooftop (non-hotel core) | Space | Event windows | Package |

**Inventory Unit** is first-class: hall, room, pitch, desk, zone, or entire property.

**Booking modes** (feature-flagged): instant book, request-to-book, partial payment, full prepaid, pay-at-venue (later).

---

## 11. Target users

| Persona | Primary product surface |
|---------|-------------------------|
| Customer / end booker | Customer Flutter + SSR website |
| Hall Owner | Owner Flutter |
| Training Institute Owner | Owner Flutter (training capability) |
| Sports Ground Owner | Owner Flutter (sports capability) |
| Vendor (decorator, caterer, AV) | Vendor flows (V2+) |
| Event Organizer | Customer + organizer tools (V2+) |
| Administrator / Super Admin | Admin web |
| Support Executive | Admin web |
| Sales Executive | Admin / CRM tools |
| Franchise Partner | Partner portal (Enterprise) |

Detailed personas: [01-personas.md](01-personas.md).

---

## 12. Assumptions

1. **Phase 1 foundation status:** Monorepo bootstrap, modular-monolith API shell, Flutter app shells, Postgres+Redis Compose, and CI skeleton exist (see [phase-1-implementation-report.md](../architecture/phase-1-implementation-report.md)). This PRD does **not** restate implementation; product backlog maps to eng Phases 2–20+.
2. Guest checkout is **deferred**; auth-first for MVP.
3. Launch categories: banquet / meeting / community first; sports & coworking via capability expansion (eng Phase 18).
4. Razorpay is the sole payment provider for India MVP.
5. English UI first; Hindi and vernacular after core booking works.
6. AI features are assistive (ranking, copy, insights) — **not** the core booking path.
7. Pricing figures in subscription doc are **placeholders** pending founder pricing decision.
8. White-label, public API, and international tax engines are post-PMF.

---

## 13. Traceability map

| Layer | Prefix | Example | Home |
|-------|--------|---------|------|
| Business goal | BG- | BG-01 | This doc |
| Functional requirement | FR- | FR-BOOK-01 | [03-functional-requirements.md](03-functional-requirements.md) |
| Non-functional | NFR- | NFR-PERF-01 | [04-non-functional-requirements.md](04-non-functional-requirements.md) |
| Business rule | BR- | BR-BOOK-01 | [05-business-rules.md](05-business-rules.md) |
| User story | US- | US-091 | [stories/](stories/) |
| Acceptance criteria | AC- | AC-091-01 | Colocated with stories |
| Epic | EP- | EP-04 | [12-product-backlog.md](12-product-backlog.md) |

---

## 14. Out of scope (explicit)

Aligned with architecture non-goals / deferred roadmap:

- Hyperlocal on-demand staffed services (Urban Company ops model)
- Multi-country tax engines in MVP/V1
- Full CQRS everywhere
- Per-category microservices
- Kafka / OpenSearch as day-one dependencies
- AI chatbot as mandatory booking path
- Storing card PANs
- Guest checkout (MVP)
- Custom Kubernetes operators

---

## Document control

| Version | Date | Notes |
|---------|------|-------|
| 1.0 | 2026-08-02 | Initial complete PRD set |
