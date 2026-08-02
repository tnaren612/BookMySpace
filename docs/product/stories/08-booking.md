# Stories — Booking (US-091–US-110)

**Module:** BOOK | **FRs:** FR-BOOK-*

---

### US-091 — Confirm booking from hold (instant)
**As a** customer, **I want** to confirm my hold, **so that** I proceed to payment.  
**FR:** FR-BOOK-01 | **P0**  
**AC:**
- AC-091-01: Requires valid hold owned by user.
- AC-091-02: Moves to PENDING_PAYMENT.
- AC-091-03: Idempotency-Key returns same booking (FR-BOOK-02).

### US-092 — Idempotent confirm
**As a** customer on flaky network, **I want** retries to be safe, **so that** I don’t create duplicates.  
**FR:** FR-BOOK-02 | **P0**  
**AC:**
- AC-092-01: Same key + payload → same booking id.
- AC-092-02: Same key + different payload → conflict error.
- AC-092-03: Test coverage mandatory.

### US-093 — Request-to-book submit
**As a** customer, **I want** to request a booking, **so that** the owner can approve.  
**FR:** FR-BOOK-03 | **P0**  
**AC:**
- AC-093-01: Creates request state per BR-BOOK-03.
- AC-093-02: Owner notified.
- AC-093-03: SLA expiry configurable.

### US-094 — Owner accept request
**As an** owner, **I want** to accept a request, **so that** the customer can pay.  
**FR:** FR-BOOK-03 | **P0**  
**AC:**
- AC-094-01: Accept transitions toward payment pending.
- AC-094-02: Reject path frees inventory.
- AC-094-03: Only permitted roles.

### US-095 — Owner reject request
**As an** owner, **I want** to reject with reason, **so that** the customer understands.  
**FR:** FR-BOOK-03 | **P0**  
**AC:**
- AC-095-01: Inventory released.
- AC-095-02: Customer notified with reason code/text sanitized.
- AC-095-03: Audit recorded.

### US-096 — Booking confirmed on payment
**As a** customer, **I want** my booking confirmed after payment capture, **so that** my reservation is guaranteed.  
**FR:** FR-BOOK-01, FR-PAY-03 | **P0**  
**AC:**
- AC-096-01: CONFIRMED only after trusted payment event.
- AC-096-02: Outbox event BookingConfirmed written same txn as state change.
- AC-096-03: Illegal skip of payment blocked in prepaid mode.

### US-097 — Customer booking list
**As a** customer, **I want** to see my bookings, **so that** I can track upcoming events.  
**FR:** FR-BOOK-04 | **P0**  
**AC:**
- AC-097-01: Lists user’s bookings only.
- AC-097-02: Filter upcoming/past/cancelled.
- AC-097-03: Shows status prominently.

### US-098 — Customer booking detail
**As a** customer, **I want** booking detail, **so that** I have address, time, and payment status.  
**FR:** FR-BOOK-04 | **P0**  
**AC:**
- AC-098-01: Includes venue snapshot fields needed offline.
- AC-098-02: Shows amount breakdown.
- AC-098-03: Actions: cancel/pay/review as applicable.

### US-099 — Owner booking list
**As an** owner, **I want** org bookings list, **so that** I can operate daily.  
**FR:** FR-BOOK-05 | **P0**  
**AC:**
- AC-099-01: Org-scoped only.
- AC-099-02: Filter by venue/status/date.
- AC-099-03: Staff see per RBAC.

### US-100 — Owner booking detail
**As a** venue staff, **I want** booking detail with customer contact rules, **so that** I can check in guests.  
**FR:** FR-BOOK-05 | **P0**  
**AC:**
- AC-100-01: Shows booking id / check-in code.
- AC-100-02: PII minimized per support policy.
- AC-100-03: Timeline of state changes visible.

### US-101 — Customer cancel booking
**As a** customer, **I want** to cancel per policy, **so that** I can free my plans.  
**FR:** FR-BOOK-06 | **P0**  
**AC:**
- AC-101-01: Applies BR-REF-01 template selected on venue.
- AC-101-02: Triggers refund workflow when prepaid.
- AC-101-03: Inventory released when rules say so.

### US-102 — Owner cancel booking
**As an** owner, **I want** to cancel a booking, **so that** I can handle emergencies.  
**FR:** FR-BOOK-06 | **P0**  
**AC:**
- AC-102-01: Owner-caused cancel → full refund rule (BR-REF-01).
- AC-102-02: Reason required.
- AC-102-03: Customer notified.

### US-103 — Illegal transition rejected
**As a** platform, **I want** illegal state transitions rejected, **so that** booking integrity holds.  
**FR:** FR-BOOK-07 | **P0**  
**AC:**
- AC-103-01: e.g., EXPIRED → CONFIRMED rejected.
- AC-103-02: Problem Details error.
- AC-103-03: No partial side effects.

### US-104 — Booking audit trail
**As a** support executive, **I want** immutable booking history, **so that** disputes are resolvable.  
**FR:** FR-BOOK-12 | **P0**  
**AC:**
- AC-104-01: Each transition append-only logged.
- AC-104-02: Includes actor and correlation id.
- AC-104-03: Not editable via API.

### US-105 — Add-ons at booking
**As a** customer, **I want** to add lights/equipment add-ons, **so that** I get a complete package.  
**FR:** FR-BOOK-09 | **P1**  
**AC:**
- AC-105-01: Add-ons from venue catalog.
- AC-105-02: Included in server amount.
- AC-105-03: Shown on invoice/receipt.

### US-106 — Partial payment booking
**As a** hall customer, **I want** to pay advance now, **so that** I secure the date.  
**FR:** FR-BOOK-10 | **P1**  
**AC:**
- AC-106-01: Feature-flagged.
- AC-106-02: Remaining balance tracked.
- AC-106-03: Confirm rules for when booking becomes CONFIRMED (advance threshold).

### US-107 — Pay-at-venue mode
**As a** sports player, **I want** to reserve and pay at gate, **so that** I book faster (when enabled).  
**FR:** FR-BOOK-11 | **P2**  
**AC:**
- AC-107-01: Flagged off by default.
- AC-107-02: No capture required for CONFIRMED if mode allows — high risk; requires owner enable + deposit rules.
- AC-107-03: Documented fraud mitigations.

### US-108 — Hold expiry cancels pending path
**As a** customer, **I want** clear messaging when hold expires mid-checkout, **so that** I can restart.  
**FR:** FR-BOOK-01 | **P0**  
**AC:**
- AC-108-01: UI shows expired state.
- AC-108-02: Suggests next slots.
- AC-108-03: Payment not started or aborted cleanly.

### US-109 — Booking reference code
**As a** customer, **I want** a human-friendly booking code, **so that** I can share at the venue gate.  
**FR:** FR-BOOK-04 | **P0**  
**AC:**
- AC-109-01: Unique code generated.
- AC-109-02: Shown on confirm screen and notifications.
- AC-109-03: Owner can search by code.

### US-110 — Snapshot venue details on booking
**As a** platform, **I want** booking to snapshot key venue fields, **so that** later venue edits don’t rewrite history.  
**FR:** FR-BOOK-12 | **P0**  
**AC:**
- AC-110-01: Name/address/unit/time/price snapshot stored.
- AC-110-02: Historical booking detail uses snapshot.
- AC-110-03: Live venue link still available if published.
