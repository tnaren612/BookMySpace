# Stories — Subscriptions (US-206–US-217)

**Module:** SUB | **FRs:** FR-SUB-*

---

### US-206 — View current plan
**As an** owner, **I want** to see my plan and entitlements, **so that** I know my limits.  
**FR:** FR-SUB-01/02 | **P0**  
**AC:**
- AC-206-01: Shows Free/Starter/Professional/Enterprise.
- AC-206-02: Lists caps (venues, seats, credits).
- AC-206-03: Usage meters.

### US-207 — Upgrade to Starter
**As a** Free owner, **I want** to upgrade to Starter, **so that** I unlock more venues/staff.  
**FR:** FR-SUB-03 | **P1**  
**AC:**
- AC-207-01: Checkout via Razorpay subscription/invoice.
- AC-207-02: Entitlements expand per BR-SUB-02.
- AC-207-03: Failure leaves prior plan intact.

### US-208 — Upgrade to Professional
**As a** Starter owner, **I want** Professional, **so that** I get CRM/featured credits/vendor access.  
**FR:** FR-SUB-03 | **P1**  
**AC:**
- AC-208-01: Proration or full-cycle charge per policy.
- AC-208-02: Features unlock immediately on success.
- AC-208-03: Invoice generated for SaaS fee.

### US-209 — Request Enterprise
**As a** multi-venue brand, **I want** to request Enterprise, **so that** sales can contract me.  
**FR:** FR-SUB-06 | **P2**  
**AC:**
- AC-209-01: Creates sales lead/task.
- AC-209-02: Shows “contact sales” state.
- AC-209-03: No self-serve charge required.

### US-210 — Downgrade plan
**As an** owner, **I want** to downgrade, **so that** I reduce cost in off-season.  
**FR:** FR-SUB-03, BR-SUB-03 | **P1**  
**AC:**
- AC-210-01: Effective period-end by default.
- AC-210-02: Blocks if over new caps until remediated.
- AC-210-03: Confirms impact UI.

### US-211 — Entitlement gate on venue create
**As a** Free owner, **I want** a clear upgrade prompt when creating a 2nd venue, **so that** I understand limits.  
**FR:** FR-SUB-02 | **P0**  
**AC:**
- AC-211-01: API returns entitlement error code.
- AC-211-02: UI shows upgrade CTA.
- AC-211-03: No partial venue created.

### US-212 — Entitlement gate on staff invite
**As an** owner, **I want** seat limits enforced, **so that** billing is fair.  
**FR:** FR-SUB-02 | **P0**  
**AC:**
- AC-212-01: Invite blocked at cap.
- AC-212-02: Upgrade CTA.
- AC-212-03: Pending invites count toward cap (document yes/no — default yes).

### US-213 — Billing history
**As an** owner, **I want** SaaS billing history, **so that** I track subscriptions.  
**FR:** FR-SUB-04 | **P1**  
**AC:**
- AC-213-01: Lists invoices/charges.
- AC-213-02: Download receipts.
- AC-213-03: Distinct from marketplace booking invoices.

### US-214 — Failed payment dunning
**As an** owner, **I want** grace period messaging, **so that** I can fix payment without sudden lockout.  
**FR:** FR-SUB-05, BR-SUB-04 | **P1**  
**AC:**
- AC-214-01: 7-day grace default.
- AC-214-02: Notifications on failure.
- AC-214-03: After grace, freeze publish/featured.

### US-215 — Cancel subscription
**As an** owner, **I want** to cancel paid plan, **so that** I revert to Free at period end.  
**FR:** BR-SUB-04 | **P1**  
**AC:**
- AC-215-01: Remains paid until period end.
- AC-215-02: Then Free entitlements.
- AC-215-03: Data retained per policy.

### US-216 — Trial Professional
**As a** new owner, **I want** a trial, **so that** I experience value before paying.  
**FR:** FR-SUB-03 | **P1**  
**AC:**
- AC-216-01: Feature-flagged 14-day trial.
- AC-216-02: Ends → Free or convert.
- AC-216-03: One trial per org.

### US-217 — Featured credits meter
**As a** Professional owner, **I want** to see featured credits remaining, **so that** I plan boosts.  
**FR:** FR-SUB-02, FR-COUP-05 | **P1**  
**AC:**
- AC-217-01: Shows monthly remaining.
- AC-217-02: Reset policy documented.
- AC-217-03: Consume on boost start.
