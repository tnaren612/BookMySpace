# Stories — Search & Discovery (US-054–US-068)

**Module:** SEARCH | **FRs:** FR-SEARCH-* | **Tech:** Postgres FTS first (ADR-007)

---

### US-054 — Text by text
**As a** customer, **I want** to search venues by keywords, **so that** I find relevant spaces quickly.  
**FR:** FR-SEARCH-01 | **P0**  
**AC:**
- AC-054-01: Query uses FTS projection.
- AC-054-02: Only PUBLISHED venues returned.
- AC-054-03: Empty query with filters still works.

### US-055 — Filter by city
**As a** customer, **I want** to filter by city, **so that** results are local.  
**FR:** FR-SEARCH-02 | **P0**  
**AC:**
- AC-055-01: City filter applied server-side.
- AC-055-02: Unknown city returns empty with suggestions.

### US-056 — Filter by category
**As a** customer, **I want** category filters, **so that** I see halls vs sports correctly.  
**FR:** FR-SEARCH-02 | **P0**  
**AC:**
- AC-056-01: Multi-select categories supported or single — document; MVP single OK.
- AC-056-02: Flagged-off categories excluded.

### US-057 — Filter by date availability
**As a** customer, **I want** to filter venues available on my date, **so that** I don’t open sold-out listings.  
**FR:** FR-SEARCH-07 | **P0**  
**AC:**
- AC-057-01: Uses availability projection/rules.
- AC-057-02: Performance within NFR-PERF-01.
- AC-057-03: Stale projection eventually consistent via outbox ≤ NFR-SCALE-04.

### US-058 — Filter by capacity
**As a** customer, **I want** min capacity filter, **so that** small venues are hidden for big events.  
**FR:** FR-SEARCH-02 | **P0**  
**AC:**
- AC-058-01: `capacity >= min` enforced.
- AC-058-02: Invalid min rejected.

### US-059 — Filter by price range
**As a** customer, **I want** price filters, **so that** I stay in budget.  
**FR:** FR-SEARCH-02 | **P0**  
**AC:**
- AC-059-01: Uses comparable base rate field.
- AC-059-02: Disclaimer if packages differ.

### US-060 — Filter by amenities
**As a** customer, **I want** amenity filters (AC, parking), **so that** must-haves are met.  
**FR:** FR-SEARCH-02 | **P0**  
**AC:**
- AC-060-01: AND semantics for selected amenities.
- AC-060-02: Unknown amenity ids ignored/rejected consistently.

### US-061 — Sort results
**As a** customer, **I want** to sort by price/rating/distance/relevance, **so that** I scan efficiently.  
**FR:** FR-SEARCH-03 | **P0**  
**AC:**
- AC-061-01: Sort options work with filters.
- AC-061-02: Default relevance.
- AC-061-03: Distance requires user geo.

### US-062 — Paginate results
**As a** customer, **I want** pagination, **so that** large result sets are usable.  
**FR:** FR-SEARCH-06 | **P0**  
**AC:**
- AC-062-01: Page/cursor stable enough for UX.
- AC-062-02: Total count optional; hasMore required.

### US-063 — Search empty state
**As a** customer, **I want** helpful empty states, **so that** I know how to broaden search.  
**FR:** FR-SEARCH-06 | **P0**  
**AC:**
- AC-063-01: Suggest clear filters / nearby cities.
- AC-063-02: No error flash for zero results.

### US-064 — Outbox search projection update
**As a** platform, **I want** search docs updated on venue changes, **so that** discovery stays accurate.  
**FR:** FR-SEARCH-05 | **P0**  
**AC:**
- AC-064-01: Publish/unpublish reflected after outbox dispatch.
- AC-064-02: Handler idempotent.
- AC-064-03: Failure retries with backoff.

### US-065 — Verified boost
**As a** customer, **I want** verified venues ranked higher, **so that** I trust results more.  
**FR:** FR-SEARCH-08 | **P1**  
**AC:**
- AC-065-01: Verification flag influences relevance.
- AC-065-02: Still filterable; badge visible on cards.

### US-066 — Recently viewed
**As a** customer, **I want** recently viewed venues, **so that** I can resume decisions.  
**FR:** FR-SEARCH-06 | **P1**  
**AC:**
- AC-066-01: Stores last N venue ids per user.
- AC-066-02: Excludes unpublished.

### US-067 — Category landing discovery
**As a** customer, **I want** curated category lists, **so that** browsing works without keywords.  
**FR:** FR-SEARCH-02 | **P1**  
**AC:**
- AC-067-01: Category endpoint returns published venues.
- AC-067-02: Aligns with SSR category pages.

### US-068 — Search analytics events
**As a** product team, **I want** search funnel events, **so that** we improve conversion.  
**FR:** FR-RPT-04 | **P0**  
**AC:**
- AC-068-01: Emits search, filter, result_click events.
- AC-068-02: No PII in event payloads beyond allowed ids.
- AC-068-03: Correlation with booking funnel possible.
