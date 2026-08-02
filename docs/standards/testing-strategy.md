# Testing Strategy

## Goals

- Prevent double-booking and tenancy leaks with automated tests.
- Keep CI fast via pyramid shape.
- Require tests as part of “done”.

## Test Pyramid

```
        ╱╲
       ╱E2E╲          few, critical journeys
      ╱──────╲
     ╱Integr. ╲       API + DB + Redis
    ╱──────────╲
   ╱ Unit tests ╲     majority
  ╱──────────────╲
```

| Layer | Backend | Flutter | Website |
|-------|---------|---------|---------|
| Unit | Domain + use cases (JUnit 5) | Notifiers, mappers, validators | Utils |
| Integration | `@SpringBootTest` + Testcontainers (Postgres, Redis) | Repository + Dio mocked / wiremock | API contract smoke |
| E2E | Playwright/Rest Assured critical flows | `integration_test` on CI device/emulator | Lighthouse + crawl smoke |
| Contract | OpenAPI spectesting | Golden + consumer stubs | — |
| Architecture | ArchUnit package rules | Import barrel lint (optional) | — |

## Mandatory Coverage Areas

1. **Auth:** login, refresh rotation, reuse detection
2. **Tenancy:** user from org A cannot read org B data
3. **Booking:** hold expiry, concurrent hold conflict, idempotent confirm
4. **Payments:** webhook replay, signature failure, double capture
5. **Notifications:** idempotent send on duplicate events
6. **Search projection:** venue publish/unpublish updates document

## Definition of Done (Feature)

- [ ] Unit tests for domain rules
- [ ] Integration test for API happy path + primary failure path
- [ ] Tenancy denial test if org-scoped
- [ ] Updated OpenAPI if public API changed
- [ ] No flaky sleeps; use Awaitility / fake clocks

## Performance / Load (Later Phases)

- k6 or Gatling scripts for search + hold/confirm
- Run on staging before major releases

## What We Do Not Do

- 100% line coverage mandates (prefer critical-path confidence)
- UI screenshot tests for every screen early (design system goldens first)
- Testing third-party SDKs themselves
