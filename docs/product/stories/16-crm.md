# Stories — CRM (US-184–US-193)

**Module:** CRM | **FRs:** FR-CRM-*

---

### US-184 — Owner customer history from bookings
**As an** owner, **I want** to see a customer’s past bookings with us, **so that** I personalize service.  
**FR:** FR-CRM-01 | **P1**  
**AC:**
- AC-184-01: Org-scoped history only.
- AC-184-02: Shows dates/statuses/amounts.
- AC-184-03: Plan-gated advanced views.

### US-185 — Owner notes on customer
**As an** org manager, **I want** to add private notes, **so that** staff share context.  
**FR:** FR-CRM-02 | **P1**  
**AC:**
- AC-185-01: Notes org-private.
- AC-185-02: Not visible to customer.
- AC-185-03: Audit who wrote.

### US-186 — Sales lead create
**As a** sales executive, **I want** to create leads, **so that** I track supply onboarding.  
**FR:** FR-CRM-03 | **P1**  
**AC:**
- AC-186-01: Lead has city, category, contact, source.
- AC-186-02: Assigned to sales user.
- AC-186-03: Permission `sales:leads` required.

### US-187 — Lead pipeline stages
**As a** sales executive, **I want** pipeline stages, **so that** I forecast activations.  
**FR:** FR-CRM-04 | **P1**  
**AC:**
- AC-187-01: Stages: New → Contacted → Demo → Activated → Won/Lost.
- AC-187-02: Stage changes timestamped.
- AC-187-03: Lost reason required.

### US-188 — Sales tasks & reminders
**As a** sales executive, **I want** tasks/reminders, **so that** I follow up.  
**FR:** FR-CRM-04 | **P1**  
**AC:**
- AC-188-01: Due dates + completion.
- AC-188-02: Overdue list.
- AC-188-03: Optional notify.

### US-189 — Activation checklist
**As a** sales executive, **I want** an activation checklist tied to product events, **so that** onboarding is measurable.  
**FR:** FR-CRM-05 | **P1**  
**AC:**
- AC-189-01: Checklist items: org created, KYC, venue draft, photos, availability, publish, first booking.
- AC-189-02: Auto-check when events occur.
- AC-189-03: Visible on lead record.

### US-190 — Link lead to org
**As a** sales executive, **I want** to link a lead to an org, **so that** attribution is clear.  
**FR:** FR-CRM-03 | **P1**  
**AC:**
- AC-190-01: Link/unlink with audit.
- AC-190-02: One primary lead attribution.

### US-191 — Owner segment customers
**As a** Professional owner, **I want** segments (repeat bookers), **so that** I can run offers.  
**FR:** FR-CRM-06 | **P2**  
**AC:**
- AC-191-01: Plan-gated.
- AC-191-02: Segment rules documented.
- AC-191-03: Export limited by privacy rules.

### US-192 — CRM search
**As an** owner, **I want** to search customers by name/phone hash/booking code, **so that** front-desk finds people fast.  
**FR:** FR-CRM-01 | **P1**  
**AC:**
- AC-192-01: Org-scoped results.
- AC-192-02: Rate-limited.
- AC-192-03: Minimal PII display.

### US-193 — Sales dashboard activations
**As a** sales lead, **I want** activation metrics, **so that** I coach the team.  
**FR:** FR-SALES-05 | **P1**  
**AC:**
- AC-193-01: Activations by city/rep.
- AC-193-02: Funnel conversion.
- AC-193-03: Date filters.
