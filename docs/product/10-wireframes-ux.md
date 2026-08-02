# 10 — Wireframes & UX Guidelines

**Document ID:** PRD-10  
**Clients:** Customer Flutter, Owner Flutter, Admin Flutter Web, SSR Website  
**Design system:** Material 3 via `packages/shared_ui` (ADR-002, eng Phase 4)

This document describes **screen intent and structure** — not pixel comps. Designers produce Figma from these specs.

---

## 1. UX principles (normative)

1. **Brand first** on marketing/landing: “BookMySpace” is a hero-level signal; tagline *One Platform. Every Bookable Space.*  
2. **≤3 taps** for primary book path where domain allows.  
3. **One job per screen/section.**  
4. **Calendar is source of truth** for owners.  
5. **Server truth** for price and availability — never trust client alone.  
6. **Honest states:** every major screen defines loading, empty, error, offline.  
7. **India-first:** INR, +91 phones, UPI-first payment UX, WhatsApp as channel not clutter.  
8. Align with architecture UI notes: Material 3, shared tokens, light/dark, a11y.

---

## 2. Global chrome

### 2.1 Customer app

| Element | Spec |
|---------|------|
| Header | Logo mark + city selector + optional search field |
| Bottom nav (mobile) | Home, Search, Bookings, Wishlist, Profile |
| Rail/nav (tablet/desktop) | Same destinations |
| Footer (web app) | Help, Legal, City links — lighter than SSR marketing footer |
| FAB | Avoid; primary CTAs in content |

### 2.2 Owner app

| Element | Spec |
|---------|------|
| Header | Org switcher + venue filter |
| Bottom/rail nav | Home/Dashboard, Calendar, Bookings, Venues, More (payouts, team, plan) |
| Alerts | Request-to-book badge on Bookings |

### 2.3 Admin web

| Element | Spec |
|---------|------|
| Side nav | Lookup, Verification, Moderation, Tickets, Flags, Taxonomy, Audit, Reports |
| Top bar | Environment badge (staging/prod), user menu |
| Dense tables | OK for admin; still a11y-compliant |

### 2.4 SSR website

| Element | Spec |
|---------|------|
| Header | Brand wordmark dominant, Search CTA, Login/App |
| Footer | Cities, categories, legal, contact |
| Hero | Full-bleed atmosphere image of real venues; brand + one headline + one sentence + CTA — no stat strips/cards in first viewport |

---

## 3. Customer screens

For each: **purpose · layout · primary buttons · empty · loading · error · responsive**

### C-01 Home
- **Purpose:** Start discovery.  
- **Layout:** Brand greeting, city chip, category shortcuts, featured row (not card-heavy clutter).  
- **Buttons:** Search, select city, category.  
- **Empty:** No featured → show popular cities.  
- **Loading:** Skeleton for rows.  
- **Error:** Retry.  
- **R:** Mobile stack; tablet 2-col categories; desktop wider discovery.

### C-02 Search results
- **Purpose:** Browse/filter venues.  
- **Layout:** Filter chips + list/map toggle; result rows with photo, name, rating, price from, distance.  
- **Buttons:** Apply filters, sort, open venue, map.  
- **Empty:** Suggestions to broaden (US-063).  
- **Loading:** List skeletons.  
- **Error:** Retry + offline message.  
- **R:** List primary on mobile; split map on tablet/desktop.

### C-03 Venue detail
- **Purpose:** Decide + start book.  
- **Layout:** Gallery, title, verified badge, amenities, map, policies, reviews teaser, sticky Book CTA.  
- **Buttons:** Book, Wishlist, Share, Directions, See calendar.  
- **Empty:** N/A (404 if missing).  
- **Loading:** Image placeholders.  
- **Error:** Retry sections independently if needed.  
- **R:** Sticky CTA bottom mobile; side panel CTA desktop.

### C-04 Slot / date picker
- **Purpose:** Choose inventory unit + time.  
- **Layout:** Unit selector, calendar, slot chips, price quote.  
- **Buttons:** Continue (hold).  
- **Empty:** No slots → suggest other dates.  
- **Loading:** Slot skeleton.  
- **Error:** Conflict message.  
- **R:** Full screen mobile; modal/side sheet desktop.

### C-05 Checkout / pay
- **Purpose:** Confirm amount + pay.  
- **Layout:** Summary, coupon field, breakdown (base, tax, discount), TTL countdown, Pay CTA.  
- **Buttons:** Pay with Razorpay, Apply coupon, Cancel.  
- **Empty:** N/A.  
- **Loading:** Disabling Pay, spinner.  
- **Error:** Payment failed → retry; hold expired → recover (US-108).  
- **R:** Single column always for trust.

