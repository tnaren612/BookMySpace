# Stories — Invoices & Refunds (US-164–US-175)

**Module:** INV | **FRs:** FR-INV-*

---

### US-164 — Generate invoice on payment
**As a** customer, **I want** a GST-aware invoice when applicable, **so that** my booking is documented for finance.  
**FR:** FR-INV-01 | **P0/P1**  
**AC:**
- AC-164-01: Invoice artifact generated after capture when tax rules say so.
- AC-164-02: Includes GSTIN fields when present.
- AC-164-03: Stored securely (FR-INV-07).

### US-165 — Download invoice
**As a** customer, **I want** to download invoice/receipt PDF/HTML, **so that** I can share with family/finance.  
**FR:** FR-INV-02 | **P0**  
**AC:**
- AC-165-01: Authenticated download only.
- AC-165-02: Time-limited URL if via object storage.
- AC-165-03: Works for past bookings.

### US-166 — Owner view issued invoices
**As an** owner/accountant, **I want** to list invoices, **so that** I reconcile revenue.  
**FR:** FR-INV-03 | **P0**  
**AC:**
- AC-166-01: Org-scoped list.
- AC-166-02: Filter by date/venue.
- AC-166-03: RBAC for accountant role.

### US-167 — Customer request refund
**As a** customer, **I want** to request a refund with cancel, **so that** money returns per policy.  
**FR:** FR-INV-04 | **P0**  
**AC:**
- AC-167-01: Creates refund request linked to booking/payment.
- AC-167-02: Auto-approve path when BR-REF allows.
- AC-167-03: Otherwise pending support/owner.

### US-168 — Auto refund within policy
**As a** platform, **I want** in-policy refunds automated, **so that** support load drops.  
**FR:** FR-INV-05 | **P0**  
**AC:**
- AC-168-01: Computes % from policy template.
- AC-168-02: Initiates Razorpay refund.
- AC-168-03: Notifies customer.

### US-169 — Support override refund
**As a** support executive, **I want** to issue in-policy refunds with reason, **so that** edge cases resolve.  
**FR:** FR-INV-05, FR-ADM-08 | **P1**  
**AC:**
- AC-169-01: Reason mandatory.
- AC-169-02: Audited.
- AC-169-03: Cannot exceed captured amount.

### US-170 — Credit note
**As an** accountant, **I want** credit notes for GST adjustments, **so that** compliance holds.  
**FR:** FR-INV-06 | **P1**  
**AC:**
- AC-170-01: Credit note linked to original invoice.
- AC-170-02: Secure storage.
- AC-170-03: Visible to owner finance roles.

### US-171 — Refund status on booking
**As a** customer, **I want** refund status on booking detail, **so that** I know when money returns.  
**FR:** FR-INV-04 | **P0**  
**AC:**
- AC-171-01: Shows pending/processed/failed.
- AC-171-02: Expected timeline messaging.
- AC-171-03: Support CTA if failed.

### US-172 — Partial refund
**As a** support executive, **I want** partial refunds, **so that** mid-policy cases are fair.  
**FR:** FR-INV-05 | **P1**  
**AC:**
- AC-172-01: Amount ≤ remaining refundable.
- AC-172-02: Ledger reflects partial.
- AC-172-03: Commission clawback per BR-SETL-03.

### US-173 — Invoice email delivery
**As a** customer, **I want** invoice emailed, **so that** I don’t hunt in-app.  
**FR:** FR-INV-02, FR-NOTIF-02 | **P1**  
**AC:**
- AC-173-01: Email after generation.
- AC-173-02: Idempotent.
- AC-173-03: Attachment or secure link.

### US-174 — Block refund on fraud freeze
**As a** platform, **I want** fraud-frozen payouts/refunds controlled, **so that** abuse is contained.  
**FR:** BR-REF-02 | **P1**  
**AC:**
- AC-174-01: Freeze flag blocks owner payouts.
- AC-174-02: Customer refunds still possible via support policy.
- AC-174-03: Case required.

### US-175 — Receipt vs tax invoice distinction
**As a** customer, **I want** clear labeling of receipt vs tax invoice, **so that** GST needs are met without confusion.  
**FR:** FR-INV-01 | **P1**  
**AC:**
- AC-175-01: UI labels document type.
- AC-175-02: Rules engine decides which artifact.
- AC-175-03: Both linkable from booking when both exist.
