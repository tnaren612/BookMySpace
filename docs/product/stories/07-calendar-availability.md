# Stories — Calendar & Availability (US-077–US-090)

**Module:** CAL | **FRs:** FR-CAL-*

---

### US-077 — Define availability rules
**As an** owner, **I want** to define when a unit is bookable, **so that** customers only see valid slots.  
**FR:** FR-CAL-01 | **P0**  
**AC:**
- AC-077-01: Rules stored per inventory unit.
- AC-077-02: Outside rules → not holdable.
- AC-077-03: Timezone Asia/Kolkata display; UTC storage (FR-CAL-08).

### US-078 — Owner day calendar
**As an** owner, **I want** a day calendar view, **so that** I see today’s holds/bookings/blocks.  
**FR:** FR-CAL-02 | **P0**  
**AC:**
- AC-078-01: Returns all events for unit/venue day.
- AC-078-02: Distinguishes hold vs confirmed vs block.
- AC-078-03: p95 within NFR-PERF-07 for week fetch path.

### US-079 — Owner week calendar
**As an** owner, **I want** a week view, **so that** I plan staffing and prep.  
**FR:** FR-CAL-02 | **P0**  
**AC:**
- AC-079-01: Seven-day window query works.
- AC-079-02: Filter by unit.
- AC-079-03: Empty days render empty state.

### US-080 — Block time
**As an** owner, **I want** to block maintenance time, **so that** customers cannot book it.  
**FR:** FR-CAL-03 | **P0**  
**AC:**
- AC-080-01: Block creates non-bookable range.
- AC-080-02: Overlap with CONFIRMED rejected or requires cancel first.
- AC-080-03: Customer hold on blocked range fails.

### US-081 — Remove block
**As an** owner, **I want** to remove a block, **so that** inventory reopens.  
**FR:** FR-CAL-03 | **P0**  
**AC:**
- AC-081-01: Block deleted/soft-deleted.
- AC-081-02: Slot becomes holdable if rules allow.

### US-082 — Manual offline booking
**As a** venue staff, **I want** to enter a phone booking, **so that** the calendar stays source of truth.  
**FR:** FR-CAL-04 | **P0**  
**AC:**
- AC-082-01: Creates CONFIRMED or OWNER_BLOCKED_BOOKING per design with customer note.
- AC-082-02: Prevents overlapping customer holds.
- AC-082-03: Requires staff permission.

### US-083 — Create hold
**As a** customer, **I want** to hold a slot, **so that** I can complete payment without losing it.  
**FR:** FR-CAL-05 | **P0**  
**AC:**
- AC-083-01: Hold succeeds only if available.
- AC-083-02: Redis + DB constraints applied.
- AC-083-03: Returns expiry timestamp.

### US-084 — Hold TTL expiry
**As a** platform, **I want** holds to expire, **so that** inventory is released.  
**FR:** FR-CAL-05, BR-BOOK-02 | **P0**  
**AC:**
- AC-084-01: After TTL, hold EXPIRED.
- AC-084-02: Another user can hold same slot.
- AC-084-03: Client shows countdown.

### US-085 — Concurrent hold conflict
**As a** platform, **I want** only one hold winner under concurrency, **so that** double-booking is prevented.  
**FR:** FR-CAL-05, BR-BOOK-04 | **P0**  
**AC:**
- AC-085-01: Parallel holds → one success, one conflict.
- AC-085-02: Automated concurrency test required.
- AC-085-03: No confirmed overlap possible thereafter.

### US-086 — Recurring weekly availability
**As a** training institute owner, **I want** recurring weekly slots, **so that** batches are easy to publish.  
**FR:** FR-CAL-06 | **P1**  
**AC:**
- AC-086-01: RRULE-like or weekday pattern supported.
- AC-086-02: Exceptions/blocks override.
- AC-086-03: Generates holdable instances in range queries.

### US-087 — Buffer between bookings
**As a** sports owner, **I want** cleanup buffers, **so that** turnaround is realistic.  
**FR:** FR-CAL-07 | **P1**  
**AC:**
- AC-087-01: Buffer minutes config per unit.
- AC-087-02: Adjacent booking violating buffer rejected.
- AC-087-03: Shown in owner calendar as non-bookable gap.

### US-088 — Availability for date range query
**As a** customer UI, **I want** available slots for a date, **so that** I can pick a time.  
**FR:** FR-CAL-01 | **P0**  
**AC:**
- AC-088-01: Returns open slots for unit/date.
- AC-088-02: Excludes holds/bookings/blocks.
- AC-088-03: Respects category slot granularity.

### US-089 — Owner sees customer holds
**As an** owner, **I want** to see active holds, **so that** I don’t manually overbook.  
**FR:** FR-CAL-02 | **P0**  
**AC:**
- AC-089-01: Holds visible with expiry.
- AC-089-02: Distinguish request-to-book pending.

### US-090 — Blackout dates
**As a** hall owner, **I want** festival blackout dates, **so that** private use is reserved.  
**FR:** FR-CAL-03 | **P1**  
**AC:**
- AC-090-01: All-day blackout supported.
- AC-090-02: Applies to all units or selected units.
- AC-090-03: Search availability filter excludes blackout days.
