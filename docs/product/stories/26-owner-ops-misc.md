# Stories — Owner Ops & Category UX (US-288–US-295)

**Module:** OPS | **FRs:** FR-OPS-*

---

### US-288 — Hall day-rate booking UX
**As a** customer, **I want** to book a banquet hall by event date/window, **so that** weddings fit the model.  
**FR:** FR-OPS-01 | **P0**  
**AC:**
- AC-288-01: Day/event window picker.
- AC-288-02: Price uses day-rate/package rules.
- AC-288-03: Hold/book/pay path shared kernel.

### US-289 — Meeting room hourly UX
**As a** customer, **I want** hourly/half-day meeting booking, **so that** corporate needs are met.  
**FR:** FR-OPS-02 | **P0**  
**AC:**
- AC-289-01: Slot grid hourly.
- AC-289-02: Filters for AV/amenities.
- AC-289-03: Same payment confirmation UX.

### US-290 — Sports pitch hourly UX
**As a** player, **I want** to book a turf by the hour, **so that** tonight’s match is secured.  
**FR:** FR-OPS-03 | **P1**  
**AC:**
- AC-290-01: Pitch unit selection.
- AC-290-02: Peak pricing visible.
- AC-290-03: Buffer enforced.
- AC-290-04: Category flag required for rollout.

### US-291 — Training recurring slot UX
**As a** student/parent, **I want** to book a class slot or package, **so that** training is scheduled.  
**FR:** FR-OPS-04 | **P1**  
**AC:**
- AC-291-01: Shows recurring instances.
- AC-291-02: Package product selectable when offered.
- AC-291-03: Capacity remaining for multi-seat rooms (BR-OPS-02).

### US-292 — Coworking day pass UX
**As a** professional, **I want** a desk day pass, **so that** I can work today.  
**FR:** FR-OPS-05 | **P1**  
**AC:**
- AC-292-01: Seat capacity decrement atomic.
- AC-292-02: Day pass pricing.
- AC-292-03: Feature-flagged category.

### US-293 — Category-specific search filters
**As a** customer, **I want** filters that match category (pitch size, projector), **so that** discovery is precise.  
**FR:** FR-OPS-06 | **P1**  
**AC:**
- AC-293-01: Filter schema from capability plugin.
- AC-293-02: Irrelevant filters hidden.
- AC-293-03: Server validates filter keys.

### US-294 — Owner capability setup wizard
**As an** owner, **I want** a setup wizard per category, **so that** I configure the right availability model.  
**FR:** FR-OPS-01–05 | **P1**  
**AC:**
- AC-294-01: Wizard steps differ by category.
- AC-294-02: Cannot publish until required capability fields set.
- AC-294-03: Progress saved as draft.

### US-295 — Feature flag category rollout
**As an** admin, **I want** to enable sports in one city first, **so that** expansion is controlled.  
**FR:** FR-OPS-07 | **P0**  
**AC:**
- AC-295-01: Flag by category±city.
- AC-295-02: Customer/owner UIs hide disabled.
- AC-295-03: Audited toggles.
