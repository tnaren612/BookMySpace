# Stories — Sales & Growth Ops (US-306–US-315)

**Module:** SALES | **FRs:** FR-SALES-*

---

### US-306 — Territory assignment
**As a** sales manager, **I want** to assign cities to reps, **so that** coverage is clear.  
**FR:** FR-SALES-02 | **P1**  
**AC:**
- AC-306-01: Assign city→user.
- AC-306-02: Leads inherit territory.
- AC-306-03: Conflict rules documented.

### US-307 — Import leads
**As a** sales executive, **I want** to import leads CSV, **so that** blitz campaigns scale.  
**FR:** FR-SALES-01 | **P1**  
**AC:**
- AC-307-01: Validates columns.
- AC-307-02: Dedupes by phone/email hash.
- AC-307-03: Error report for bad rows.

### US-308 — Demo scheduling note
**As a** sales executive, **I want** to log demo completed, **so that** pipeline advances.  
**FR:** FR-CRM-04 | **P1**  
**AC:**
- AC-308-01: Stage → Demo.
- AC-308-02: Notes + timestamp.
- AC-308-03: Optional next task auto-created.

### US-309 — Track time-to-publish
**As a** sales executive, **I want** time-to-first-publish metrics, **so that** I spot onboarding friction.  
**FR:** FR-SALES-03/05 | **P1**  
**AC:**
- AC-309-01: Measured from org create → publish.
- AC-309-02: Dashboard widget.
- AC-309-03: Outliers list.

### US-310 — Upsell task from usage
**As a** sales executive, **I want** tasks when Free orgs hit caps, **so that** I upsell Starter.  
**FR:** FR-SALES-04 | **P1**  
**AC:**
- AC-310-01: Trigger on entitlement denial events.
- AC-310-02: Task assigned by territory.
- AC-310-03: Outcome logging (won/lost).

### US-311 — Plan conversion report
**As a** sales manager, **I want** Free→paid conversion, **so that** I forecast revenue.  
**FR:** FR-SALES-05 | **P1**  
**AC:**
- AC-311-01: Conversion by city/rep.
- AC-311-02: Date range.
- AC-311-03: Platform role required.

### US-312 — Owner success handoff
**As a** sales executive, **I want** to hand off activated orgs to support/success, **so that** churn drops.  
**FR:** FR-SALES-03 | **P1**  
**AC:**
- AC-312-01: Handoff state on lead/org.
- AC-312-02: Checklist must be mostly complete.
- AC-312-03: Notify receiving queue.

### US-313 — Competitive intel note
**As a** sales executive, **I want** to tag “uses WhatsApp only” etc., **so that** messaging improves.  
**FR:** FR-CRM-04 | **P2**  
**AC:**
- AC-313-01: Tag taxonomy.
- AC-313-02: Reportable counts.
- AC-313-03: No sensitive competitor PII dumps.

### US-314 — Growth experiment flag notes
**As a** growth PM, **I want** experiment notes linked to flags, **so that** rollouts are documented.  
**FR:** FR-ADM-05 | **P2**  
**AC:**
- AC-314-01: Flag has description/owner/hypothesis.
- AC-314-02: Start/end dates.
- AC-314-03: Result field.

### US-315 — Referral of owners (B2B)
**As an** existing owner, **I want** to refer another venue owner, **so that** both get rewards (later).  
**FR:** FR-COUP-06 | **P2**  
**AC:**
- AC-315-01: Referral code for owners.
- AC-315-02: Reward after referee publishes + first booking.
- AC-315-03: Fraud controls.
