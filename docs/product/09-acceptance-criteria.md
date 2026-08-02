# 09 — Acceptance Criteria Index

**Document ID:** PRD-09  

Acceptance criteria are **colocated with each user story** in [`stories/*.md`](stories/) as `AC-{story}-{nn}`.

## QA usage

1. Pick sprint stories from [12-product-backlog.md](12-product-backlog.md).  
2. Open the module file for those `US-xxx` IDs.  
3. Execute every `AC-*-*` as a test case (manual or automated).  
4. Trace defects to `FR-*` / `BR-*` / `NFR-*`.  

## AC quality bar

Each story should have **≥2 ACs**; critical booking/payment stories have **≥3** including negative/idempotency paths.

## Coverage map (by risk)

| Risk area | Must-pass story examples |
|-----------|--------------------------|
| Double booking | US-085, US-091–096, US-103 |
| Payments | US-111–120, US-123, US-125 |
| Tenancy | US-026, US-018, org venue stories |
| Auth | US-003–005, US-008 |
| Trust | US-242, US-246–247, US-280–281 |
| SEO | US-272–278 |

## Traceability

`BG → FR → US → AC` — do not ship a `US` without ACs; do not close a sprint story unless all ACs pass or are explicitly waived with founder/PM sign-off.
