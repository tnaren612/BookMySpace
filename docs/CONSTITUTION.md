# BookMySpace — Project Constitution

| Field | Value |
|-------|--------|
| **Document** | `docs/CONSTITUTION.md` |
| **Status** | Accepted with architecture direction (2026-08-02) |
| **Authority** | Binding engineering governance; referenced by `docs/ARCHITECTURE.md` |
| **Audience** | Founders, engineers, AI coding agents |

---

## Preamble

BookMySpace is India's Venue Commerce Platform. This Constitution defines non-negotiable rules for how we build. Architecture details live in `docs/ARCHITECTURE.md`. Product law lives in `docs/product/`. When documents conflict on **stack or runtime**, Architecture wins once Accepted. When they conflict on **business rules**, Product wins.

---

## Article I — Correctness First

1. Booking and payment correctness outrank delivery speed and clever abstractions.
2. Confirmed overlapping bookings for the same inventory unit must be impossible for prepaid instant mode.
3. Client-reported payment success is never authoritative; webhook + server verification is.
4. Idempotency keys are required on booking confirm and payment initiate/confirm paths.

## Article II — Simplicity & Modularity

1. Start as a **NestJS modular monolith**; extract services only when pain is proven.
2. Preserve **category capability model** — do not fork the codebase per venue type.
3. Prefer boring primitives (Postgres, REST, outbox + BullMQ) over day-one Kafka/Kubernetes.
4. CQRS is forbidden by default; allowlist only proven hot paths.

## Article III — Security & Tenancy

1. Authenticate via **Supabase Auth**; authorize in Nest with **permission-based RBAC**.
2. Never trust client-supplied `organization_id` as authority.
3. Secrets never commit to git; service-role keys never ship to clients.
4. Cross-tenant denial tests are mandatory for org-scoped APIs.
5. AI features are assistive only; they never auto-publish or auto-ban alone.

## Article IV — Client Surfaces

1. One Flutter app (`apps/app`) for Android, iOS, and Web transactional UX (role-aware).
2. **Next.js** owns crawlable marketing and SEO public pages (`apps/website`).
3. Flutter Web is not the SEO strategy.
4. Primary tasks aim for ≤ 3 taps where domain rules allow.
5. Accessibility, light/dark themes, and production quality are mandatory—not optional polish.

## Article V — Contracts & Change

1. OpenAPI under `packages/api_contracts` is the HTTP contract source of truth.
2. URL API versioning (`/api/v1`); breaking changes require a new major version.
3. Database migrations are expand → deploy → contract; prod rolls forward only.
4. Feature flags gate risky rollouts (payments, booking modes, categories, AI).

## Article VI — AI-Assisted Development

1. Module boundaries, Prisma schema, and OpenAPI must remain machine-legible.
2. Agents and humans follow the same Constitution; no “temporary” tenancy shortcuts.
3. Prefer explicit ports for Supabase, Storage, Razorpay, FCM, Maps, and AI providers.

## Article VII — Amendment

Amendments require founder approval and an update to this file plus `docs/ARCHITECTURE.md` when architecture is affected. Implementation must not begin on amendments until documented.

---

*Referenced by `docs/ARCHITECTURE.md` § Project Constitution.*
