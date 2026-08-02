# Stories — Auth & Identity (US-001–US-015)

**Module:** AUTH  
**FRs:** FR-AUTH-*  
**Priority focus:** MVP (P0)

Each story includes acceptance criteria (AC).

---

### US-001 — Register with email
**As a** new user, **I want** to register with email and password, **so that** I can access BookMySpace securely.  
**FR:** FR-AUTH-01 | **Priority:** P0  
**AC:**
- AC-001-01: Valid email + password (≥8 chars, complexity rule documented) creates account.
- AC-001-02: Duplicate email returns clear conflict error (Problem Details).
- AC-001-03: Password stored hashed; never returned in API responses.
- AC-001-04: DPDP consent checkbox required before submit (FR-AUTH-09).

### US-002 — Register with Indian mobile
**As a** new user, **I want** to register with +91 mobile, **so that** I can use phone-based identity common in India.  
**FR:** FR-AUTH-01 | **Priority:** P0  
**AC:**
- AC-002-01: Accepts E.164 +91 numbers; rejects invalid lengths.
- AC-002-02: OTP verification required before account activation (or password+OTP dual — implement per eng design, OTP mandatory).
- AC-002-03: Rate-limited OTP sends (NFR-SEC-04).

### US-003 — Login
**As a** registered user, **I want** to log in, **so that** I receive access and refresh tokens.  
**FR:** FR-AUTH-02 | **Priority:** P0  
**AC:**
- AC-003-01: Correct credentials return access JWT + refresh token.
- AC-003-02: Access token TTL ≈ 15 minutes; contains sub/roles/tokenVersion.
- AC-003-03: Invalid credentials return generic auth error (no user enumeration beyond policy).

### US-004 — Refresh rotation
**As a** mobile user, **I want** silent token refresh, **so that** my session continues securely.  
**FR:** FR-AUTH-02 | **Priority:** P0  
**AC:**
- AC-004-01: Valid refresh returns new access + new refresh; old refresh revoked.
- AC-004-02: Reuse of rotated refresh revokes family (ADR-004).
- AC-004-03: Client retries original request once after refresh on 401.

### US-005 — Logout
**As a** user, **I want** to log out, **so that** my refresh token cannot be reused.  
**FR:** FR-AUTH-03 | **Priority:** P0  
**AC:**
- AC-005-01: Logout revokes current refresh family or token.
- AC-005-02: Subsequent refresh fails.
- AC-005-03: Access token may remain until expiry but protected APIs still check revocation/version if implemented.

### US-006 — Password reset request
**As a** user who forgot password, **I want** to request a reset link/OTP, **so that** I can regain access.  
**FR:** FR-AUTH-04 | **Priority:** P0  
**AC:**
- AC-006-01: Request always returns generic success message.
- AC-006-02: Token/OTP expires within configured TTL.
- AC-006-03: Rate-limited per account/IP.

### US-007 — Password reset confirm
**As a** user, **I want** to set a new password with a valid token, **so that** I can log in again.  
**FR:** FR-AUTH-04 | **Priority:** P0  
**AC:**
- AC-007-01: Valid token updates password and invalidates token.
- AC-007-02: Expired/invalid token fails clearly.
- AC-007-03: Existing refresh families revoked on password change.

### US-008 — Auth rate limiting
**As a** platform, **I want** auth endpoints rate-limited, **so that** credential stuffing is mitigated.  
**FR:** FR-AUTH-05 | **Priority:** P0  
**AC:**
- AC-008-01: Excess attempts return 429 with retry guidance.
- AC-008-02: Limits apply per IP and per account identifier.
- AC-008-03: Metrics/alerts exist for spike (NFR-OBS).

### US-009 — View profile
**As a** user, **I want** to view my profile, **so that** I can verify my details.  
**FR:** FR-AUTH-06 | **Priority:** P0  
**AC:**
- AC-009-01: Returns name, email/phone masked as designed, locale, avatar URL.
- AC-009-02: Unauthorized access returns 401.

### US-010 — Update profile
**As a** user, **I want** to update my display name and locale, **so that** the app feels personal.  
**FR:** FR-AUTH-06 | **Priority:** P0  
**AC:**
- AC-010-01: Valid updates persist and reflect on next fetch.
- AC-010-02: Phone/email change requires re-verification flow.
- AC-010-03: Validation errors are field-specific.

### US-011 — Marketing consent
**As a** user, **I want** to opt in/out of marketing, **so that** my preferences are respected (DPDP).  
**FR:** FR-AUTH-09 | **Priority:** P0  
**AC:**
- AC-011-01: Consent state stored with timestamp.
- AC-011-02: Marketing channels honor opt-out (BR-NOTIF-02/03).
- AC-011-03: Transactional booking messages still deliver.

### US-012 — Session list (V1)
**As a** security-conscious user, **I want** to see active sessions, **so that** I can spot unknown devices.  
**FR:** FR-AUTH-07 | **Priority:** P1  
**AC:**
- AC-012-01: Lists device/app approx info and last used.
- AC-012-02: Current session marked.
- AC-012-03: Does not expose raw refresh tokens.

### US-013 — Revoke other sessions
**As a** user, **I want** to revoke other sessions, **so that** stolen devices lose access.  
**FR:** FR-AUTH-07 | **Priority:** P1  
**AC:**
- AC-013-01: Revoke endpoint invalidates selected refresh families.
- AC-013-02: Current session remains unless user chooses logout-all.
- AC-013-03: Audit/security event logged.

### US-014 — Account data export request
**As a** user, **I want** to request my data export, **so that** I can exercise privacy rights.  
**FR:** FR-AUTH-10 | **Priority:** P1  
**AC:**
- AC-014-01: Creates export request with status tracking.
- AC-014-02: Completes within NFR-PRIV-02 SLA.
- AC-014-03: Download is authenticated and time-limited.

### US-015 — Account deletion request
**As a** user, **I want** to delete my account, **so that** my personal data is erased per policy.  
**FR:** FR-AUTH-10 | **Priority:** P1  
**AC:**
- AC-015-01: Blocks delete if open CONFIRMED bookings unless cancelled first (policy message).
- AC-015-02: Soft-deletes identity; triggers DPDP erasure workflow for eligible PII.
- AC-015-03: Org ownership must be transferred before owner delete.
