# 05 — Business Rules

**Document ID:** PRD-05  
**ID format:** `BR-{AREA}-{nn}`  
**Related:** Booking, Payments, Subscriptions, Trust

Decision tables below are **product law**. Edge cases not listed escalate to founder decision and then update this doc.

---

## 1. Booking state machine

### BR-BOOK-01 — Allowed transitions

| From | To | Actor / trigger |
|------|----|-----------------|
| (none) | HELD | Customer hold API |
| HELD | PENDING_PAYMENT | Customer confirm (instant) OR owner accept (request) |
| HELD | EXPIRED | TTL worker |
| HELD | CANCELLED | Customer/owner cancel before confirm |
| PENDING_PAYMENT | CONFIRMED | Payment captured (webhook truth) |
| PENDING_PAYMENT | CANCELLED | User cancel / timeout / payment fail terminal |
| PENDING_PAYMENT | EXPIRED | Payment window TTL |
| CONFIRMED | CANCELLED | Cancel per policy (may trigger refund) |
| Any | *illegal* | Reject with Problem Details |

### BR-BOOK-02 — Hold TTL

| Condition | TTL default |
|-----------|-------------|
| Standard mobile checkout | 10 minutes |
| Request-to-book awaiting owner | Hold soft-reserve policy: 24h or until reject (configurable) |
| Enterprise custom | Contract override |

### BR-BOOK-03 — Instant vs request-to-book

| Venue mode | Behavior |
|------------|----------|
| Instant | Hold → pay → confirm without owner approval |
| Request | Hold/request → owner accept/reject → then pay (or pay-authorize per flag) |

### BR-BOOK-04 — Double-booking prevention layers

1. DB exclusion / range constraints  
2. Optimistic version on calendar  
3. Redis hold key  
4. Idempotency keys  
5. Reconciliation  

**Rule:** Confirmed overlapping bookings for same inventory unit **must be impossible** in prepaid instant mode.

---

## 2. Pricing & amounts

### BR-PRICE-01 — Server is source of truth

Client-displayed price is advisory. Payable amount is recalculated server-side at hold/confirm.

### BR-PRICE-02 — Price components

| Component | Included |
|-----------|----------|
| Base rate | Yes |
| Peak adjustments | Yes |
| Add-ons | Yes if selected |
| Coupons | Yes if valid |
| Taxes (GST) | Per tax config |
| Platform fee / commission | Per commercial model (may be owner-side) |

### BR-PRICE-03 — Currency

INR only for India MVP. Amounts stored as integer minor units (paise).

---

## 3. Cancellation & refunds

### BR-REF-01 — Customer cancel before event (illustrative default policy)

| Time before start | Refund of prepaid amount |
|-------------------|--------------------------|
| ≥ 7 days | 100% minus payment gateway fees if non-recoverable (founder config) |
| 48 hours – 7 days | 50% |
| < 48 hours | 0% (credit optional) |
| Owner-caused cancel | 100% |

> Exact percentages are **configurable per venue policy template**; table is default platform template A.

### BR-REF-02 — Refund decision table

| Condition | Action |
|-----------|--------|
| Within policy auto-refund | Initiate Razorpay refund; ledger entry; notify |
| Outside policy | Deny with explanation; allow support escalate |
| Payment not captured | Cancel booking; no refund object |
| Partial capture | Refund captured portion per % |
| Duplicate charge | Full refund of duplicate via support/reconcile |
| Fraud freeze | Block payout; case required |

### BR-REF-03 — Who can refund

| Role | Capability |
|------|------------|
| Customer | Request cancel → auto if policy allows |
| ORG_OWNER / MANAGER | Cancel & refund within org policy |
| PLATFORM_SUPPORT | Refund within policy + documented reason |
| PLATFORM_SUPER_ADMIN | Override with audit (rare) |

---

## 4. Reviews

### BR-REV-01

| Condition | Allowed? |
|-----------|----------|
| Booking CONFIRMED and end time passed (completed) | Yes |
| Booking cancelled | No |
| Duplicate review same booking | No |
| Owner review of self | No |

### BR-REV-02 — Visibility

Published reviews visible on marketplace; removed reviews only via moderation with reason.

---

## 5. Publishing & trust

### BR-PUB-01 — Minimum publish fields

Photos (≥3), title, description, address+geo, category, capacity, ≥1 inventory unit, pricing rule, cancellation policy, booking mode.

### BR-PUB-02 — KYC gate