### C-06 Booking confirmation
- **Purpose:** Relief + next steps.  
- **Layout:** Success, booking code, when/where, add to calendar, share.  
- **Buttons:** View booking, Home.  
- **Loading:** Confirming payment state if webhook pending.  
- **Error:** “Taking longer” + support CTA.

### C-07 My bookings
- **Purpose:** Manage upcoming/past.  
- **Layout:** Tabs + list rows.  
- **Empty:** CTA to search.  
- **Error:** Retry.

### C-08 Booking detail
- **Purpose:** Single booking ops.  
- **Buttons:** Cancel, Pay remaining, Review, Invoice, Support.  
- **States:** Per booking status colors (not rainbow clutter — 1 accent system).

### C-09 Wishlist / Profile / Prefs / Support
- Standard list + forms; preference center toggles; ticket create form.

---

## 4. Owner screens

### O-01 Owner home
- Today’s arrivals, pending requests, occupancy snapshot, CTA: open calendar.

### O-02 Calendar day/week
- **Purpose:** Operate inventory.  
- **Layout:** Time grid; color for confirmed/hold/block; tap to detail.  
- **Buttons:** Block, Add manual booking, Switch unit.  
- **Empty:** Free day messaging.  
- **Error:** Sync retry.  
- **R:** Day default mobile; week tablet+.

### O-03 Venue list / editor / media / pricing
- Multi-step editor with publish checklist (progress).  
- Media grid with cover badge.  
- Pricing rules form with preview quote.

### O-04 Bookings inbox
- Requests first; accept/reject with reason.  
- Filters by venue/status.

### O-05 Earnings / plan / team
- Ledger list; payout profile; plan meter; invite members.

### O-06 Reports
- Simple charts + CSV; avoid dashboard soup — 3 widgets max above fold.

---

## 5. Admin screens

### A-01 Lookup
- Omnibox search → entity tabs (user/org/venue/booking).

### A-02 Verification queue
- Card/table of pending; side panel evidence; Approve/Reject.

### A-03 Moderation / Tickets / Flags / Audit
- Dense but readable tables; reason modals required for destructive actions.

---

## 6. Website screens

### W-01 Home (hero budget)
- Full-bleed venue atmosphere; **BookMySpace** brand; one headline; one supporting sentence; CTA group (Find a space / List your space). No stats/cards in first viewport.

### W-02 City / Category / Venue public
- SEO content + listing results or venue profile; Book CTA deep link.

### W-03 Help / Legal / Blog
- Readable typography; footer nav.

---

## 7. UX guidelines detail

### 7.1 Material 3 & tokens
- Use shared color, type, elevation, shape tokens from `shared_ui`.  
- Avoid purple-on-white AI-default clichés; choose a distinctive India-venue direction (e.g., deep teal + warm sand + ink) — finalize in design system, not ad hoc per screen.  
- Prefer intentional motion (2–3): page transitions, hold countdown pulse, confirm success.

### 7.2 Accessibility
- WCAG 2.2 AA target for primary flows.  
- Touch ≥ 48×48 dp.  
- Labels on icons; announce status changes (confirm/cancel).  
- Don’t rely on color alone for booking status.

### 7.3 Typography & spacing
- Expressive brand font on marketing; readable UI font in apps (via design tokens — not system default stacks unmanaged).  
- 4/8 dp spacing grid.  
- Clear hierarchy: title → meta → body → CTA.

### 7.4 Color & dark mode
- Light + dark from day one tokens (Phase 4).  
- Sufficient contrast on photos (scrim behind text if needed on website hero only — avoid badge clutter overlays).

### 7.5 Responsive breakpoints
| Breakpoint | Width | Pattern |
|------------|-------|---------|
| Mobile | <600 | Bottom nav, stacked |
| Tablet | 600–1024 | Nav rail, split views |
| Desktop | >1024 | Max content width ~1200, side panels |

### 7.6 Forms & errors
- Inline field errors; Problem Details mapped to human copy.  
- Idempotent buttons (Pay, Confirm) show progress and ignore double taps.

### 7.7 Localization readiness
- EN first; string catalog externalized.  
- INR + en-IN number/date formats; Asia/Kolkata display.

---

## 8. Screen → story map (sample)

| Screen | Stories |
|--------|---------|
| C-02 Search | US-054–068 |
| C-05 Pay | US-111–116 |
| O-02 Calendar | US-077–090 |
| A-02 Verify | US-246–247 |
| W-02 City | US-273 |
