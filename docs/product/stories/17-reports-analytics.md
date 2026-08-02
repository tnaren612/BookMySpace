# Stories — Reports & Analytics (US-194–US-205)

**Module:** RPT | **FRs:** FR-RPT-*

---

### US-194 — Owner bookings dashboard
**As an** owner, **I want** a dashboard of bookings count and status mix, **so that** I see operational health.  
**FR:** FR-RPT-01 | **P1**  
**AC:**
- AC-194-01: Org-scoped widgets.
- AC-194-02: Date range filter.
- AC-194-03: Loading/empty states.

### US-195 — Occupancy report
**As a** hall/sports owner, **I want** occupancy %, **so that** I know fill rates.  
**FR:** FR-RPT-01 | **P1**  
**AC:**
- AC-195-01: Occupied vs available hours/days by unit.
- AC-195-02: Category-appropriate definition documented.
- AC-195-03: Export optional.

### US-196 — Revenue report INR
**As an** owner, **I want** revenue totals, **so that** I track GMV and net.  
**FR:** FR-RPT-01 | **P1**  
**AC:**
- AC-196-01: Gross vs net after commission.
- AC-196-02: Refunds deducted/shown.
- AC-196-03: INR formatting.

### US-197 — CSV export bookings
**As an** owner, **I want** CSV export, **so that** I analyze in Sheets.  
**FR:** FR-RPT-02 | **P1**  
**AC:**
- AC-197-01: Plan-gated where required.
- AC-197-02: Includes key columns; PII minimized.
- AC-197-03: Async download for large ranges.

### US-198 — Platform GMV dashboard
**As an** admin, **I want** platform GMV and bookings, **so that** leadership sees traction.  
**FR:** FR-RPT-03 | **P1**  
**AC:**
- AC-198-01: Platform role required.
- AC-198-02: City/category breakdowns (FR-RPT-05).
- AC-198-03: Not exposed to owners.

### US-199 — Funnel analytics events
**As a** PM, **I want** search→detail→hold→pay→confirm events, **so that** conversion is measurable.  
**FR:** FR-RPT-04 | **P0**  
**AC:**
- AC-199-01: Events emitted from clients with correlation ids.
- AC-199-02: Privacy-reviewed payloads.
- AC-199-03: Dashboard or warehouse sink documented.

### US-200 — Supply health metrics
**As an** admin, **I want** publish rates and verification backlog, **so that** supply quality is managed.  
**FR:** FR-RPT-03 | **P1**  
**AC:**
- AC-200-01: Counts by state.
- AC-200-02: SLA aging for pending review.
- AC-200-03: City filters.

### US-201 — Training utilization report
**As a** training institute owner, **I want** room utilization, **so that** I open/close batches.  
**FR:** FR-RPT-01, FR-OPS-04 | **P1**  
**AC:**
- AC-201-01: Per-room fill.
- AC-201-02: Recurring slot awareness.
- AC-201-03: Empty state if no data.

### US-202 — Sports yield report
**As a** sports owner, **I want** peak vs off-peak revenue, **so that** I tune pricing.  
**FR:** FR-RPT-01, FR-OPS-03 | **P1**  
**AC:**
- AC-202-01: Split by peak rules.
- AC-202-02: Hours sold metric.
- AC-202-03: Date range.

### US-203 — Report freshness target
**As an** owner, **I want** reasonably fresh dashboards, **so that** I trust numbers.  
**FR:** FR-RPT-06 | **P2**  
**AC:**
- AC-203-01: Freshness indicator.
- AC-203-02: Target ≤ 15 min for V2 ops dashboards.
- AC-203-03: Degraded banner if lagging.

### US-204 — Conversion by category
**As a** platform PM, **I want** conversion by category, **so that** we prioritize plugins.  
**FR:** FR-RPT-05 | **P1**  
**AC:**
- AC-204-01: Category breakdown.
- AC-204-02: Definitions documented (detail→confirm).
- AC-204-03: Sample size warnings.

### US-205 — Crash and API health product view
**As a** product/ops duo, **I want** crash-free and API error overview, **so that** quality gates are visible.  
**FR:** NFR-OBS-* | **P1**  
**AC:**
- AC-205-01: Links/embeds to observability dashboards.
- AC-205-02: Not a replacement for SRE tooling.
- AC-205-03: Access restricted.
