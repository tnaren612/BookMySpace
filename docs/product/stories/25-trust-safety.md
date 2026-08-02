# Stories — Trust, Safety & KYC (US-280–US-287)

**Module:** TRUST | **FRs:** FR-TRUST-*

---

### US-280 — Submit owner KYC
**As an** org owner, **I want** to submit KYC documents, **so that** I can publish and get paid.  
**FR:** FR-TRUST-01 | **P0**  
**AC:**
- AC-280-01: Upload via secure media path.
- AC-280-02: Status: pending/approved/rejected.
- AC-280-03: Rejection reasons visible.

### US-281 — Listing verification badge
**As a** customer, **I want** to see verified badges, **so that** I trust listings more.  
**FR:** FR-TRUST-02 | **P0**  
**AC:**
- AC-281-01: Badge only when verified.
- AC-281-02: Shown on search/detail/SSR.
- AC-281-03: Removed if force-unpublished for fraud.

### US-282 — Report listing
**As a** customer, **I want** to report a suspicious listing, **so that** moderators investigate.  
**FR:** FR-TRUST-03 | **P1**  
**AC:**
- AC-282-01: Reason codes + optional text.
- AC-282-02: Creates case.
- AC-282-03: Ack to reporter.

### US-283 — Dispute case on booking
**As a** support executive, **I want** dispute cases linked to booking/payment, **so that** conflicts are tracked.  
**FR:** FR-TRUST-04 | **P1**  
**AC:**
- AC-283-01: Case object with timeline.
- AC-283-02: Parties + evidence refs.
- AC-283-03: Resolution states.

### US-284 — Fraud signal logging
**As a** platform, **I want** fraud signals logged, **so that** patterns emerge.  
**FR:** FR-TRUST-05 | **P1**  
**AC:**
- AC-284-01: Signals: duplicate images (later), refund spikes, KYC fails.
- AC-284-02: Queryable by admin tools.
- AC-284-03: No auto-ban without policy.

### US-285 — DPDP data export
**As a** user, **I want** data export, **so that** privacy rights are honored.  
**FR:** FR-TRUST-06, FR-AUTH-10 | **P1**  
**AC:**
- AC-285-01: Request workflow.
- AC-285-02: SLA tracked.
- AC-285-03: Secure delivery.

### US-286 — DPDP erasure
**As a** user, **I want** erasure of eligible PII, **so that** I can leave the platform.  
**FR:** FR-TRUST-06 | **P1**  
**AC:**
- AC-286-01: Legal hold checks (bookings/finance).
- AC-286-02: Soft-delete + anonymization where required.
- AC-286-03: Audit of erasure.

### US-287 — Unverified listing label
**As a** customer, **I want** clear unverified labeling when soft-launch allows, **so that** risk is disclosed.  
**FR:** BR-PUB-02 | **P1**  
**AC:**
- AC-287-01: Label visible if flag allows unverified publish.
- AC-287-02: Ranking may demote.
- AC-287-03: CTA for owners to verify.
