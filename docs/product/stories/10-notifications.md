# Stories — Notifications (US-126–US-137)

**Module:** NOTIF | **FRs:** FR-NOTIF-*

---

### US-126 — Push on booking confirmed
**As a** customer, **I want** a push when booking confirms, **so that** I know payment worked.  
**FR:** FR-NOTIF-01 | **P0**  
**AC:**
- AC-126-01: One push per confirmation (idempotent delivery key).
- AC-126-02: Contains booking code.
- AC-126-03: Retry does not duplicate user-visible spam.

### US-127 — Email on booking confirmed
**As a** customer, **I want** confirmation email, **so that** I have a durable record.  
**FR:** FR-NOTIF-02 | **P0**  
**AC:**
- AC-127-01: Email sent via outbox dispatcher.
- AC-127-02: Includes venue, time, amount, code.
- AC-127-03: Unsubscribe not applied to transactional.

### US-128 — Push/email on cancel
**As a** customer, **I want** cancel notifications, **so that** I’m aware of state changes.  
**FR:** FR-NOTIF-01/02 | **P0**  
**AC:**
- AC-128-01: Triggered on CANCELLED.
- AC-128-02: Includes refund status if any.
- AC-128-03: Idempotent.

### US-129 — Owner new booking notify
**As an** owner, **I want** alerts for new bookings/requests, **so that** I can respond fast.  
**FR:** FR-NOTIF-07 | **P0**  
**AC:**
- AC-129-01: Instant for requests (SLA-critical).
- AC-129-02: Includes deep link to booking detail.
- AC-129-03: Staff recipients configurable later; owner default.

### US-130 — Preference center
**As a** user, **I want** to manage notification preferences, **so that** I control channels.  
**FR:** FR-NOTIF-04 | **P0**  
**AC:**
- AC-130-01: Toggle push/email/WhatsApp marketing vs product tips.
- AC-130-02: Transactional cannot be fully disabled without account constraints messaging.
- AC-130-03: Changes take effect ≤ 24h (BR-NOTIF-03).

### US-131 — Outbox dispatcher retries
**As a** platform, **I want** failed deliveries retried, **so that** notifications are reliable.  
**FR:** FR-NOTIF-03 | **P0**  
**AC:**
- AC-131-01: Exponential backoff.
- AC-131-02: Dead-letter/alert after max attempts.
- AC-131-03: Handlers idempotent.

### US-132 — FCM device registration
**As a** mobile user, **I want** my device registered for push, **so that** I receive alerts.  
**FR:** FR-NOTIF-01 | **P0**  
**AC:**
- AC-132-01: Register/unregister token APIs.
- AC-132-02: Tokens bound to user.
- AC-132-03: Stale tokens cleaned on failure.

### US-133 — WhatsApp booking confirmation
**As a** customer in India, **I want** WhatsApp confirmation, **so that** I see it in my primary messenger.  
**FR:** FR-NOTIF-05 | **P1**  
**AC:**
- AC-133-01: Uses approved WhatsApp Business templates only.
- AC-133-02: Honors opt-in/out rules.
- AC-133-03: Cost logged.

### US-134 — WhatsApp budget guard
**As a** platform, **I want** WhatsApp spend guards, **so that** unit economics don’t break.  
**FR:** FR-NOTIF-06 | **P1**  
**AC:**
- AC-134-01: Soft/hard caps configurable.
- AC-134-02: Alerts on threshold.
- AC-134-03: Fallback to push/email when capped.

### US-135 — Template failure alerting
**As an** ops engineer, **I want** alerts when templates fail, **so that** we fix provider issues.  
**FR:** FR-NOTIF-05 | **P1**  
**AC:**
- AC-135-01: Failure rate metric.
- AC-135-02: Alert routing defined.
- AC-135-03: Status logged per message.

### US-136 — Digest notifications
**As an** owner, **I want** optional digests for non-critical alerts, **so that** I’m not spammed.  
**FR:** FR-NOTIF-08 | **P2**  
**AC:**
- AC-136-01: Digest preference available.
- AC-136-02: Critical request alerts still immediate.
- AC-136-03: Daily/weekly options.

### US-137 — Notification history
**As a** user, **I want** in-app notification history, **so that** I can revisit messages.  
**FR:** FR-NOTIF-04 | **P1**  
**AC:**
- AC-137-01: Lists recent notifications.
- AC-137-02: Mark read.
- AC-137-03: Deep links work when still valid.
