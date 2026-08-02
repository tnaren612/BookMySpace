# 04 — Non-Functional Requirements

**Document ID:** PRD-04  
**ID format:** `NFR-{AREA}-{nn}`  
**Related:** ADR-008 Observability, security checklist, phase roadmap SLOs

---

## 1. Summary benchmarks (targets)

| Area | MVP / V1 target | Notes |
|------|-----------------|-------|
| API p95 (read) | ≤ 300 ms (ex-network edge) staging seed | Search may be ≤ 500 ms early |
| API p95 (hold/confirm) | ≤ 500 ms | Under contention still correct |
| Booking correctness | 0 silent double confirms | Hard gate |
| Crash-free sessions | ≥ 99.5% | Flutter |
| Availability (API) | 99.5% monthly MVP; 99.9% later | Single region OK early |
| SSR LCP | ≤ 2.5 s on 4G mid-tier | Core Web Vitals |
| Accessibility | WCAG 2.2 AA for primary flows | Auth, search, book, pay |

---

## 2. Performance

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-PERF-01 | Search list p95 | ≤ 500 ms on ≤100k venue docs (FTS) |
| NFR-PERF-02 | Venue detail p95 | ≤ 300 ms |
| NFR-PERF-03 | Hold create p95 | ≤ 400 ms |
| NFR-PERF-04 | Payment order create p95 | ≤ 600 ms incl. Razorpay RTT variance |
| NFR-PERF-05 | App cold start to interactive shell | ≤ 3 s mid-tier Android |
| NFR-PERF-06 | Image gallery: progressive load; cover ≤ 200 KB compressed guideline | CDN |
| NFR-PERF-07 | Calendar week fetch p95 | ≤ 400 ms for 7-day window |

---

## 3. Scalability

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-SCALE-01 | Support 0–10k MAU on single API + Postgres + Redis | Vertical scale |
| NFR-SCALE-02 | Design for 10k–500k with read replicas + extract notify/payment | No client rewrite |
| NFR-SCALE-03 | Hold endpoint sustains concurrent conflicts correctly | Load smoke each release |
| NFR-SCALE-04 | Outbox lag p95 | ≤ 30 s under normal load |
| NFR-SCALE-05 | Redis hold keys TTL enforced | Exact product TTL config |

---

## 4. Reliability & correctness

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-REL-01 | Idempotent booking confirm & payment webhook | Replay-safe |
| NFR-REL-02 | No booking CONFIRMED without payment truth (prepaid modes) | 100% |
| NFR-REL-03 | RPO | ≤ 1 hour MVP backups; tighten later |
| NFR-REL-04 | RTO | ≤ 4 hours MVP; runbook drill Phase 20 |
| NFR-REL-05 | Reconciliation job detects ledger drift | Daily + alert |
| NFR-REL-06 | Notification at-least-once with idempotent handlers | No duplicate user-visible spam on retry |

---

## 5. Security

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-SEC-01 | TLS everywhere; HSTS on public sites | Required |
| NFR-SEC-02 | Short-lived JWT + refresh rotation + reuse revocation | Per ADR-004 |
| NFR-SEC-03 | Cross-tenant access denied | Automated tests each PR touching tenancy |
| NFR-SEC-04 | Rate limits on auth, hold, search | Redis token bucket |
| NFR-SEC-05 | Secrets never in repo; env templates names-only | Checklist |
| NFR-SEC-06 | Razorpay webhook signature verified | 100% |
| NFR-SEC-07 | No PAN storage; minimize PII in logs | Checklist |
| NFR-SEC-08 | Admin actions audited | 100% of mutating admin APIs |
| NFR-SEC-09 | Dependency scanning in CI | Block critical CVEs policy |
| NFR-SEC-10 | Pen-test before major public launch | Phase 20 gate |

---

## 6. Privacy & compliance (India)

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-PRIV-01 | DPDP-oriented consent for account & marketing | Recorded |
| NFR-PRIV-02 | Data export / delete request workflow | SLA ≤ 30 days or legal requirement |
| NFR-PRIV-03 | GST invoice fields when tax applicable | Configurable |
| NFR-PRIV-04 | Retention policies documented per data class | Doc + job hooks |
| NFR-PRIV-05 | WhatsApp/SMS only with template + opt-out respect | 100% opt-out |

---

## 7. Usability & accessibility

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-UX-01 | Primary book path ≤ 3 taps where domain allows | UX review |
| NFR-UX-02 | Touch targets ≥ 48×48 dp | Design system |
| NFR-UX-03 | Screen reader labels on auth + book + pay | Manual + automated a11y |
| NFR-UX-04 | Color contrast AA | Tokens |
| NFR-UX-05 | Empty/loading/error for every major screen | Design QA |
| NFR-UX-06 | Light/dark themes via shared tokens | Golden tests core components |

---

## 8. Localization & devices

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-I18N-01 | EN UI MVP; INR currency formatting | Required |
| NFR-I18N-02 | Asia/Kolkata default display TZ | Required |
| NFR-I18N-03 | HI language pack after core booking | V2+ |
| NFR-I18N-04 | Support Android & iOS last 2 major versions | Matrix |
| NFR-I18N-05 | Responsive layouts: mobile, tablet, desktop web app | Breakpoints in UX doc |

---

## 9. Observability

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-OBS-01 | Structured JSON logs with correlation id | 100% request paths |
| NFR-OBS-02 | OpenTelemetry traces on booking/payment | Critical paths |
| NFR-OBS-03 | Prometheus metrics: latency, errors, holds, payments | Dashboards |
| NFR-OBS-04 | Alert on payment webhook failure rate / outbox lag | On-call |
| NFR-OBS-05 | Client analytics events for funnel | Privacy-reviewed |

---

## 10. Maintainability & delivery

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-MAINT-01 | Modular package boundaries enforced (ArchUnit) | CI |
| NFR-MAINT-02 | OpenAPI `/api/v1` contracts | Published |
| NFR-MAINT-03 | Test strategy per standards doc | Coverage gates negotiated |
| NFR-MAINT-04 | Feature flags for category & booking modes | Required |
| NFR-MAINT-05 | Docs/ADR updated when decisions change | Process |

---

## 11. Supportability

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-SUPP-01 | Support can find booking in ≤ 60 s with id/phone hash | Admin UX |
| NFR-SUPP-02 | Runbooks for booking, payment, auth incidents | Before public launch |
| NFR-SUPP-03 | Status page capability (manual OK early) | V1 |

---

## 12. Cost guardrails

| ID | Requirement | Benchmark |
|----|-------------|-----------|
| NFR-COST-01 | WhatsApp/SMS monthly budget alerts | Configurable |
| NFR-COST-02 | Media storage lifecycle / size limits per plan | Entitlements |
| NFR-COST-03 | Avoid Kafka/OpenSearch until metrics justify | ADR gates |
