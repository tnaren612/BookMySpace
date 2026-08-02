# Stories — Website & SEO (US-272–US-279)

**Module:** WEB | **FRs:** FR-WEB-* | **ADR-002**

---

### US-272 — SSR home page
**As a** visitor, **I want** a crawlable home page, **so that** I discover BookMySpace via search engines.  
**FR:** FR-WEB-01 | **P0**  
**AC:**
- AC-272-01: Server-rendered HTML with brand hero.
- AC-272-02: CTA to search/cities.
- AC-272-03: LCP within NFR budget.

### US-273 — City landing pages
**As a** visitor, **I want** city pages (e.g., Jaipur banquet halls), **so that** local intent converts.  
**FR:** FR-WEB-01/05 | **P0**  
**AC:**
- AC-273-01: Crawlable without auth.
- AC-273-02: Lists published venues via public API.
- AC-273-03: Canonical URL + meta.

### US-274 — Category pages
**As a** visitor, **I want** category landings, **so that** sports vs halls are distinct SEO entries.  
**FR:** FR-WEB-01 | **P0**  
**AC:**
- AC-274-01: Category content + listings.
- AC-274-02: Sitemap entries.
- AC-274-03: Feature-flagged categories omitted.

### US-275 — Public venue SEO page
**As a** visitor, **I want** a public venue page, **so that** shared links preview well and rank.  
**FR:** FR-WEB-01/03 | **P0**  
**AC:**
- AC-275-01: Unpublished → 404.
- AC-275-02: OG/meta correct.
- AC-275-03: Book CTA deep-links to app/web checkout.

### US-276 — Sitemap & robots
**As a** search engine, **I want** sitemap/robots, **so that** indexing is efficient.  
**FR:** FR-WEB-02 | **P0**  
**AC:**
- AC-276-01: Sitemap includes city/category/venue URLs.
- AC-276-02: Disallow private app routes.
- AC-276-03: Regenerates on publish cadence.

### US-277 — App deep links from website
**As a** mobile user, **I want** website CTAs to open the customer app, **so that** booking is seamless.  
**FR:** FR-WEB-04 | **P0**  
**AC:**
- AC-277-01: Deep link with venue/booking context.
- AC-277-02: Fallback to web/app store.
- AC-277-03: UTM preserved when possible.

### US-278 — Core Web Vitals budget
**As a** growth team, **I want** CWV within budget, **so that** SEO isn’t penalized.  
**FR:** FR-WEB-03 | **P0**  
**AC:**
- AC-278-01: Lighthouse SEO threshold on templates.
- AC-278-02: Image optimization.
- AC-278-03: Monitoring on key templates.

### US-279 — Help/legal on website
**As a** visitor, **I want** help and legal pages on the site, **so that** trust and compliance are visible.  
**FR:** FR-WEB-06, FR-CMS-05 | **P1**  
**AC:**
- AC-279-01: Routes live.
- AC-279-02: Linked in footer.
- AC-279-03: Mobile responsive.