| Plan / risk | KYC required before publish? |
|-------------|------------------------------|
| MVP default | Yes before PUBLISHED (or PENDING_REVIEW until KYC) |
| Feature flag soft-launch | May allow limited publish with “Unverified” badge |

### BR-TRUST-01 — Force unpublish

Admin may unpublish instantly; owner notified; existing CONFIRMED bookings remain honored unless fraud case says otherwise.

---

## 6. Tenancy & authorization

### BR-TEN-01

Never trust client-supplied `organizationId` as authority.

### BR-TEN-02

Customers are platform-scoped; can book across orgs.

### BR-TEN-03

Staff permissions cannot exceed inviter’s role.

### BR-TEN-04

Soft-delete preferred; hard delete only via DPDP erasure after legal holds clear.

---

## 7. Payments

### BR-PAY-01

Webhook/server confirmation is source of truth for capture.

### BR-PAY-02

Amount mismatch → reject confirmation; alert.

### BR-PAY-03

Idempotency-Key required on create order / confirm booking.

### BR-PAY-04 — Methods

UPI, cards, netbanking as enabled in Razorpay dashboard; product does not store cards.

---

## 8. Notifications

### BR-NOTIF-01

Transactional messages (confirm/cancel) not subject to marketing opt-out; still respect channel reachability.

### BR-NOTIF-02

Marketing WhatsApp/SMS require explicit opt-in.

### BR-NOTIF-03

Opt-out must be honored within 24 hours for marketing.

---

## 9. Subscriptions & entitlements

### BR-SUB-01 — Plan limits (defaults; commercial tuning allowed)

| Entitlement | Free | Starter | Professional | Enterprise |
|-------------|------|---------|--------------|------------|
| Venues | 1 | 3 | 10 | Custom |
| Staff seats | 1 | 3 | 10 | Custom |
| Photos per venue | 10 | 25 | 50 | Custom |
| Owner coupons | No | Yes | Yes | Yes |
| CRM notes | No | Basic | Advanced | Advanced |
| Reports export | No | Yes | Yes | Yes |
| Featured credits / mo | 0 | 1 | 5 | Custom |
| Vendor marketplace | No | No | Yes | Yes |
| API / white-label | No | No | No | Yes |

### BR-SUB-02 — Upgrade

Immediate entitlement expand; charge prorated (or full period — founder choice documented in SUB open questions).

### BR-SUB-03 — Downgrade

Allowed at period end by default; if over limit (venues/staff), org must archive/remove excess before downgrade completes.

### BR-SUB-04 — Failed billing

Grace period 7 days (configurable); then freeze publish + featured; existing confirmed bookings still serviced.

---

## 10. Coupons

### BR-COUP-01

| Check | Rule |
|-------|------|
| Expiry | Reject if now > expiry |
| Usage cap | Reject if global or per-user cap exceeded |
| Min amount | Reject if subtotal < min |
| Stacking | Platform + owner stack only if both allow; default no double % stack |

### BR-COUP-02

Discount never reduces payable below ₹1 if payment required (unless 100% comp code admin-only).

---

## 11. Commissions & settlements

### BR-SETL-01

Marketplace commission % by category/plan (founder-set). Shown in owner earnings gross → fees → net.

### BR-SETL-02

Payouts withheld if KYC incomplete or fraud freeze active.

### BR-SETL-03

Refunds reverse commission per finance policy (full/partial clawback).

---

## 12. Category capability rules

### BR-OPS-01 — Inventory semantics

| Category plugin | Slot granularity | Overlap rule |
|-----------------|------------------|--------------|
| Hall/event | Day or defined event windows | No overlap per unit |
| Meeting | Hourly / half-day | No overlap |
| Sports | Hourly + buffer | No overlap incl. buffer |
| Training | Recurring session slots | Capacity may allow multi-seat if unit type = classroom seats (explicit) |
| Coworking | Day pass / seat | Capacity-limited concurrent seats |

### BR-OPS-02

Multi-seat capacity bookings (classroom/coworking) must decrement remaining capacity atomically.

---

## 13. Support & admin

### BR-SUP-01

Support cannot edit venue content directly without moderator permission.

### BR-ADM-01

Every force action requires reason code + audit row.

### BR-ADM-02

Sales roles cannot access payment PAN-equivalent data (none stored) or arbitrary customer message bodies beyond lead context.

---

## 14. AI

### BR-AI-01

AI suggestions are assistive; publishing/booking requires explicit user confirmation.

### BR-AI-02

Fraud AI may flag, not auto-ban without policy threshold + human review (except emergency automated unpublish under extreme score with audit).
