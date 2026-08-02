# Stories — AI Features (US-264–US-271)

**Module:** AI | **FRs:** FR-AI-* | **Constraint:** Assistive only (BR-AI-01); not core booking path

---

### US-264 — Listing description assist
**As an** owner, **I want** AI-suggested description drafts, **so that** I write listings faster.  
**FR:** FR-AI-01 | **P2**  
**AC:**
- AC-264-01: Opt-in.
- AC-264-02: User must edit/confirm before save.
- AC-264-03: No auto-publish.

### US-265 — Amenity suggestions
**As an** owner, **I want** suggested amenities from photos/text, **so that** filters are complete.  
**FR:** FR-AI-01 | **P2**  
**AC:**
- AC-265-01: Suggestions selectable.
- AC-265-02: Never silently applied.
- AC-265-03: Logs acceptance rate.

### US-266 — Search synonym assist
**As a** platform, **I want** query rewriting/synonyms, **so that** “turf” finds football grounds.  
**FR:** FR-AI-02 | **P2**  
**AC:**
- AC-266-01: Improves recall on eval set.
- AC-266-02: Explainable mapping list maintainable.
- AC-266-03: Can disable via flag.

### US-267 — Fraud anomaly flags
**As a** moderator, **I want** AI/heuristic flags on suspicious listings, **so that** I prioritize review.  
**FR:** FR-AI-03 | **P2**  
**AC:**
- AC-267-01: Flags queue items; no auto-ban alone (BR-AI-02).
- AC-267-02: Reason features shown.
- AC-267-03: Thresholds configurable.

### US-268 — Owner insight narrative
**As an** owner, **I want** plain-language insights on reports, **so that** I know what to do next.  
**FR:** FR-AI-04 | **P2**  
**AC:**
- AC-268-01: Based on org metrics only.
- AC-268-02: Clearly labeled “suggestion”.
- AC-268-03: Plan-gated optional.

### US-269 — Review summary (later)
**As a** customer, **I want** a summary of reviews, **so that** I scan sentiment faster.  
**FR:** FR-AI-04 | **P2**  
**AC:**
- AC-269-01: Only if ≥ N reviews.
- AC-269-02: Link to full reviews.
- AC-269-03: Can be hidden if low confidence.

### US-270 — AI cost & privacy controls
**As a** platform, **I want** AI provider calls minimized and PII-scrubbed, **so that** cost and DPDP risk stay controlled.  
**FR:** NFR-PRIV/COST | **P2**  
**AC:**
- AC-270-01: No PAN/secrets sent.
- AC-270-02: Budget caps/alerts.
- AC-270-03: Vendor list documented in ADR when introduced.

### US-271 — Disable AI globally
**As an** admin, **I want** a kill switch for AI features, **so that** incidents don’t block booking.  
**FR:** FR-AI-05, FR-ADM-05 | **P0 constraint**  
**AC:**
- AC-271-01: Flag disables all AI assists.
- AC-271-02: Core book path unaffected.
- AC-271-03: Audited.
