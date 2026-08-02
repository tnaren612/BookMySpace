# Stories — Venue Catalog (US-028–US-045)

**Module:** VENUE  
**FRs:** FR-VENUE-*

---

### US-028 — Create venue draft
**As an** org owner, **I want** to create a venue draft, **so that** I can prepare a listing.  
**FR:** FR-VENUE-01 | **P0**  
**AC:**
- AC-028-01: Draft created under active org only.
- AC-028-02: Default state DRAFT.
- AC-028-03: Title required.

### US-029 — Edit venue draft
**As an** org manager, **I want** to edit venue fields, **so that** listing details stay accurate.  
**FR:** FR-VENUE-01 | **P0**  
**AC:**
- AC-029-01: Allowed roles can edit.
- AC-029-02: Validation for capacity > 0.
- AC-029-03: Changes audited optionally for published venues.

### US-030 — Set venue category
**As an** owner, **I want** to choose a category, **so that** capability fields and search filters apply.  
**FR:** FR-VENUE-03 | **P0**  
**AC:**
- AC-030-01: Category from taxonomy only.
- AC-030-02: Changing category may require re-entering capability fields.
- AC-030-03: Feature-flagged categories hidden if off.

### US-031 — Add inventory unit
**As an** owner, **I want** to add an inventory unit (hall/room/pitch), **so that** bookable capacity is explicit.  
**FR:** FR-VENUE-04 | **P0**  
**AC:**
- AC-031-01: Unit has name, type, capacity.
- AC-031-02: Belongs to venue/org.
- AC-031-03: At least one unit required before publish.

### US-032 — Edit inventory unit
**As an** owner, **I want** to edit unit attributes, **so that** physical changes are reflected.  
**FR:** FR-VENUE-04 | **P0**  
**AC:**
- AC-032-01: Updates persist.
- AC-032-02: Cannot delete unit with future CONFIRMED bookings.

### US-033 — Manage amenities
**As an** owner, **I want** to select amenities, **so that** customers can filter accurately.  
**FR:** FR-VENUE-05 | **P0**  
**AC:**
- AC-033-01: Amenities from allowed schema for category.
- AC-033-02: Custom text amenities limited/sanitized.

### US-034 — Set address and geo
**As an** owner, **I want** to set address and map pin, **so that** customers can find the venue.  
**FR:** FR-VENUE-06 | **P0**  
**AC:**
- AC-034-01: Address + lat/lng required for publish.
- AC-034-02: Coordinates sanity-checked for India (FR-MAPS-01).
- AC-034-03: Public detail shows approximate or exact per privacy setting (default exact for venues).

### US-035 — Set capacity and policies
**As an** owner, **I want** to set capacity and house rules, **so that** expectations are clear.  
**FR:** FR-VENUE-06 | **P0**  
**AC:**
- AC-035-01: Capacity integer validated.
- AC-035-02: Policy text length limits enforced.
- AC-035-03: Cancellation policy template selectable (FR-VENUE-12).

### US-036 — Configure booking mode
**As an** owner, **I want** to choose instant or request-to-book, **so that** I control approval workflow.  
**FR:** FR-VENUE-11 | **P0**  
**AC:**
- AC-036-01: Mode stored per venue or unit (document chosen granularity).
- AC-036-02: Feature flag can force request-only in a city.
- AC-036-03: Customer UI reflects mode.

### US-037 — Set base pricing
**As an** owner, **I want** to set base rates, **so that** bookings charge correctly.  
**FR:** FR-VENUE-10 | **P0**  
**AC:**
- AC-037-01: Amount in INR paise.
- AC-037-02: Server uses rules at hold/confirm.
- AC-037-03: Invalid negative prices rejected.

### US-038 — Set peak pricing rules
**As an** sports/hall owner, **I want** peak windows, **so that** evening demand yields more.  
**FR:** FR-VENUE-10 | **P1**  
**AC:**
- AC-038-01: Peak rules specify days/hours + multiplier or absolute.
- AC-038-02: Non-overlapping rule validation or priority order.
- AC-038-03: Quote preview matches server calc within rounding.

### US-039 — Create package pricing
**As a** hall owner, **I want** packages (decor+hall), **so that** I can sell bundled offers.  
**FR:** FR-VENUE-10 | **P1**  
**AC:**
- AC-039-01: Package has name, inclusions, price.
- AC-039-02: Selectable at booking when enabled.
- AC-039-03: Plan entitlements may limit package count.

### US-040 — Submit for publish
**As an** owner, **I want** to submit venue for publish/review, **so that** it appears on marketplace when approved.  
**FR:** FR-VENUE-02, FR-VENUE-07 | **P0**  
**AC:**
- AC-040-01: Fails with field list if minimums unmet (BR-PUB-01).
- AC-040-02: Moves to PENDING_REVIEW or PUBLISHED per KYC flag (BR-PUB-02).
- AC-040-03: Idempotent resubmit safe.

### US-041 — Unpublish venue
**As an** owner, **I want** to unpublish, **so that** new bookings stop while I renovate.  
**FR:** FR-VENUE-02 | **P0**  
**AC:**
- AC-041-01: State UNPUBLISHED; removed from search.
- AC-041-02: Existing CONFIRMED bookings remain visible.
- AC-041-03: Staff without permission denied.

### US-042 — List org venues
**As an** org staff, **I want** to list our venues, **so that** I can manage day-to-day.  
**FR:** FR-VENUE-09 | **P0**  
**AC:**
- AC-042-01: Only org venues returned.
- AC-042-02: Supports filter by state.

### US-043 — Public venue detail
**As a** customer, **I want** to view a published venue, **so that** I can decide to book.  
**FR:** FR-VENUE-08 | **P0**  
**AC:**
- AC-043-01: Unpublished returns 404/410 to marketplace.
- AC-043-02: Shows photos, amenities, policies, rating aggregate, map.
- AC-043-03: CTA respects booking mode.

### US-044 — Archive venue
**As an** owner, **I want** to archive a venue, **so that** clutter is removed without losing history.  
**FR:** FR-VENUE-02 | **P1**  
**AC:**
- AC-044-01: Archived not searchable.
- AC-044-02: Blocked if future confirmed bookings.
- AC-044-03: Counts toward plan limits until deleted/archived rules say otherwise (document).

### US-045 — Multi-venue org
**As an** owner with multiple halls, **I want** multiple venues under one org, **so that** I manage one business account.  
**FR:** FR-VENUE-09 | **P0**  
**AC:**
- AC-045-01: Create allowed until plan venue cap (BR-SUB-01).
- AC-045-02: Cap breach returns upgrade CTA error code.
- AC-045-03: Calendar can filter by venue.
