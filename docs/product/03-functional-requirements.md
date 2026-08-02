# 03 — Functional Requirements

**Document ID:** PRD-03  
**ID format:** `FR-{MODULE}-{nn}`  
**Related stories:** [stories/](stories/)  
**Architecture alignment:** Bounded contexts in modular monolith — Identity, Venue, Booking, Payment, Notification, Search (+ Admin, Trust later).

---

## Table of contents

1. [Module index](#1-module-index)
2. [Auth & Identity](#2-auth--identity)
3. [Organization & Tenancy](#3-organization--tenancy)
4. [Venue Catalog](#4-venue-catalog)
5. [Media](#5-media)
6. [Search & Discovery](#6-search--discovery)
7. [Maps & Geo](#7-maps--geo)
8. [Calendar & Availability](#8-calendar--availability)
9. [Booking](#9-booking)
10. [Payments](#10-payments)
11. [Notifications](#11-notifications)
12. [Reviews & Ratings](#12-reviews--ratings)
13. [Wishlist](#13-wishlist)
14. [Coupons & Promotions](#14-coupons--promotions)
15. [Invoices & Refunds](#15-invoices--refunds)
16. [Settlements & Payouts](#16-settlements--payouts)
17. [CRM](#17-crm)
18. [Reports & Analytics](#18-reports--analytics)
19. [Subscriptions](#19-subscriptions)
20. [Support](#20-support)
21. [CMS & Marketing](#21-cms--marketing)
22. [Admin & Moderation](#22-admin--moderation)
23. [Vendor Marketplace](#23-vendor-marketplace)
24. [AI Features](#24-ai-features)
25. [Website & SEO](#25-website--seo)
26. [Trust, Safety & KYC](#26-trust-safety--kyc)
27. [Owner Ops & Category Capabilities](#27-owner-ops--category-capabilities)
28. [Event Organizer & Franchise](#28-event-organizer--franchise)
29. [Sales & Growth Ops](#29-sales--growth-ops)

---

## 1. Module index

| Module code | Name | Primary release |
|-------------|------|-----------------|
| AUTH | Auth & Identity | MVP |
| ORG | Organization & Tenancy | MVP |
| VENUE | Venue Catalog | MVP |
| MEDIA | Media | MVP |
| SEARCH | Search & Discovery | MVP |
| MAPS | Maps & Geo | MVP/V1 |
| CAL | Calendar & Availability | MVP |
| BOOK | Booking | MVP |
| PAY | Payments | MVP |
| NOTIF | Notifications | MVP |
| REV | Reviews & Ratings | V1 |
| WISH | Wishlist | V1 |
| COUP | Coupons & Promotions | V1/V2 |
| INV | Invoices & Refunds | V1 |
| SETL | Settlements | V1/V2 |
| CRM | CRM | V2 |
| RPT | Reports & Analytics | V1/V2 |
| SUB | Subscriptions | V1 |
| SUP | Support | V1 |
| CMS | CMS & Marketing | V1/V2 |
| ADM | Admin & Moderation | V1 |
| VND | Vendor Marketplace | V2/V3 |
| AI | AI Features | V2+ |
| WEB | Website & SEO | V1 |
| TRUST | Trust, Safety & KYC | V1 |
| OPS | Owner Ops & Categories | V2 |
| EVT | Event Organizer & Franchise | V3/Enterprise |
| SALES | Sales & Growth Ops | V1/V2 |

---

## 2. Auth & Identity

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-AUTH-01 | Users can register with email/phone + password (India phone formats) | P0 |
| FR-AUTH-02 | Users can login and receive JWT access + rotating refresh tokens | P0 |
| FR-AUTH-03 | Users can logout and revoke refresh family | P0 |
| FR-AUTH-04 | Password reset via secure tokenized flow | P0 |
| FR-AUTH-05 | Rate-limit auth endpoints; lockout/backoff on abuse | P0 |
| FR-AUTH-06 | Profile view/update (name, phone, locale, avatar ref) | P0 |
| FR-AUTH-07 | Session list / revoke other devices (V1) | P1 |
| FR-AUTH-08 | Optional MFA (TOTP/SMS) post-MVP | P2 |
| FR-AUTH-09 | DPDP consent capture at registration / marketing opt-in | P0 |
| FR-AUTH-10 | Account deletion / data export request hooks | P1 |

---

## 3. Organization & Tenancy

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-ORG-01 | Authenticated user can create an Organization (owner business) | P0 |
| FR-ORG-02 | Org membership with roles (`ORG_OWNER`, `ORG_MANAGER`, `ORG_STAFF`, later accountant) | P0 |
| FR-ORG-03 | Invite members by email/phone; accept/decline | P0 |
| FR-ORG-04 | Remove/suspend members; transfer ownership (controlled) | P1 |
| FR-ORG-05 | All owner APIs enforce org scope from token membership | P0 |
| FR-ORG-06 | Org profile: legal name, GSTIN (optional at create), address, payout profile ref | P0 |
| FR-ORG-07 | Soft-delete org with constraints if active bookings | P1 |

---

## 4. Venue Catalog

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-VENUE-01 | Create/edit venue drafts under an org | P0 |
| FR-VENUE-02 | Venue states: DRAFT, PENDING_REVIEW, PUBLISHED, UNPUBLISHED, ARCHIVED | P0 |
| FR-VENUE-03 | Category taxonomy v1: banquet, meeting, community (+ flags for sports/training/coworking) | P0 |
| FR-VENUE-04 | Inventory units under venue (hall/room/pitch/desk/zone/property) | P0 |
| FR-VENUE-05 | Amenities schema; category capability fields | P0 |
| FR-VENUE-06 | Capacity, area, address, geo coordinates, policies text | P0 |
| FR-VENUE-07 | Publish validation: minimum photos, address, capacity, ≥1 inventory unit, pricing | P0 |
| FR-VENUE-08 | Public venue detail for marketplace (published only) | P0 |
| FR-VENUE-09 | Multi-venue per org | P0 |
| FR-VENUE-10 | Pricing rules v1: base rate, peak rules, packages | P0 |
| FR-VENUE-11 | Booking mode per venue/unit: instant vs request-to-book | P0 |
| FR-VENUE-12 | Cancellation policy templates selectable | P0 |

---

## 5. Media

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-MEDIA-01 | Presigned upload for images; metadata stored server-side | P0 |
| FR-MEDIA-02 | Validate type/size; reject unsafe files | P0 |
| FR-MEDIA-03 | CDN/public read for published media | P0 |
| FR-MEDIA-04 | Reorder cover/gallery; delete media | P0 |
| FR-MEDIA-05 | Org-prefixed object keys; authz on upload | P0 |
| FR-MEDIA-06 | Video later (feature-flagged) | P2 |

---

## 6. Search & Discovery

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-SEARCH-01 | Search venues by text (Postgres FTS projection) | P0 |
| FR-SEARCH-02 | Filters: city, category, date, capacity, price range, amenities | P0 |
| FR-SEARCH-03 | Sort: relevance, price, rating, distance | P0 |
| FR-SEARCH-04 | Only PUBLISHED (+ verified boost later) in marketplace results | P0 |
| FR-SEARCH-05 | Search document updated via outbox on venue/booking signals | P0 |
| FR-SEARCH-06 | Pagination/cursor; empty-state suggestions | P0 |
| FR-SEARCH-07 | “Available on date” filter using availability projection | P0 |
| FR-SEARCH-08 | Ranking features (quality, conversion, distance) in V1+ hardening | P1 |
| FR-SEARCH-09 | OpenSearch extraction only after ADR decision gate | P2 |

---

## 7. Maps & Geo

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-MAPS-01 | Store lat/lng; validate India bounding sanity checks | P0 |
| FR-MAPS-02 | Radius / bounding-box filter | P0 |
| FR-MAPS-03 | Map pins on search results (mobile) | P1 |
| FR-MAPS-04 | Venue detail map + directions deep-link | P0 |
| FR-MAPS-05 | City landing geo centers for SEO pages | P1 |

---

## 8. Calendar & Availability

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-CAL-01 | Define availability rules per inventory unit | P0 |
| FR-CAL-02 | Owner day/week calendar UI data APIs | P0 |
| FR-CAL-03 | Block time / maintenance windows | P0 |
| FR-CAL-04 | Manual offline booking entry by owner/staff | P0 |
| FR-CAL-05 | Hold creation with TTL; Redis + DB constraints | P0 |
| FR-CAL-06 | Recurring weekly rules (training/sports) | P1 |
| FR-CAL-07 | Buffer time between bookings | P1 |
| FR-CAL-08 | Timezone: Asia/Kolkata default; store UTC | P0 |

---

## 9. Booking

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-BOOK-01 | State machine: HELD → PENDING_PAYMENT → CONFIRMED / CANCELLED / EXPIRED | P0 |
| FR-BOOK-02 | Idempotent confirm via Idempotency-Key | P0 |
| FR-BOOK-03 | Request-to-book path with owner accept/reject SLA | P0 |
| FR-BOOK-04 | Customer booking list & detail | P0 |
| FR-BOOK-05 | Owner booking list & detail | P0 |
| FR-BOOK-06 | Cancel by customer/owner per policy | P0 |
| FR-BOOK-07 | Illegal transitions rejected with Problem Details | P0 |
| FR-BOOK-08 | Outbox events on state changes | P0 |
| FR-BOOK-09 | Add-ons at booking (lights, catering package hooks) | P1 |
| FR-BOOK-10 | Partial payment bookings (feature flag) | P1 |
| FR-BOOK-11 | Pay-at-venue mode (feature flag, later) | P2 |
| FR-BOOK-12 | Booking audit/history immutable trail | P0 |

---

## 10. Payments

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-PAY-01 | Create Razorpay order aligned to server-calculated amount | P0 |
| FR-PAY-02 | Webhook verification + idempotent processing | P0 |
| FR-PAY-03 | Confirm booking only on trusted capture (not client alone) | P0 |
| FR-PAY-04 | Support UPI, cards, netbanking via Razorpay methods enabled | P0 |
| FR-PAY-05 | Amount mismatch blocked | P0 |
| FR-PAY-06 | Refund primitive linked to booking/payment | P0 |
| FR-PAY-07 | Daily reconciliation job | P0 |
| FR-PAY-08 | No PAN/card storage | P0 |
| FR-PAY-09 | Payment receipts in-app | P0 |
| FR-PAY-10 | Multi-capture / remaining balance (partial pay) | P1 |

---

## 11. Notifications

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-NOTIF-01 | FCM push on booking confirm/cancel | P0 |
| FR-NOTIF-02 | Email templates for confirm/cancel | P0 |
| FR-NOTIF-03 | Outbox dispatcher with retries/backoff; idempotent delivery keys | P0 |
| FR-NOTIF-04 | User preference center (channel opt-in/out) | P0 |
| FR-NOTIF-05 | WhatsApp Business templates for key events | P1 |
| FR-NOTIF-06 | Cost/budget guards for WhatsApp/SMS | P1 |
| FR-NOTIF-07 | Owner notifications for new/request bookings | P0 |
| FR-NOTIF-08 | Digest mode for non-critical alerts (later) | P2 |

---

## 12. Reviews & Ratings

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-REV-01 | Only completed bookings can review | P0 |
| FR-REV-02 | Star rating + text; optional photo | P0 |
| FR-REV-03 | Owner response to review | P0 |
| FR-REV-04 | Aggregate rating on venue search document | P0 |
| FR-REV-05 | Report abusive review | P1 |
| FR-REV-06 | Moderation tools for admin | P1 |

---

## 13. Wishlist

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-WISH-01 | Customer can save/unsave venues | P1 |
| FR-WISH-02 | Wishlist list with availability peek | P1 |
| FR-WISH-03 | Optional notes / event date on wishlist item | P2 |

---

## 14. Coupons & Promotions

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-COUP-01 | Platform coupon codes (percent/fixed INR) | P1 |
| FR-COUP-02 | Owner-scoped coupons (plan-gated) | P1 |
| FR-COUP-03 | Constraints: min booking, category, city, expiry, usage caps | P1 |
| FR-COUP-04 | Apply at checkout; server-side validation | P0 (when coupons live) |
| FR-COUP-05 | Featured listing boosts (paid) | P1 |
| FR-COUP-06 | Referral codes (later) | P2 |

---

## 15. Invoices & Refunds

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-INV-01 | Generate GST-compliant invoice artifacts as applicable | P0/P1 |
| FR-INV-02 | Customer download invoice/receipt | P0 |
| FR-INV-03 | Owner view invoices issued | P0 |
| FR-INV-04 | Refund request workflow | P0 |
| FR-INV-05 | Refund decision per business rules; ledger entries | P0 |
| FR-INV-06 | Credit notes for GST where required | P1 |
| FR-INV-07 | Secure storage of invoice PDF/HTML | P0 |

---

## 16. Settlements & Payouts

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-SETL-01 | Owner earnings ledger views | P1 |
| FR-SETL-02 | Payout profile (bank/UPI) with verification | P1 |
| FR-SETL-03 | Settlement reports / export | P1 |
| FR-SETL-04 | Commission deduction visibility | P1 |
| FR-SETL-05 | Razorpay Route or documented manual settlement process | P1 |
| FR-SETL-06 | Accountant role read access | P2 |

---

## 17. CRM

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-CRM-01 | Owner: customer contact history from bookings | P1 |
| FR-CRM-02 | Owner notes on customer (org-scoped) | P1 |
| FR-CRM-03 | Sales lead pipeline for platform sales | P1 |
| FR-CRM-04 | Lead stages, tasks, reminders | P1 |
| FR-CRM-05 | Activation checklist tied to product events | P1 |
| FR-CRM-06 | Segment customers for owner campaigns (plan-gated) | P2 |

---

## 18. Reports & Analytics

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-RPT-01 | Owner dashboard: bookings, occupancy, revenue (INR) | P1 |
| FR-RPT-02 | Export CSV for bookings/revenue | P1 |
| FR-RPT-03 | Platform analytics: GMV, conversion, supply health | P1 |
| FR-RPT-04 | Funnel events from client (search→detail→hold→pay→confirm) | P0 |
| FR-RPT-05 | Category/city breakdowns | P1 |
| FR-RPT-06 | SLA: report freshness ≤ 15 min for ops dashboards (V2) | P2 |

---

## 19. Subscriptions

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-SUB-01 | Plans: Free, Starter, Professional, Enterprise | P0 |
| FR-SUB-02 | Entitlements gate features (staff seats, venues, CRM, featured credits) | P0 |
| FR-SUB-03 | Upgrade/downgrade with proration rules | P1 |
| FR-SUB-04 | Billing via Razorpay subscriptions or invoices | P1 |
| FR-SUB-05 | Grace period / dunning on failed payment | P1 |
| FR-SUB-06 | Enterprise custom contract flags | P2 |

---

## 20. Support

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-SUP-01 | Customer/owner create support tickets | P1 |
| FR-SUP-02 | Ticket categories: booking, payment, listing, account, other | P1 |
| FR-SUP-03 | Support console: lookup by booking id / phone hash / email | P0 |
| FR-SUP-04 | Macros / canned responses | P1 |
| FR-SUP-05 | SLA timers and severity | P1 |
| FR-SUP-06 | CSAT on close | P1 |

---

## 21. CMS & Marketing

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-CMS-01 | Manage marketing pages content for SSR site | P1 |
| FR-CMS-02 | Blog / help center articles | P1 |
| FR-CMS-03 | Banners / in-app announcements (flagged) | P1 |
| FR-CMS-04 | City/category landing content blocks | P1 |
| FR-CMS-05 | Legal pages: terms, privacy, cancellation | P0 |
| FR-CMS-06 | Campaign UTM landing support | P1 |

---

## 22. Admin & Moderation

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-ADM-01 | Platform role auth for admin app | P0 |
| FR-ADM-02 | Org/user/venue/booking lookup | P0 |
| FR-ADM-03 | Force unpublish venue with reason | P0 |
| FR-ADM-04 | Audit log viewer | P0 |
| FR-ADM-05 | Feature flag management UI | P1 |
| FR-ADM-06 | Category taxonomy management | P1 |
| FR-ADM-07 | Impersonation prohibited; break-glass with Super Admin + audit only if ever needed | P0 |
| FR-ADM-08 | Refund override within policy bounds | P1 |

---

## 23. Vendor Marketplace

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-VND-01 | Vendor org/profile with categories of service | P2 |
| FR-VND-02 | Service packages & pricing | P2 |
| FR-VND-03 | Discover vendors by city/category | P2 |
| FR-VND-04 | Attach vendor quote to venue booking | P2 |
| FR-VND-05 | Vendor booking calendar conflicts | P2 |
| FR-VND-06 | Vendor reviews after completion | P2 |
| FR-VND-07 | Commission on vendor GMV | P2 |

---

## 24. AI Features

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-AI-01 | Assistive listing description suggestions (owner opt-in) | P2 |
| FR-AI-02 | Search query rewriting / synonym assist (server-side) | P2 |
| FR-AI-03 | Anomaly flags for fraud (signals, not auto-ban alone) | P2 |
| FR-AI-04 | Owner insight narratives on reports (“weekend yield down”) | P2 |
| FR-AI-05 | AI must not be sole booking path; human-confirmable outputs | P0 constraint |

---

## 25. Website & SEO

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-WEB-01 | SSR home, city, category, public venue pages | P0 |
| FR-WEB-02 | Sitemap, robots, canonical URLs | P0 |
| FR-WEB-03 | Meta/OG tags; Core Web Vitals budget | P0 |
| FR-WEB-04 | Deep links into customer app for book CTA | P0 |
| FR-WEB-05 | Crawlable without auth | P0 |
| FR-WEB-06 | Help/legal/blog routes | P1 |

---

## 26. Trust, Safety & KYC

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-TRUST-01 | Owner KYC submission workflow | P0 |
| FR-TRUST-02 | Listing verification badge workflow | P0 |
| FR-TRUST-03 | User reporting for listings/reviews | P1 |
| FR-TRUST-04 | Dispute case object linking booking/payment | P1 |
| FR-TRUST-05 | Fraud signal logging | P1 |
| FR-TRUST-06 | DPDP retention & erasure workflows | P1 |

---

## 27. Owner Ops & Category Capabilities

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-OPS-01 | Capability plugin: hall event day-rate | P0 |
| FR-OPS-02 | Capability plugin: meeting hourly/half-day | P0 |
| FR-OPS-03 | Capability plugin: sports pitch hourly | P1 |
| FR-OPS-04 | Capability plugin: training recurring slots | P1 |
| FR-OPS-05 | Capability plugin: coworking desk pass | P1 |
| FR-OPS-06 | Category-specific filters in customer UI | P1 |
| FR-OPS-07 | Feature flags per category rollout | P0 |

---

## 28. Event Organizer & Franchise

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-EVT-01 | Event organizer can manage multi-booking event workspace | P2 |
| FR-EVT-02 | Shareable event shortlist with collaborators | P2 |
| FR-EVT-03 | Franchise partner multi-org rollup dashboards | P2 |
| FR-EVT-04 | White-label booking page (Enterprise) | P2 |
| FR-EVT-05 | Partner commission reporting | P2 |

---

## 29. Sales & Growth Ops

| ID | Requirement | Priority |
|----|-------------|----------|
| FR-SALES-01 | Internal lead CRM for supply onboarding | P1 |
| FR-SALES-02 | Territory/city assignment | P1 |
| FR-SALES-03 | Onboarding checklist completion tracking | P1 |
| FR-SALES-04 | Plan upsell tasks & outcomes | P1 |
| FR-SALES-05 | Sales dashboard: activations, conversion | P1 |

---

## Requirement count

Approximately **170+ FR line items** across modules; each maps to one or more `US-xxx` in stories.
