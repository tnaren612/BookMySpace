# Stories — Payments (US-111–US-125)

**Module:** PAY | **FRs:** FR-PAY-* | **ADR-010**

---

### US-111 — Create Razorpay order
**As a** customer, **I want** a payment order created for my booking, **so that** I can pay via UPI/cards.  
**FR:** FR-PAY-01 | **P0**  
**AC:**
- AC-111-01: Amount equals server-calculated booking amount.
- AC-111-02: Idempotency-Key required.
- AC-111-03: Links payment intent to booking id.

### US-112 — Checkout UPI success
**As a** customer, **I want** to pay with UPI, **so that** I complete booking the India-preferred way.  
**FR:** FR-PAY-04 | **P0**  
**AC:**
- AC-112-01: Razorpay SDK/flow completes.
- AC-112-02: Client success alone does not confirm booking.
- AC-112-03: User sees pending until webhook confirms if needed.

### US-113 — Webhook capture processing
**As a** platform, **I want** verified webhooks to capture payment, **so that** booking can confirm.  
**FR:** FR-PAY-02 | **P0**  
**AC:**
- AC-113-01: Signature verified; invalid rejected.
- AC-113-02: Raw webhook stored.
- AC-113-03: Processing idempotent on replay.

### US-114 — Amount mismatch guard
**As a** platform, **I want** mismatched amounts blocked, **so that** fraud/underpay fails closed.  
**FR:** FR-PAY-05 | **P0**  
**AC:**
- AC-114-01: Mismatch does not confirm booking.
- AC-114-02: Alert/metric fired.
- AC-114-03: Support-visible case flag.

### US-115 — Payment failure handling
**As a** customer, **I want** clear failure messaging, **so that** I can retry payment.  
**FR:** FR-PAY-01 | **P0**  
**AC:**
- AC-115-01: Booking remains PENDING_PAYMENT until TTL.
- AC-115-02: Retry creates safe idempotent order behavior.
- AC-115-03: Exhausted TTL → EXPIRED/CANCELLED per BR.

### US-116 — Payment receipt in-app
**As a** customer, **I want** a receipt, **so that** I have proof of payment.  
**FR:** FR-PAY-09 | **P0**  
**AC:**
- AC-116-01: Shows amount, method (masked), time, booking code.
- AC-116-02: Download/share supported.
- AC-116-03: INR formatting correct.

### US-117 — Initiate refund
**As a** support/owner, **I want** to initiate refunds, **so that** cancellations settle money correctly.  
**FR:** FR-PAY-06 | **P0**  
**AC:**
- AC-117-01: Refund amount ≤ captured.
- AC-117-02: Idempotent refund keys.
- AC-117-03: Ledger entry created.

### US-118 — Refund webhook/status
**As a** platform, **I want** refund status updates, **so that** customers see progress.  
**FR:** FR-PAY-06 | **P0**  
**AC:**
- AC-118-01: Status transitions recorded.
- AC-118-02: Customer notified on success.
- AC-118-03: Failures alert finance/support.

### US-119 — Daily reconciliation
**As a** finance/ops user, **I want** daily reconcile of Razorpay vs ledger, **so that** drift is caught.  
**FR:** FR-PAY-07 | **P0**  
**AC:**
- AC-119-01: Job runs daily.
- AC-119-02: Differences reported.
- AC-119-03: Critical drift alerts.

### US-120 — No PAN storage
**As a** platform, **I want** zero card PAN storage, **so that** PCI scope stays minimal.  
**FR:** FR-PAY-08 | **P0**  
**AC:**
- AC-120-01: Schema/review forbids PAN fields.
- AC-120-02: Logs scrub card-like numbers.
- AC-120-03: Security checklist item enforced.

### US-121 — Partial capture / remaining balance
**As a** customer on partial-pay booking, **I want** to pay remaining balance, **so that** I complete dues.  
**FR:** FR-PAY-10 | **P1**  
**AC:**
- AC-121-01: Remaining amount computed server-side.
- AC-121-02: Second order linked to same booking.
- AC-121-03: Status shows paid/partially paid.

### US-122 — Payment method display
**As a** customer, **I want** to see available methods, **so that** I choose UPI/card/netbanking.  
**FR:** FR-PAY-04 | **P0**  
**AC:**
- AC-122-01: Methods reflect Razorpay enablement.
- AC-122-02: Unavailable methods hidden/disabled.

### US-123 — Double-tap payment protection
**As a** customer, **I want** double submits ignored, **so that** I am not charged twice.  
**FR:** FR-PAY-01, ADR-010 | **P0**  
**AC:**
- AC-123-01: Idempotency prevents duplicate orders.
- AC-123-02: UI disables pay button while in-flight.
- AC-123-03: Duplicate charge path covered in US-118/support.

### US-124 — Owner payment notification
**As an** owner, **I want** to know when payment succeeds, **so that** I prepare the venue.  
**FR:** FR-NOTIF-07 | **P0**  
**AC:**
- AC-124-01: Notify on CONFIRMED.
- AC-124-02: Includes booking code and slot.
- AC-124-03: Respects owner notification prefs for non-critical channels.

### US-125 — Payment isolation boundary
**As an** engineer/PM, **I want** payment logic isolated in its context, **so that** financial correctness is enforceable.  
**FR:** FR-PAY-* | **P0**  
**AC:**
- AC-125-01: No cross-context DB joins required for capture handler.
- AC-125-02: Booking reacts to payment domain events/outbox.
- AC-125-03: Aligns ADR-010.
