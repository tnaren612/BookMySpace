# Stories — Reviews & Ratings (US-138–US-147)

**Module:** REV | **FRs:** FR-REV-*

---

### US-138 — Submit review after completed booking
**As a** customer, **I want** to rate a venue after my event, **so that** I help others decide.  
**FR:** FR-REV-01/02 | **P0**  
**AC:**
- AC-138-01: Only completed bookings eligible (BR-REV-01).
- AC-138-02: 1–5 stars required; text optional with max length.
- AC-138-03: One review per booking.

### US-139 — Review with photos
**As a** customer, **I want** to add photos to a review, **so that** my feedback is credible.  
**FR:** FR-REV-02 | **P1**  
**AC:**
- AC-139-01: Uses media upload pipeline.
- AC-139-02: Moderation flag possible.
- AC-139-03: Count limits enforced.

### US-140 — Owner responds to review
**As an** owner, **I want** to respond publicly, **so that** I can thank or clarify.  
**FR:** FR-REV-03 | **P0**  
**AC:**
- AC-140-01: One response per review (edit window optional).
- AC-140-02: Org-scoped authz.
- AC-140-03: Abuse reportable.

### US-141 — Aggregate rating on venue
**As a** customer, **I want** to see average rating, **so that** I can compare venues.  
**FR:** FR-REV-04 | **P0**  
**AC:**
- AC-141-01: Aggregate updates via outbox/projection.
- AC-141-02: Shown on search cards and detail.
- AC-141-03: Hidden until minimum review count threshold (configurable).

### US-142 — Report abusive review
**As an** owner/customer, **I want** to report abuse, **so that** moderators can act.  
**FR:** FR-REV-05 | **P1**  
**AC:**
- AC-142-01: Creates moderation case.
- AC-142-02: Reason codes required.
- AC-142-03: Reporter gets acknowledgment.

### US-143 — Admin hide review
**As a** moderator, **I want** to hide a review, **so that** policy violations are removed.  
**FR:** FR-REV-06 | **P1**  
**AC:**
- AC-143-01: Hidden from public.
- AC-143-02: Audit + reason.
- AC-143-03: Aggregate recalculated.

### US-144 — Prompt to review
**As a** customer, **I want** a post-event review prompt, **so that** I remember to rate.  
**FR:** FR-REV-01 | **P1**  
**AC:**
- AC-144-01: Notification after end time + buffer.
- AC-144-02: Not sent if already reviewed.
- AC-144-03: Respects prefs for non-transactional prompt channel.

### US-145 — Sort by rating
**As a** customer, **I want** to sort by rating, **so that** quality rises.  
**FR:** FR-SEARCH-03 | **P1**  
**AC:**
- AC-145-01: Uses aggregate field.
- AC-145-02: Unrated venues ordered last or by secondary relevance.

### US-146 — Review eligibility messaging
**As a** customer, **I want** clear why I can’t review yet, **so that** I’m not confused.  
**FR:** FR-REV-01 | **P0**  
**AC:**
- AC-146-01: UI states: not completed / already reviewed / cancelled ineligible.
- AC-146-02: No dead-end button.

### US-147 — Vendor reviews (later)
**As a** customer, **I want** to review a vendor after job completion, **so that** vendor quality is visible.  
**FR:** FR-VND-06 | **P2**  
**AC:**
- AC-147-01: Only completed vendor jobs.
- AC-147-02: Separate from venue review.
- AC-147-03: Affects vendor ranking.
