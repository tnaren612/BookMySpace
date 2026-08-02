# Coding Standards

Applies to all BookMySpace code. Language-specific addenda follow the shared rules.

---

## Shared Rules

1. **Production quality only** — no placeholder TODOs that block flows; no fake implementations in `main`.
2. **No duplicate logic** — extract to `shared` / packages after the second use.
3. **Fail fast, fail clearly** — validate at boundaries; use typed errors.
4. **Small PRs** — one concern per PR when possible.
5. **Tests travel with code** — feature PR without tests is incomplete (see testing strategy).
6. **No secrets in source** — use env / secret manager.
7. **Comments explain why**, not what — prefer clear names over comments.
8. **Accessibility is not optional** — semantics, contrast, targets ≥ 48dp.
9. **Dark and light mode** — every UI surface supports both.
10. **Feature flags for risky rollouts** — especially payments, categories, booking modes.

---

## Java / Spring Boot

- Java 21; prefer records for DTOs/value objects where immutable.
- Package by bounded context, then layer (`api`, `application`, `domain`, `infrastructure`).
- Constructors for injection; avoid field injection.
- Controllers are thin; no business rules in controllers.
- Domain entities do not depend on Spring/JPA annotations when avoidable (use persistence models + mappers if coupling hurts). Pragmatic exception: early MVP may use JPA on domain with discipline — document in package README.
- Use `Optional` only as return type, never fields/parameters.
- Checked exceptions avoided; use domain exceptions mapped to Problem Details.
- Flyway/Liquibase for all schema changes; never auto-ddl in prod.
- ArchUnit: forbid `*.infrastructure` → other context `*.domain` leaks as agreed.

**Formatting:** Spotless / google-java-format (decide in Phase 1 scaffold).  
**Static analysis:** NullAway or SpotBugs + Error Prone recommended.

---

## Dart / Flutter

- `flutter_lints` / `very_good_analysis` (choose one; enforce in CI).
- Features own their presentation/state; `core` has no feature imports.
- Riverpod providers are the DI boundary.
- Freezed for immutable states & DTOs; avoid `dynamic`.
- Dio via a single client factory; interceptors for auth & correlation.
- Widgets stay dumb when possible; logic in notifiers/controllers.
- Prefer `const` constructors; avoid unnecessary rebuilds (profile, don’t premature-optimize).
- Golden tests for design system components.
- No business secrets or API keys in the client — use backend.

---

## SQL / PostgreSQL

- Snake_case tables/columns.
- Every table: `id`, `created_at`, `updated_at` (unless immutable event table).
- Org-owned tables: `organization_id` NOT NULL + index.
- Migrations are forward-only in prod; roll-forward fixes.
- Explicit indexes for FK and common filters; justify in migration comment.

---

## API

- REST + JSON for public clients.
- RFC 7807 Problem Details for errors.
- Pagination: cursor-based for feeds; offset allowed for admin small lists.
- Money: integer minor units + currency code (`INR` paise).
- Timestamps: ISO-8601 UTC; convert in clients.

---

## Code Review Bar

Reviewers check:

- Correctness & tenancy isolation
- Tests
- Naming & structure vs standards
- Security checklist items touched by the PR
- No unexplained complexity (especially CQRS/events)
