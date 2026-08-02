# Security Checklist

Use before merging auth/payment/tenancy changes and before every production release.

## Authentication & Sessions

- [ ] Access tokens short-lived; refresh rotated
- [ ] Refresh tokens stored hashed at rest
- [ ] Refresh reuse detected → revoke family
- [ ] Password hashing with Argon2id or bcrypt (cost reviewed)
- [ ] Lockout / rate limit on login & OTP
- [ ] Secure client storage for tokens
- [ ] Logout revokes refresh tokens

## Authorization & Tenancy

- [ ] Every org-scoped query filters by `organization_id`
- [ ] Client-supplied org id is never authoritative alone
- [ ] Automated cross-tenant access tests pass
- [ ] Admin actions audited
- [ ] Principle of least privilege on roles

## API & Network

- [ ] HTTPS only; HSTS at edge
- [ ] CORS allowlist (no `*` with credentials)
- [ ] Rate limiting on auth, search, booking, payment
- [ ] Request size limits
- [ ] Idempotency on payment & booking confirm
- [ ] Webhook signature verification (Razorpay)
- [ ] No verbose errors leaking stack traces to clients in prod

## Data Protection (India DPDP-minded)

- [ ] Collect only needed PII
- [ ] Consent recorded where required
- [ ] Encryption in transit; encryption at rest (disk/KMS)
- [ ] PII scrubbed from logs
- [ ] Backup encryption + restore tested
- [ ] Data retention policy documented
- [ ] Export/delete workflow planned for user requests

## Payments

- [ ] No PAN/CVV storage
- [ ] Server-side amount verification matches booking
- [ ] Webhook idempotency
- [ ] Refund permissions restricted
- [ ] Daily reconciliation job monitored

## Mobile / Web Clients

- [ ] Certificate pinning decision documented (optional early)
- [ ] Deep links validated
- [ ] Web XSS: CSP on website & admin
- [ ] Dependency vulnerability scan in CI

## Infrastructure

- [ ] Secrets in secret manager / GitHub Secrets — not git
- [ ] Least-privilege cloud IAM
- [ ] Container non-root user
- [ ] DB not publicly reachable
- [ ] Redis AUTH + network isolation
- [ ] S3 buckets private; signed URLs only

## Security Release Gate

All unchecked items blocking for the touched area must be resolved or explicitly waived in the PR with expiry date.
