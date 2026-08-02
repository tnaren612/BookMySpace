# Stories — Organization & Tenancy (US-016–US-027)

**Module:** ORG  
**FRs:** FR-ORG-*

---

### US-016 — Create organization
**As a** venue entrepreneur, **I want** to create an Organization, **so that** I can manage venues as a business tenant.  
**FR:** FR-ORG-01 | **P0**  
**AC:**
- AC-016-01: Creates org with name + creator as `ORG_OWNER`.
- AC-016-02: `organization_id` generated server-side.
- AC-016-03: Creator membership persisted.

### US-017 — View my organizations
**As an** owner user, **I want** to list orgs I belong to, **so that** I can switch context.  
**FR:** FR-ORG-02 | **P0**  
**AC:**
- AC-017-01: Returns only memberships for `sub`.
- AC-017-02: Includes role per org.

### US-018 — Switch active org context
**As a** multi-org user, **I want** to select active org, **so that** owner APIs apply to the right tenant.  
**FR:** FR-ORG-05 | **P0**  
**AC:**
- AC-018-01: Active org must be a membership org.
- AC-018-02: API calls without membership denied.
- AC-018-03: Client-supplied org id alone is insufficient (BR-TEN-01).

### US-019 — Update org profile
**As an** org owner, **I want** to update legal name, address, GSTIN, **so that** invoices and trust are accurate.  
**FR:** FR-ORG-06 | **P0**  
**AC:**
- AC-019-01: Owner can update allowed fields.
- AC-019-02: Manager limited fields per RBAC.
- AC-019-03: GSTIN format validated when provided.

### US-020 — Invite member
**As an** org owner, **I want** to invite staff by email/phone, **so that** my team can operate the calendar.  
**FR:** FR-ORG-03 | **P0**  
**AC:**
- AC-020-01: Invite specifies role ≤ inviter authority.
- AC-020-02: Invitee receives notification.
- AC-020-03: Pending invites visible to owner.

### US-021 — Accept invite
**As an** invited user, **I want** to accept membership, **so that** I gain org permissions.  
**FR:** FR-ORG-03 | **P0**  
**AC:**
- AC-021-01: Accept creates membership.
- AC-021-02: Expired invite fails clearly.
- AC-021-03: Already-member invite is idempotent/no-op.

### US-022 — Decline invite
**As an** invited user, **I want** to decline, **so that** I am not added.  
**FR:** FR-ORG-03 | **P0**  
**AC:**
- AC-022-01: Status becomes declined.
- AC-022-02: No membership row with active access.

### US-023 — Remove member
**As an** org owner, **I want** to remove staff, **so that** ex-employees lose access.  
**FR:** FR-ORG-04 | **P1**  
**AC:**
- AC-023-01: Removed user’s org-scoped tokens/permissions fail.
- AC-023-02: Cannot remove last owner without transfer.
- AC-023-03: Action audited.

### US-024 — Change member role
**As an** org owner, **I want** to change a member’s role, **so that** responsibilities match reality.  
**FR:** FR-ORG-02 | **P1**  
**AC:**
- AC-024-01: Role updates enforce RBAC matrix.
- AC-024-02: Demoting self blocked if last owner.

### US-025 — Transfer ownership
**As an** org owner, **I want** to transfer ownership, **so that** business continuity is preserved.  
**FR:** FR-ORG-04 | **P1**  
**AC:**
- AC-025-01: Transfer requires confirmation challenge.
- AC-025-02: New owner must already be member or accept invite first.
- AC-025-03: Audit log records both parties.

### US-026 — Cross-tenant denial
**As a** platform, **I want** cross-org reads/writes denied, **so that** tenant isolation holds.  
**FR:** FR-ORG-05 | **P0**  
**AC:**
- AC-026-01: Integration tests prove User A cannot read Org B venues.
- AC-026-02: Guessable IDs still denied.
- AC-026-03: Admin access separate and audited.

### US-027 — Soft-delete organization
**As an** org owner, **I want** to close my org, **so that** it leaves the marketplace.  
**FR:** FR-ORG-07 | **P1**  
**AC:**
- AC-027-01: Blocked if future CONFIRMED bookings exist (must cancel/complete).
- AC-027-02: Venues unpublished on delete.
- AC-027-03: Historical bookings retained for compliance.
