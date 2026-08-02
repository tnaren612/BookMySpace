# Stories — Settlements & Payouts (US-176–US-183)

**Module:** SETL | **FRs:** FR-SETL-*

---

### US-176 — Earnings ledger view
**As an** owner, **I want** to see gross/fees/net earnings, **so that** I trust the platform with money.  
**FR:** FR-SETL-01 | **P1**  
**AC:**
- AC-176-01: Shows booking-linked ledger lines in INR.
- AC-176-02: Commission visible (BR-SETL-01).
- AC-176-03: Org-scoped.

### US-177 — Payout profile setup
**As an** owner, **I want** to add bank/UPI payout details, **so that** I can get paid.  
**FR:** FR-SETL-02 | **P1**  
**AC:**
- AC-177-01: Stores payout refs (no unnecessary secrets in logs).
- AC-177-02: Verification workflow status shown.
- AC-177-03: Only ORG_OWNER (or entitled role) can write.

### US-178 — Payout withheld without KYC
**As a** platform, **I want** to withhold payouts without KYC, **so that** risk is reduced.  
**FR:** BR-SETL-02 | **P1**  
**AC:**
- AC-178-01: Incomplete KYC → payout blocked with CTA.
- AC-178-02: Earnings still visible as pending.
- AC-178-03: Admin can see freeze reason.

### US-179 — Settlement export
**As an** accountant, **I want** CSV/PDF settlement export, **so that** I book accounts.  
**FR:** FR-SETL-03 | **P1**  
**AC:**
- AC-179-01: Date range export.
- AC-179-02: Includes fees and refunds.
- AC-179-03: Plan-gated if required.

### US-180 — Settlement process documentation hook
**As an** owner, **I want** to understand payout schedule, **so that** I plan cashflow.  
**FR:** FR-SETL-05 | **P1**  
**AC:**
- AC-180-01: UI shows next payout estimate / schedule copy.
- AC-180-02: Links to help article.
- AC-180-03: Matches finance runbook (Route vs manual).

### US-181 — Refund clawback on commission
**As a** platform, **I want** commission clawback on refunds, **so that** economics stay fair.  
**FR:** BR-SETL-03 | **P1**  
**AC:**
- AC-181-01: Ledger adjusts net.
- AC-181-02: Visible on earnings detail.
- AC-181-03: Reconciles with payment refunds.

### US-182 — Accountant read access
**As an** org accountant, **I want** read-only financial views, **so that** I don’t need owner login.  
**FR:** FR-SETL-06 | **P2**  
**AC:**
- AC-182-01: Role can read payouts/invoices/reports.
- AC-182-02: Cannot publish venues or change pricing.
- AC-182-03: Invite flow supports accountant role.

### US-183 — Payout failure alert
**As an** owner, **I want** alerts if payout fails, **so that** I fix bank details quickly.  
**FR:** FR-SETL-02, FR-NOTIF-07 | **P1**  
**AC:**
- AC-183-01: Notify on failure.
- AC-183-02: Status in payout profile.
- AC-183-03: Support can see failure code (non-sensitive).
