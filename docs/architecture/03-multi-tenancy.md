# Multi-Tenancy Model

**Status:** Accepted  
**Related:** ADR-001, Security Checklist

---

## 1. Problem

BookMySpace is both:

1. A **marketplace** (customers book across many owners)
2. An **owner SaaS** (org staff manage venues, calendars, payouts)

A naive “one tenant = one customer” model fails. A naive “schema per owner” model makes marketplace search painful.

---

## 2. Decision

Use **row-level tenancy on Organization** for owner-side data, and **platform-scoped identity** for customers.

```
Platform (BookMySpace)
 ├── Users (customers, owner users, admins)     # global identity
 ├── Organizations (owner businesses)           # tenant boundary
 │    ├── Memberships (user ↔ org + role)
 │    ├── Venues
 │    ├── Inventory Units
 │    ├── Pricing Policies
 │    └── Payout Profiles
 └── Bookings (reference org + customer user)  # marketplace join entity
```

### Tenant key

- Owner APIs: `organization_id` required on every query (resolved from membership, **never** trusted from client alone).
- Marketplace APIs: filter by `status=PUBLISHED` and public fields only.
- Admin APIs: platform role required; may cross orgs with audit.

---

## 3. Isolation Levels

| Layer | Mechanism |
|-------|-----------|
| API | AuthZ middleware checks org membership + permission |
| Application | `TenantContext` (org id) set from security principal |
| Persistence | All org-owned tables include `organization_id`; repositories always filter |
| DB (later) | Optional Postgres RLS policies as defense-in-depth |
| Cache | Redis keys prefixed `org:{id}:...` or `user:{id}:...` |
| Files | S3 key prefix `org/{organizationId}/...` |

---

## 4. Roles (RBAC Sketch)

### Platform roles

- `PLATFORM_SUPER_ADMIN`
- `PLATFORM_SUPPORT`
- `PLATFORM_MODERATOR`

### Organization roles

- `ORG_OWNER`
- `ORG_MANAGER`
- `ORG_STAFF`
- `ORG_ACCOUNTANT` (later)

### Customer

- Authenticated customer (no org required)
- Guest checkout: **deferred** (auth-first for MVP simplicity)

Permissions are fine-grained strings, e.g. `venue:write`, `booking:cancel`, `payout:read`.

---

## 5. Rules

1. Never accept `organizationId` from the client as authority — derive from token membership or admin override.
2. Every org-owned row must have `organization_id` NOT NULL.
3. Integration tests must include **cross-tenant access denial** cases.
4. Logs must include `organizationId` / `userId` but never secrets or full card data.
5. Soft-delete preferred for venues/bookings; hard delete only via DPDP erasure workflows.

---

## 6. Evolution

| Scale | Strategy |
|-------|----------|
| Early | Shared schema + `organization_id` |
| Growth | Postgres RLS |
| Enterprise contracts | Dedicated schema/DB for large orgs (rare; avoid early) |
