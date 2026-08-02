# Stories — CMS & Marketing (US-228–US-237)

**Module:** CMS | **FRs:** FR-CMS-*

---

### US-228 — Edit legal pages
**As an** admin, **I want** to publish Terms/Privacy/Cancellation pages, **so that** compliance copy is live.  
**FR:** FR-CMS-05 | **P0**  
**AC:**
- AC-228-01: SSR routes render content.
- AC-228-02: Version/publish workflow.
- AC-228-03: Public without auth.

### US-229 — City landing content
**As a** marketer, **I want** editable city landing blocks, **so that** SEO pages convert.  
**FR:** FR-CMS-04 | **P1**  
**AC:**
- AC-229-01: Per-city headline/body/FAQ.
- AC-229-02: Preview before publish.
- AC-229-03: Falls back to template if empty.

### US-230 — Category landing content
**As a** marketer, **I want** category page content, **so that** banquet vs sports messaging differs.  
**FR:** FR-CMS-04 | **P1**  
**AC:**
- AC-230-01: Per-category fields.
- AC-230-02: Linked to taxonomy ids.
- AC-230-03: Crawlable.

### US-231 — Blog/help articles
**As a** content editor, **I want** to publish help/blog posts, **so that** users self-serve.  
**FR:** FR-CMS-02 | **P1**  
**AC:**
- AC-231-01: Title, body, slug, SEO meta.
- AC-231-02: Draft/publish.
- AC-231-03: Sitemap inclusion.

### US-232 — In-app announcement
**As a** marketer, **I want** announcements, **so that** I communicate launches.  
**FR:** FR-CMS-03 | **P1**  
**AC:**
- AC-232-01: Targeting by app (customer/owner).
- AC-232-02: Schedule start/end.
- AC-232-03: Dismissible; not blocking pay.

### US-233 — UTM landing support
**As a** growth manager, **I want** UTM parameters preserved to app deep links, **so that** attribution works.  
**FR:** FR-CMS-06 | **P1**  
**AC:**
- AC-233-01: UTMs captured on website.
- AC-233-02: Passed into app session analytics.
- AC-233-03: No PII in UTM abuse logs beyond need.

### US-234 — Home page hero CMS
**As a** marketer, **I want** to update website hero copy/CTA, **so that** campaigns stay fresh.  
**FR:** FR-CMS-01 | **P1**  
**AC:**
- AC-234-01: Brand-first fields (product name prominence).
- AC-234-02: CTA targets search or app.
- AC-234-03: Preview.

### US-235 — Help center search
**As a** user, **I want** to search help articles, **so that** I solve issues myself.  
**FR:** FR-CMS-02 | **P1**  
**AC:**
- AC-235-01: Keyword search.
- AC-235-02: Empty state.
- AC-235-03: Deep link to ticket create.

### US-236 — Cancellation policy public page
**As a** customer, **I want** platform cancellation explanation, **so that** I understand refunds.  
**FR:** FR-CMS-05 | **P0**  
**AC:**
- AC-236-01: Explains template A defaults + venue overrides note.
- AC-236-02: Linked from booking UI.
- AC-236-03: Updated with version date.

### US-237 — Feature flag content kill-switch
**As an** admin, **I want** to disable a campaign banner via flag, **so that** bad creatives can be killed fast.  
**FR:** FR-ADM-05, FR-CMS-03 | **P1**  
**AC:**
- AC-237-01: Flag hides banner globally.
- AC-237-02: No deploy required.
- AC-237-03: Audited change.
