# BookMySpace Product Requirements Document (PRD)

**Tagline:** One Platform. Every Bookable Space.  
**Status:** Approved for product planning (aligns with architecture foundation)  
**Product type:** Hybrid Marketplace + Owner Operating System + Platform Admin  
**Primary market:** India (INR, Razorpay/UPI, GST, WhatsApp, DPDP)  
**Last updated:** 2026-08-02

This folder is the **single source of truth** for product scope, requirements, stories, and backlog. Engineering architecture remains authoritative under [`docs/architecture/`](../architecture/) and [`docs/adr/`](../adr/). Where product language describes capabilities, implementation must stay consistent with accepted ADRs (modular monolith, Flutter + SSR website, Postgres + Redis, Razorpay, JWT/RBAC, org tenancy, outbox before Kafka, FTS before OpenSearch).

---

## How to use this PRD

| Role | Start here | Then |
|------|------------|------|
| Founders / PM | [00-prd-overview.md](00-prd-overview.md) | Goals, USP, open questions in [11-risks-roadmap-metrics.md](11-risks-roadmap-metrics.md) |
| Design / UX | [01-personas.md](01-personas.md), [02-journey-maps.md](02-journey-maps.md) | [10-wireframes-ux.md](10-wireframes-ux.md) |
| Engineering | [03-functional-requirements.md](03-functional-requirements.md) | Stories under [`stories/`](stories/), [06-roles-permissions.md](06-roles-permissions.md) |
| QA | [08/09 via stories](stories/) | Acceptance criteria per `US-xxx`; map to `FR-xxx` / `BR-xxx` |
| DevOps / SRE | [04-non-functional-requirements.md](04-non-functional-requirements.md) | SLOs in [11-risks-roadmap-metrics.md](11-risks-roadmap-metrics.md) |
| Sales / CS | [07-subscription-revenue.md](07-subscription-revenue.md) | Personas + support stories |
| Sprint planning | [12-product-backlog.md](12-product-backlog.md) | Pull `US-xxx` into sprints by priority |

### Traceability model

```
BG (Business Goal) → FR (Functional Req) → US (User Story) → AC (Acceptance Criteria)
                 ↘ BR (Business Rule) / NFR (Non-Functional) / RBAC
```

IDs are stable. Do not renumber; deprecate with strikethrough + replacement ID if needed.

---

## Document index

| # | Document | Contents |
|---|----------|----------|
| 00 | [00-prd-overview.md](00-prd-overview.md) | Executive summary, market, vision, USP, goals, competitive, assumptions |
| 01 | [01-personas.md](01-personas.md) | Customer, Hall Owner, Training Institute Owner, Sports Ground Owner, Vendor, Admin, Support, Sales |
| 02 | [02-journey-maps.md](02-journey-maps.md) | Happy + failure journeys per persona |
| 03 | [03-functional-requirements.md](03-functional-requirements.md) | All modules with `FR-xxx` IDs |
| 04 | [04-non-functional-requirements.md](04-non-functional-requirements.md) | `NFR-xxx` + measurable benchmarks |
| 05 | [05-business-rules.md](05-business-rules.md) | `BR-xxx` decision tables |
| 06 | [06-roles-permissions.md](06-roles-permissions.md) | Full RBAC matrix (platform + org + marketplace roles) |
| 07 | [07-subscription-revenue.md](07-subscription-revenue.md) | Plans, upgrade/downgrade, revenue streams |
| 08–09 | [stories/](stories/) | ≥200 user stories + acceptance criteria by module |
| 10 | [10-wireframes-ux.md](10-wireframes-ux.md) | Screen descriptions + UX guidelines |
| 11 | [11-risks-roadmap-metrics.md](11-risks-roadmap-metrics.md) | Risks, release roadmap, KPIs, open questions |
| 12 | [12-product-backlog.md](12-product-backlog.md) | Prioritized Epics → Features → Stories |

---

## Story modules (US + AC)

