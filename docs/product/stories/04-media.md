# Stories — Media (US-046–US-053)

**Module:** MEDIA | **FRs:** FR-MEDIA-*

---

### US-046 — Request upload URL
**As an** owner, **I want** a presigned upload URL, **so that** images go to S3 without passing through API memory.  
**FR:** FR-MEDIA-01 | **P0**  
**AC:**
- AC-046-01: Returns URL + media metadata id for allowed types.
- AC-046-02: Unauthorized users denied.
- AC-046-03: Object key prefixed `org/{organizationId}/...`.

### US-047 — Complete upload registration
**As an** owner, **I want** uploaded media attached to venue, **so that** gallery shows photos.  
**FR:** FR-MEDIA-01 | **P0**  
**AC:**
- AC-047-01: Confirm endpoint verifies object exists/size/type.
- AC-047-02: Rejects oversize/type (FR-MEDIA-02).
- AC-047-03: Appears on venue draft gallery.

### US-048 — Set cover photo
**As an** owner, **I want** to choose cover image, **so that** search cards look right.  
**FR:** FR-MEDIA-04 | **P0**  
**AC:**
- AC-048-01: Exactly one cover at a time.
- AC-048-02: Cover required for publish minimums.

### US-049 — Reorder gallery
**As an** owner, **I want** to reorder photos, **so that** best shots appear first.  
**FR:** FR-MEDIA-04 | **P0**  
**AC:**
- AC-049-01: Order persisted.
- AC-049-02: Public detail respects order.

### US-050 — Delete media
**As an** owner, **I want** to delete a photo, **so that** outdated images are removed.  
**FR:** FR-MEDIA-04 | **P0**  
**AC:**
- AC-050-01: Deletes metadata; object lifecycle handled.
- AC-050-02: Cannot delete last photos below publish minimum while PUBLISHED without replacing.
- AC-050-03: Cross-org delete denied.

### US-051 — CDN public read
**As a** customer, **I want** fast image loads, **so that** browsing is smooth.  
**FR:** FR-MEDIA-03 | **P0**  
**AC:**
- AC-051-01: Published media readable via CDN/public URL strategy.
- AC-051-02: Draft media not publicly listable.
- AC-051-03: Meets size guidelines guidance in NFR-PERF-06.

### US-052 — Media plan limits
**As a** free-plan owner, **I want** clear errors when over photo limits, **so that** I know to upgrade.  
**FR:** FR-MEDIA-05, BR-SUB-01 | **P1**  
**AC:**
- AC-052-01: Enforce per-plan photo caps.
- AC-052-02: Error includes upgrade hint code.

### US-053 — Reject unsafe files
**As a** platform, **I want** unsafe files rejected, **so that** malware/risk is reduced.  
**FR:** FR-MEDIA-02 | **P0**  
**AC:**
- AC-053-01: Non-image types rejected for image slots.
- AC-053-02: Clear error to client.
- AC-053-03: Attempt logged for abuse metrics.
