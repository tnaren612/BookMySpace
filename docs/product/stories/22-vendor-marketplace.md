# Stories — Vendor Marketplace (US-252–US-263)

**Module:** VND | **FRs:** FR-VND-* | **Release:** V2/V3

---

### US-252 — Create vendor profile
**As a** vendor, **I want** to create a vendor profile, **so that** I can offer services.  
**FR:** FR-VND-01 | **P2**  
**AC:**
- AC-252-01: Service categories selectable.
- AC-252-02: Geo coverage cities.
- AC-252-03: KYC may be required before visible.

### US-253 — Upload portfolio media
**As a** vendor, **I want** portfolio photos, **so that** customers trust my work.  
**FR:** FR-VND-01, FR-MEDIA-01 | **P2**  
**AC:**
- AC-253-01: Uses media pipeline.
- AC-253-02: Limits per plan/policy.
- AC-253-03: Public only when published.

### US-254 — Define service packages
**As a** vendor, **I want** packages with prices, **so that** quoting is standardized.  
**FR:** FR-VND-02 | **P2**  
**AC:**
- AC-254-01: Name, inclusions, INR price.
- AC-254-02: Active/inactive.
- AC-254-03: Validation.

### US-255 — Discover vendors
**As a** customer, **I want** to discover vendors by city/category, **so that** I add décor/catering.  
**FR:** FR-VND-03 | **P2**  
**AC:**
- AC-255-01: Search/filter published vendors.
- AC-255-02: Ratings shown.
- AC-255-03: Empty state.

### US-256 — Vendor recommendations on venue booking
**As a** customer booking a hall, **I want** recommended vendors, **so that** planning is one-stop.  
**FR:** FR-VND-03/04 | **P2**  
**AC:**
- AC-256-01: Recommendations by city/category.
- AC-256-02: Opt-out skip.
- AC-256-03: Does not block venue payment.

### US-257 — Send quote on booking
**As a** vendor, **I want** to send a quote attached to a venue booking, **so that** the customer can accept.  
**FR:** FR-VND-04 | **P2**  
**AC:**
- AC-257-01: Quote links booking id.
- AC-257-02: Expiry on quote.
- AC-257-03: Customer notified.

### US-258 — Accept vendor quote & pay
**As a** customer, **I want** to accept and pay a vendor quote, **so that** the service is confirmed.  
**FR:** FR-VND-04, FR-PAY-01 | **P2**  
**AC:**
- AC-258-01: Payment via Razorpay isolation rules.
- AC-258-02: Commission recorded (FR-VND-07).
- AC-258-03: Idempotent.

### US-259 — Vendor calendar conflict check
**As a** vendor, **I want** conflict detection, **so that** I don’t double-book jobs.  
**FR:** FR-VND-05 | **P2**  
**AC:**
- AC-259-01: Overlap rejected.
- AC-259-02: Calendar day/week view.
- AC-259-03: Manual blocks supported.

### US-260 — Complete vendor job
**As a** vendor, **I want** to mark job complete, **so that** review/payout can proceed.  
**FR:** FR-VND-06 | **P2**  
**AC:**
- AC-260-01: Completion state.
- AC-260-02: Customer review unlocked.
- AC-260-03: Earnings ledger entry.

### US-261 — Vendor payouts view
**As a** vendor owner, **I want** earnings view, **so that** I track money.  
**FR:** FR-VND-07, FR-SETL-01 | **P2**  
**AC:**
- AC-261-01: Gross/fee/net.
- AC-261-02: KYC gate.
- AC-261-03: Export later optional.

### US-262 — Owner invites preferred vendors
**As a** hall owner, **I want** preferred vendor list, **so that** my customers see trusted partners.  
**FR:** FR-VND-03 | **P2**  
**AC:**
- AC-262-01: Org preferred vendors.
- AC-262-02: Shown with priority on that venue.
- AC-262-03: Vendor must accept link.

### US-263 — Vendor plan entitlement
**As a** Starter owner, **I want** clear messaging if vendor marketplace is Professional-only, **so that** I can upgrade.  
**FR:** BR-SUB-01 | **P2**  
**AC:**
- AC-263-01: Gate with upgrade CTA.
- AC-263-02: Browse may be allowed read-only — document choice (default: gated write).
- AC-263-03: Entitlement checked server-side.