| File | Module | Story ID range |
|------|--------|----------------|
| [stories/01-auth-identity.md](stories/01-auth-identity.md) | Auth & Identity | US-001–US-015 |
| [stories/02-org-tenancy.md](stories/02-org-tenancy.md) | Organization & Tenancy | US-016–US-027 |
| [stories/03-venue-catalog.md](stories/03-venue-catalog.md) | Venue Catalog | US-028–US-045 |
| [stories/04-media.md](stories/04-media.md) | Media | US-046–US-053 |
| [stories/05-search-discovery.md](stories/05-search-discovery.md) | Search & Discovery | US-054–US-068 |
| [stories/06-maps-geo.md](stories/06-maps-geo.md) | Maps & Geo | US-069–US-076 |
| [stories/07-calendar-availability.md](stories/07-calendar-availability.md) | Calendar & Availability | US-077–US-090 |
| [stories/08-booking.md](stories/08-booking.md) | Booking | US-091–US-110 |
| [stories/09-payments.md](stories/09-payments.md) | Payments | US-111–US-125 |
| [stories/10-notifications.md](stories/10-notifications.md) | Notifications | US-126–US-137 |
| [stories/11-reviews-ratings.md](stories/11-reviews-ratings.md) | Reviews & Ratings | US-138–US-147 |
| [stories/12-wishlist.md](stories/12-wishlist.md) | Wishlist | US-148–US-153 |
| [stories/13-coupons-promotions.md](stories/13-coupons-promotions.md) | Coupons & Promotions | US-154–US-163 |
| [stories/14-invoices-refunds.md](stories/14-invoices-refunds.md) | Invoices & Refunds | US-164–US-175 |
| [stories/15-settlements.md](stories/15-settlements.md) | Settlements & Payouts | US-176–US-183 |
| [stories/16-crm.md](stories/16-crm.md) | CRM | US-184–US-193 |
| [stories/17-reports-analytics.md](stories/17-reports-analytics.md) | Reports & Analytics | US-194–US-205 |
| [stories/18-subscriptions.md](stories/18-subscriptions.md) | Subscriptions | US-206–US-217 |
| [stories/19-support.md](stories/19-support.md) | Support | US-218–US-227 |
| [stories/20-cms-marketing.md](stories/20-cms-marketing.md) | CMS & Marketing | US-228–US-237 |
| [stories/21-admin-moderation.md](stories/21-admin-moderation.md) | Admin & Moderation | US-238–US-251 |
| [stories/22-vendor-marketplace.md](stories/22-vendor-marketplace.md) | Vendor Marketplace | US-252–US-263 |
| [stories/23-ai-features.md](stories/23-ai-features.md) | AI Features | US-264–US-271 |
| [stories/24-website-seo.md](stories/24-website-seo.md) | Website & SEO | US-272–US-279 |
| [stories/25-trust-safety.md](stories/25-trust-safety.md) | Trust, Safety & KYC | US-280–US-287 |
| [stories/26-owner-ops-misc.md](stories/26-owner-ops-misc.md) | Owner Ops & Category UX | US-288–US-295 |
| [stories/27-event-organizer-franchise.md](stories/27-event-organizer-franchise.md) | Event Organizer & Franchise | US-296–US-305 |
| [stories/28-sales-growth.md](stories/28-sales-growth.md) | Sales & Growth Ops | US-306–US-315 |

**Total user stories:** 315 (each with acceptance criteria).

---

## Architectural alignment (non-negotiable)

| Concern | Product may say | Tech must remain |
|---------|-----------------|------------------|
| Services | “payment service”, “search” | Bounded contexts in modular monolith; extract only per ADR-001 |
| Messaging | “events”, “async notify” | Transactional outbox first; Kafka later (ADR-006) |
| Search | “relevance”, “geo search” | Postgres FTS + geo first; OpenSearch later (ADR-007) |
| Clients | Apps + public web | Flutter apps + SSR `apps/website` (ADR-002) |
| Data | Durable business data | PostgreSQL SoR; Redis for holds/cache/rate-limit only (ADR-003) |
| Auth | Login, roles, MFA later | JWT + refresh rotation + RBAC (ADR-004) |
| Payments | UPI, cards, refunds | Razorpay; isolated payment context; idempotency (ADR-010) |
| Tenancy | Owner businesses | Organization row-level tenancy ([03-multi-tenancy.md](../architecture/03-multi-tenancy.md)) |

---

## Related docs

- [Architecture vision review](../architecture/00-vision-review.md)
- [System architecture](../architecture/01-system-architecture.md)
- [Multi-tenancy](../architecture/03-multi-tenancy.md)
- [Phase roadmap (eng Phases 1–20)](../roadmap/phase-roadmap.md)
- [ADR index](../adr/README.md)
- [Docs home](../README.md)
