# Stories — Maps & Geo (US-069–US-076)

**Module:** MAPS | **FRs:** FR-MAPS-*

---

### US-069 — Save venue coordinates
**As an** owner, **I want** to save lat/lng for my venue, **so that** customers can navigate.  
**FR:** FR-MAPS-01 | **P0**  
**AC:**
- AC-069-01: Validates numeric ranges.
- AC-069-02: India sanity check warnings/errors per policy.
- AC-069-03: Required for publish.

### US-070 — Radius search
**As a** customer, **I want** venues within X km, **so that** I find nearby spaces.  
**FR:** FR-MAPS-02 | **P0**  
**AC:**
- AC-070-01: Requires user/search center point.
- AC-070-02: Radius capped (e.g., 50 km) to protect perf.
- AC-070-03: Results include distance.

### US-071 — Bounding box search
**As a** map UI, **I want** bbox queries, **so that** panning the map updates results.  
**FR:** FR-MAPS-02 | **P1**  
**AC:**
- AC-071-01: Accepts sw/ne corners.
- AC-071-02: Rejects invalid boxes.
- AC-071-03: Debounce guidance documented for clients.

### US-072 — Map pins on results
**As a** customer, **I want** pins on a map, **so that** I compare locations visually.  
**FR:** FR-MAPS-03 | **P1**  
**AC:**
- AC-072-01: Pins for current result page/set.
- AC-072-02: Tap opens venue card.
- AC-072-03: Accessible list alternative exists.

### US-073 — Venue detail map
**As a** customer, **I want** a map on venue detail, **so that** I understand location context.  
**FR:** FR-MAPS-04 | **P0**  
**AC:**
- AC-073-01: Shows pin for venue.
- AC-073-02: Loading/error states defined.
- AC-073-03: Works offline-degraded with static coords text.

### US-074 — Directions deep link
**As a** customer, **I want** “Open in Maps”, **so that** I get turn-by-turn navigation.  
**FR:** FR-MAPS-04 | **P0**  
**AC:**
- AC-074-01: Opens Google/Apple maps with coordinates.
- AC-074-02: Fallback copy address.

### US-075 — City geo centers
**As a** marketing site, **I want** city center coordinates, **so that** city pages seed nearby search.  
**FR:** FR-MAPS-05 | **P1**  
**AC:**
- AC-075-01: City master data includes center.
- AC-075-02: Used by SSR city pages.

### US-076 — Distance sort
**As a** customer, **I want** nearest-first sorting, **so that** travel time is minimized.  
**FR:** FR-SEARCH-03, FR-MAPS-02 | **P1**  
**AC:**
- AC-076-01: Requires location permission or manual pin.
- AC-076-02: Stable ordering for equal distances.
