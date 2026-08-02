# Stories — Event Organizer & Franchise (US-296–US-305)

**Module:** EVT | **FRs:** FR-EVT-* | **Release:** V3 / Enterprise

---

### US-296 — Create event workspace
**As an** event organizer, **I want** an event workspace, **so that** I manage multiple venue bookings together.  
**FR:** FR-EVT-01 | **P2**  
**AC:**
- AC-296-01: Workspace has name/date/city.
- AC-296-02: Owner is organizer user.
- AC-296-03: Lists linked bookings.

### US-297 — Link bookings to event
**As an** event organizer, **I want** to attach bookings, **so that** ceremony+reception stay organized.  
**FR:** FR-EVT-01 | **P2**  
**AC:**
- AC-297-01: Only user’s bookings linkable.
- AC-297-02: Unlink supported.
- AC-297-03: Status rollup view.

### US-298 — Collaborator shortlist share
**As an** event organizer, **I want** to share a shortlist with family, **so that** we decide together.  
**FR:** FR-EVT-02 | **P2**  
**AC:**
- AC-298-01: Share link with permissions view.
- AC-298-02: Expiry optional.
- AC-298-03: Comments optional later.

### US-299 — Multi-vendor attach to event
**As an** event organizer, **I want** to attach vendor jobs to the event, **so that** timeline is unified.  
**FR:** FR-EVT-01, FR-VND-04 | **P2**  
**AC:**
- AC-299-01: Vendors linked to workspace.
- AC-299-02: Dates conflict warnings.
- AC-299-03: Payments still isolated per job.

### US-300 — Franchise partner account
**As a** franchise partner, **I want** a partner account, **so that** I oversee multiple orgs.  
**FR:** FR-EVT-03 | **P2**  
**AC:**
- AC-300-01: Role `FRANCHISE_PARTNER`.
- AC-300-02: Linked orgs list.
- AC-300-03: Enterprise entitlement required.

### US-301 — Franchise rollup dashboard
**As a** franchise partner, **I want** rollup occupancy/GMV, **so that** I manage the network.  
**FR:** FR-EVT-03 | **P2**  
**AC:**
- AC-301-01: Aggregates across linked orgs.
- AC-301-02: Drill-down to org.
- AC-301-03: No cross-org write by default.

### US-302 — White-label booking page
**As an** enterprise brand, **I want** a white-label booking page, **so that** customers book under my brand.  
**FR:** FR-EVT-04 | **P2**  
**AC:**
- AC-302-01: Custom domain/branding tokens.
- AC-302-02: Still uses BookMySpace booking kernel.
- AC-302-03: Legal disclosure as needed.

### US-303 — Partner commission report
**As a** franchise partner, **I want** commission reports, **so that** contracts are settled.  
**FR:** FR-EVT-05 | **P2**  
**AC:**
- AC-303-01: Period export.
- AC-303-02: Per-org breakdown.
- AC-303-03: Finance role visibility.

### US-304 — Organizer checklist
**As an** event organizer, **I want** a checklist (venue, décor, catering), **so that** nothing is missed.  
**FR:** FR-EVT-01 | **P2**  
**AC:**
- AC-304-01: Default template items.
- AC-304-02: Mark complete.
- AC-304-03: Optional reminders.

### US-305 — Enterprise SSO placeholder
**As an** enterprise admin, **I want** SSO readiness noted, **so that** IT can plan (post-MVP).  
**FR:** FR-SUB-06 | **P2**  
**AC:**
- AC-305-01: Documented as future; not MVP.
- AC-305-02: Requires ADR when implemented.
- AC-305-03: Backlog only until sold.
