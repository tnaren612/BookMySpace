# Stories — Support (US-218–US-227)

**Module:** SUP | **FRs:** FR-SUP-*

---

### US-218 — Customer create ticket
**As a** customer, **I want** to create a support ticket, **so that** my issue is tracked.  
**FR:** FR-SUP-01/02 | **P1**  
**AC:**
- AC-218-01: Categories: booking, payment, listing, account, other.
- AC-218-02: Optional booking id link.
- AC-218-03: Confirmation with ticket id.

### US-219 — Owner create ticket
**As an** owner, **I want** to create tickets, **so that** payout/listing issues get help.  
**FR:** FR-SUP-01 | **P1**  
**AC:**
- AC-219-01: Org context attached when relevant.
- AC-219-02: Same category model.
- AC-219-03: Notify on updates.

### US-220 — Support lookup booking
**As a** support executive, **I want** to find bookings by id/code/phone hash, **so that** I resolve quickly.  
**FR:** FR-SUP-03 | **P0**  
**AC:**
- AC-220-01: Lookup ≤ 60s UX target (NFR-SUPP-01).
- AC-220-02: Shows payment+booking timeline.
- AC-220-03: Access audited.

### US-221 — Ticket queue
**As a** support executive, **I want** a prioritized queue, **so that** severe issues go first.  
**FR:** FR-SUP-05 | **P1**  
**AC:**
- AC-221-01: Severity + SLA timers.
- AC-221-02: Filter unassigned/mine.
- AC-221-03: Platform role required.

### US-222 — Canned macros
**As a** support executive, **I want** macros, **so that** common answers are consistent.  
**FR:** FR-SUP-04 | **P1**  
**AC:**
- AC-222-01: Insert macro text.
- AC-222-02: Editable before send.
- AC-222-03: Admin can manage macros.

### US-223 — Apply in-policy refund from ticket
**As a** support executive, **I want** to refund from ticket context, **so that** I don’t switch tools.  
**FR:** FR-ADM-08 | **P1**  
**AC:**
- AC-223-01: Uses BR-REF rules.
- AC-223-02: Reason + audit.
- AC-223-03: Updates ticket timeline.

### US-224 — Escalate ticket
**As a** support executive, **I want** to escalate to finance/moderation, **so that** complex cases move.  
**FR:** FR-SUP-05 | **P1**  
**AC:**
- AC-224-01: Escalation target + note.
- AC-224-02: SLA pause/transfer rules documented.
- AC-224-03: Notify assignees.

### US-225 — CSAT on close
**As a** platform, **I want** CSAT after ticket close, **so that** support quality is measured.  
**FR:** FR-SUP-06 | **P1**  
**AC:**
- AC-225-01: Prompt on close.
- AC-225-02: Score stored.
- AC-225-03: Optional comment.

### US-226 — User ticket history
**As a** customer, **I want** to see my tickets, **so that** I track progress.  
**FR:** FR-SUP-01 | **P1**  
**AC:**
- AC-226-01: List + detail thread.
- AC-226-02: Status visible.
- AC-226-03: Empty state.

### US-227 — Payment mismatch playbook UI
**As a** support executive, **I want** reconciliation status on payment issues, **so that** I follow runbooks.  
**FR:** FR-SUP-03, FR-PAY-07 | **P1**  
**AC:**
- AC-227-01: Shows intent/webhook/ledger states.
- AC-227-02: Links to runbook.
- AC-227-03: Cannot mark CONFIRMED without authorized action.
