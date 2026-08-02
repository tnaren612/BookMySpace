# 01 — Personas

**Document ID:** PRD-01  
**Related:** [02-journey-maps.md](02-journey-maps.md), [06-roles-permissions.md](06-roles-permissions.md)

---

## Table of contents

1. [Persona summary](#1-persona-summary)
2. [P1 — Customer](#2-p1--customer)
3. [P2 — Hall Owner](#3-p2--hall-owner)
4. [P3 — Training Institute Owner](#4-p3--training-institute-owner)
5. [P4 — Sports Ground Owner](#5-p4--sports-ground-owner)
6. [P5 — Vendor](#6-p5--vendor)
7. [P6 — Administrator](#7-p6--administrator)
8. [P7 — Support Executive](#8-p7--support-executive)
9. [P8 — Sales Executive](#9-p8--sales-executive)
10. [Secondary personas](#10-secondary-personas)

---

## 1. Persona summary

| ID | Persona | Primary job-to-be-done | Surface |
|----|---------|------------------------|---------|
| P1 | Customer | Find & book the right space fast | Customer app + website |
| P2 | Hall Owner | Fill halls without double-booking or broker leakage | Owner app |
| P3 | Training Institute Owner | Fill batch/room slots and collect fees | Owner app |
| P4 | Sports Ground Owner | Monetize hourly pitches with clear schedules | Owner app |
| P5 | Vendor | Get attached to venue bookings for services | Vendor / marketplace |
| P6 | Administrator | Keep supply trustworthy and platform healthy | Admin web |
| P7 | Support Executive | Resolve booking/payment issues quickly | Admin web |
| P8 | Sales Executive | Onboard quality supply and upsell plans | Admin / CRM |

---

## 2. P1 — Customer

**Name archetype:** Aarav, 29, Bengaluru — planning sister’s reception + weekend football.

### Goals

- Discover venues by city, date, capacity, budget, and amenities
- Trust photos, reviews, and verification
- Book and pay in minutes (UPI)
- Manage upcoming bookings; cancel/refund per policy
- Rebook favorites; share venue links with family

### Pain points

- Calling 10 halls; unclear availability
- Hidden charges; broker commissions
- Fake photos; no recourse after advance payment
- Sports slots overbooked by phone

### Daily workflow

1. Search city + date + category  
2. Filter capacity/price/amenities  
3. Open venue → check calendar → hold  
4. Pay → receive confirmation  
5. Share details; optionally review post-event  

### Needs

- Transparent price breakdown (incl. GST display rules)
- Map + distance
- Instant or clear request-to-book SLA
- WhatsApp/email/push confirmation
- Wishlist and compare (lightweight)

### Success metrics

- Time-to-book; booking conversion; repeat book rate; CSAT post-booking; refund resolution time

---

## 3. P2 — Hall Owner

**Name archetype:** Meera, 44 — owns 2 banquet halls in Jaipur.

### Goals

- Publish accurate listings with photos and packages
- Prevent double-booking
- Collect advances online; track dues
- See calendar occupancy and revenue
- Respond to booking requests and reviews

### Pain points

- WhatsApp chaos; staff double-promises
- Cash advances without records
- GST invoicing nightmares
- Seasonal emptiness; no marketing reach

### Daily workflow

1. Check today’s calendar & arrivals  
2. Confirm/reject requests; block prep time  
3. Update package pricing for wedding season  
4. Follow up on pending payments  
5. Reply to reviews / support tickets  

### Needs

- Day/week calendar; holds visible
- Staff roles (manager vs receptionist)
- Payout clarity; invoice generation
- Featured listing / city SEO presence
- Mobile-first owner app

### Success metrics

- Occupancy rate; GMV via platform; time-to-confirm; payout reconciliation accuracy; listing quality score

---

## 4. P3 — Training Institute Owner

**Name archetype:** Vikram, 38 — runs coding + design academy with 6 classrooms.

### Goals

- Publish room/batch availability
- Allow trial class or package bookings
- Reduce no-shows with prepaid slots
- Understand utilization per room/trainer window

### Pain points

- Spreadsheet timetables
- Parents/students calling for “any free slot?”
- Partial payments tracked in notebooks
- Hard to upsell packages

### Daily workflow

1. Review today’s batch occupancy  
2. Open/close registration windows  
3. Adjust recurring weekly slots  
4. Collect fees; issue receipts  
5. Message students on changes  

### Needs

- Recurring availability rules
- Package / multi-session products
- Notifications on cancel/reschedule
- Simple CRM of students/org contacts
- Reports: utilization, revenue per room

### Success metrics

- Slot fill rate; prepaid %; no-show rate; package conversion; admin hours saved/week

---

## 5. P4 — Sports Ground Owner

**Name archetype:** Imran, 35 — turf owner; 5-a-side + cricket nets.

### Goals

- Sell hourly slots online
- Enforce buffer/cleanup between matches
- Dynamic peak pricing (evening/weekend)
- Reduce gate cash leakage

### Pain points

- Friends-of-staff free slots
- Overlapping phone bookings
- Lights/equipment add-ons unmanaged
- Rain cancellations / refund fights

### Daily workflow

1. Open day view of pitches  
2. Confirm walk-ins vs app bookings  
3. Mark maintenance blocks  
4. Collect remaining balance if partial pay  
5. End-of-day settlement glance  

### Needs

- Hourly inventory units per pitch
- Peak/off-peak price rules
- Add-on catalog (lights, balls, referee)
- Weather/cancellation policy templates
- Fast check-in code / booking ID at gate

### Success metrics

- Hours sold / available hours; peak yield; cash vs online mix; dispute rate; repeat player rate

---

## 6. P5 — Vendor

**Name archetype:** Sana, 31 — wedding decorator & lighting vendor.

### Goals

- Get discovered by venue bookers and owners
- Attach quotes to venue bookings
- Collect advances; manage calendar of jobs
- Build ratings from completed jobs

### Pain points

- Dependent on hall-owner referrals only
- Scope creep without written packages
- Payment delays
- No shared schedule with venue

### Daily workflow

1. Review inbound RFQs  
2. Send package quote  
3. Confirm date against personal calendar  
4. Deliver service; collect balance  
5. Request review  

### Needs

- Vendor profile + portfolio media
- Service packages & geo coverage
- Booking attachment / co-scheduling
- Payout tracking
- Messaging with customer/owner (platform-mediated)

### Success metrics

- Quote→win rate; GMV; on-time completion; rating; repeat hire rate

---

## 7. P6 — Administrator

**Name archetype:** Platform Ops Lead (internal).

### Goals

- Verify owners/listings; unpublish fraud
- Configure categories, feature flags, policies
- Protect marketplace trust & liquidity
- Oversee compliance posture (DPDP, GST process)

### Pain points

- Fake listings and stolen photos
- Ambiguous policy edge cases
- Tooling gaps causing spreadsheet work

### Daily workflow

1. Review verification queue  
2. Moderate flagged reviews/listings  
3. Investigate anomalies (refund spikes, KYC fails)  
4. Adjust feature flags / city launches  
5. Audit critical admin actions  

### Needs

- Powerful search by org/venue/booking/phone hash
- Audit log
- Force actions with reason codes
- Dashboards for supply health

### Success metrics

- Verification SLA; fraud catch rate; time-to-unpublish; audit completeness; supply quality score

---

## 8. P7 — Support Executive

**Name archetype:** Neha, Support L1/L2.

### Goals

- Resolve booking, payment, refund, access issues fast
- Escalate correctly with full context
- Maintain CSAT without over-refunding

### Pain points

- Incomplete booking timelines
- Payment webhook ambiguity
- Customers and owners blaming each other

### Daily workflow

1. Triage tickets by severity  
2. Lookup booking timeline + payment ledger  
3. Apply policy (refund/cancel/extend hold)  
4. Communicate via ticket + optional WhatsApp template  
5. Tag root cause for product feedback  

### Needs

- Unified booking/payment timeline UI
- Macros / policy snippets
- Clear RBAC (cannot access unrelated PII beyond need)
- Escalation to finance/admin

### Success metrics

- FRT / AHT; CSAT; reopen rate; policy-compliant refund %; escalation accuracy

---

## 9. P8 — Sales Executive

**Name archetype:** Rohit, Supply Sales.

### Goals

- Onboard high-quality venues in target cities/categories
- Move owners from Free → paid plans
- Educate on calendar + payouts to reduce churn

### Pain points

- Long onboarding; incomplete listings
- Owners ghost after signup
- Unclear which leads convert

### Daily workflow

1. Work lead queue (city/category)  
2. Demo owner app; help first publish  
3. Track activation checklist  
4. Upsell Starter/Professional  
5. Hand off to success/support  

### Needs

- CRM pipeline stages
- Lead scoring / city targets
- Onboarding checklist tied to product events
- Commission / target dashboards (internal)

### Success metrics

- Qualified orgs / week; publish rate; time-to-first-booking; plan conversion; logo retention 90-day

---

## 10. Secondary personas

| Persona | Notes | Maps to roles |
|---------|-------|---------------|
| Venue Staff / Manager | Day ops without billing rights | `ORG_MANAGER`, `ORG_STAFF` |
| Accountant | Payouts, invoices, GST exports | `ORG_ACCOUNTANT` (later) |
| Event Organizer | Multi-venue / multi-vendor events | See stories module 27 |
| Franchise Partner | Multi-city brand operator | Enterprise role set |
| Super Admin | Break-glass platform control | `PLATFORM_SUPER_ADMIN` |

---

## Persona → RBAC quick map

| Persona | Typical roles |
|---------|---------------|
| Customer | Authenticated customer |
| Hall / Training / Sports Owner | `ORG_OWNER` (+ optional staff) |
| Vendor | Vendor org membership (V2+) |
| Administrator | `PLATFORM_SUPER_ADMIN` / `PLATFORM_MODERATOR` |
| Support | `PLATFORM_SUPPORT` |
| Sales | Platform sales permission set (internal) |
