# Stories — Admin & Moderation (US-238–US-251)

**Module:** ADM | **FRs:** FR-ADM-*

---

### US-238 — Admin login with platform role
**As an** administrator, **I want** admin app access only with platform roles, **so that** internals stay secure.  
**FR:** FR-ADM-01 | **P0**  
**AC:**
- AC-238-01: Non-platform users denied.
- AC-238-02: JWT RBAC enforced.
- AC-238-03: Failed attempts rate-limited.

### US-239 — Lookup organization
**As a** support/admin, **I want** to look up orgs, **so that** I can assist owners.  
**FR:** FR-ADM-02 | **P0**  
**AC:**
- AC-239-01: Search by name/id/GSTIN.
- AC-239-02: Shows memberships summary.
- AC-239-03: Audited access.

### US-240 — Lookup user
**As a** support executive, **I want** to look up users, **so that** I verify account issues.  
**FR:** FR-ADM-02 | **P0**  
**AC:**
- AC-240-01: Search email/phone hash/id.
- AC-240-02: Minimal PII display.
- AC-240-03: Links to bookings.

### US-241 — Lookup venue
**As a** moderator, **I want** to open any venue, **so that** I can moderate content.  
**FR:** FR-ADM-02 | **P0**  
**AC:**
- AC-241-01: Cross-org read with platform role.
- AC-241-02: Shows state + media.
- AC-241-03: Audit.

### US-242 — Force unpublish
**As a** moderator, **I want** to force-unpublish a venue, **so that** fraudulent listings disappear.  
**FR:** FR-ADM-03 | **P0**  
**AC:**
- AC-242-01: Reason code required (BR-ADM-01).
- AC-242-02: Removed from search.
- AC-242-03: Owner notified.

### US-243 — Audit log viewer
**As a** super admin, **I want** to view audit logs, **so that** actions are accountable.  
**FR:** FR-ADM-04 | **P0**  
**AC:**
- AC-243-01: Filter by actor/resource/date.
- AC-243-02: Immutable display.
- AC-243-03: Export limited.

### US-244 — Feature flag management
**As an** admin, **I want** to toggle feature flags, **so that** we roll out categories safely.  
**FR:** FR-ADM-05 | **P1**  
**AC:**
- AC-244-01: Toggle booking modes/categories.
- AC-244-02: Changes audited.
- AC-244-03: Optional percentage rollout later.

### US-245 — Taxonomy management
**As an** admin, **I want** to manage categories/amenities, **so that** catalog stays coherent.  
**FR:** FR-ADM-06 | **P1**  
**AC:**
- AC-245-01: CRUD with care for in-use categories.
- AC-245-02: Soft-disable rather than hard delete when referenced.
- AC-245-03: Audited.

### US-246 — Verification queue
**As a** moderator, **I want** a verification queue, **so that** I approve trustworthy listings.  
**FR:** FR-TRUST-02 | **P0**  
**AC:**
- AC-246-01: Lists PENDING_REVIEW.
- AC-246-02: Approve/reject with reason.
- AC-246-03: Badge granted on approve.

### US-247 — KYC review
**As a** moderator, **I want** to review owner KYC, **so that** payouts can unlock.  
**FR:** FR-TRUST-01 | **P0**  
**AC:**
- AC-247-01: View submitted docs metadata securely.
- AC-247-02: Approve/reject.
- AC-247-03: Status reflected to owner.

### US-248 — Impersonation forbidden
**As a** platform, **I want** impersonation disabled by default, **so that** account takeover risk drops.  
**FR:** FR-ADM-07 | **P0**  
**AC:**
- AC-248-01: No impersonate API in MVP/V1.
- AC-248-02: If ever added, Super Admin + dual control + audit — separate ADR.
- AC-248-03: Tests ensure absence.

### US-249 — Freeze org for fraud
**As a** super admin, **I want** to freeze an org, **so that** payouts and publishes stop.  
**FR:** BR-REF-02 | **P1**  
**AC:**
- AC-249-01: Freeze flag blocks publish/payouts.
- AC-249-02: Existing CONFIRMED bookings handled per case policy.
- AC-249-03: Full audit.

### US-250 — Platform config
**As an** admin, **I want** to edit platform config (hold TTL defaults), **so that** ops can tune without code.  
**FR:** FR-ADM-05 | **P1**  
**AC:**
- AC-250-01: Whitelisted config keys only.
- AC-250-02: Validation ranges.
- AC-250-03: Audited.

### US-251 — Review moderation queue
**As a** moderator, **I want** reported reviews queue, **so that** I clear abuse.  
**FR:** FR-REV-06 | **P1**  
**AC:**
- AC-251-01: Queue of reports.
- AC-251-02: Hide/keep actions.
- AC-251-03: Notify reporter optionally.
