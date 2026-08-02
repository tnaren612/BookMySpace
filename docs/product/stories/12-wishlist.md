# Stories — Wishlist (US-148–US-153)

**Module:** WISH | **FRs:** FR-WISH-*

---

### US-148 — Save venue to wishlist
**As a** customer, **I want** to save venues, **so that** I can compare later.  
**FR:** FR-WISH-01 | **P1**  
**AC:**
- AC-148-01: Toggle save/unsave.
- AC-148-02: Auth required.
- AC-148-03: Idempotent.

### US-149 — View wishlist
**As a** customer, **I want** to view saved venues, **so that** I resume planning.  
**FR:** FR-WISH-02 | **P1**  
**AC:**
- AC-149-01: Lists saved venues.
- AC-149-02: Unpublished show unavailable state.
- AC-149-03: Empty state CTA to search.

### US-150 — Wishlist availability peek
**As a** customer, **I want** a quick availability indicator, **so that** I know which saved venues fit my date.  
**FR:** FR-WISH-02 | **P1**  
**AC:**
- AC-150-01: Optional date input.
- AC-150-02: Shows available/unavailable/unknown.
- AC-150-03: Performance acceptable for list size ≤ 50.

### US-151 — Remove from wishlist
**As a** customer, **I want** to remove items, **so that** my list stays relevant.  
**FR:** FR-WISH-01 | **P1**  
**AC:**
- AC-151-01: Removes item.
- AC-151-02: Undo toast optional.

### US-152 — Wishlist note/date
**As a** customer, **I want** to attach an event date note, **so that** I remember context.  
**FR:** FR-WISH-03 | **P2**  
**AC:**
- AC-152-01: Note/date persisted.
- AC-152-02: Length limits.
- AC-152-03: Private to user.

### US-153 — Share wishlist item link
**As a** customer, **I want** to share a venue link, **so that** family can view SSR page.  
**FR:** FR-WEB-04 | **P1**  
**AC:**
- AC-153-01: Shares public website URL.
- AC-153-02: OG tags render.
- AC-153-03: Deep link to app if installed.
