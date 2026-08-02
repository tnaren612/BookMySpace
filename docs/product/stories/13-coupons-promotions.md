# Stories — Coupons & Promotions (US-154–US-163)

**Module:** COUP | **FRs:** FR-COUP-*

---

### US-154 — Apply platform coupon at checkout
**As a** customer, **I want** to apply a coupon code, **so that** I get a discount.  
**FR:** FR-COUP-01/04 | **P1**  
**AC:**
- AC-154-01: Server validates all constraints (BR-COUP-01).
- AC-154-02: Discount reflected in payable.
- AC-154-03: Invalid codes clear errors.

### US-155 — Create owner coupon
**As a** Professional owner, **I want** to create coupons, **so that** I can fill off-peak inventory.  
**FR:** FR-COUP-02 | **P1**  
**AC:**
- AC-155-01: Plan-gated.
- AC-155-02: Percent/fixed INR.
- AC-155-03: Expiry + usage caps.

### US-156 — Coupon min booking amount
**As a** platform, **I want** min amount rules, **so that** coupons aren’t abused on tiny bookings.  
**FR:** FR-COUP-03 | **P1**  
**AC:**
- AC-156-01: Reject below min.
- AC-156-02: Message shows required min.

### US-157 — Per-user coupon cap
**As a** platform, **I want** per-user usage caps, **so that** one user can’t drain a campaign.  
**FR:** FR-COUP-03 | **P1**  
**AC:**
- AC-157-01: Cap enforced atomically.
- AC-157-02: Concurrent applies don’t exceed.

### US-158 — Featured listing purchase/credit
**As an** owner, **I want** to feature my venue, **so that** I appear higher in discovery.  
**FR:** FR-COUP-05 | **P1**  
**AC:**
- AC-158-01: Consumes featured credit or paid boost.
- AC-158-02: Time-boxed boost window.
- AC-158-03: Search ranking accounts for boost.

### US-159 — Disable coupon
**As an** owner/admin, **I want** to disable a coupon, **so that** I can stop a campaign.  
**FR:** FR-COUP-02 | **P1**  
**AC:**
- AC-159-01: New applies fail.
- AC-159-02: Existing bookings unchanged.

### US-160 — Stacking rules
**As a** customer, **I want** predictable stacking, **so that** I’m not surprised at pay.  
**FR:** BR-COUP-01 | **P1**  
**AC:**
- AC-160-01: Default no double percent stack.
- AC-160-02: UI shows final amount only after server quote.
- AC-160-03: Payable never below ₹1 unless admin comp (BR-COUP-02).

### US-161 — Category/city constrained coupon
**As a** marketer, **I want** coupons limited by city/category, **so that** campaigns stay targeted.  
**FR:** FR-COUP-03 | **P1**  
**AC:**
- AC-161-01: Constraints enforced server-side.
- AC-161-02: Wrong city/category fails clearly.

### US-162 — Referral code (later)
**As a** customer, **I want** referral rewards, **so that** I invite friends.  
**FR:** FR-COUP-06 | **P2**  
**AC:**
- AC-162-01: Unique referral codes.
- AC-162-02: Reward after referred first confirmed booking.
- AC-162-03: Fraud controls (self-referral blocked).

### US-163 — Promo banner in app
**As a** marketer, **I want** in-app banners, **so that** campaigns are visible.  
**FR:** FR-CMS-03 | **P1**  
**AC:**
- AC-163-01: Flagged content.
- AC-163-02: Dismissible.
- AC-163-03: Not on payment webview critical path clutter.
