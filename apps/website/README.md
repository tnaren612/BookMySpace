# BookMySpace Website (SSR / SEO)

**Status:** Placeholder only (Phase 1).

## Decision (ADR-002)

Marketing and public venue SEO pages live here as an **SSR/SSG** site.

Framework choice is **TBD between Next.js and Astro**. Do not scaffold a full framework in this folder until the decision is recorded in an ADR update and Phase 15 (or an earlier intentional SEO spike) begins.

## Intended contents (later)

```
apps/website/
├── src/
├── public/
├── package.json
└── README.md   # this file
```

## Rules

- Public GET APIs only from this surface
- Deep-link into `customer_flutter` for transactional booking flows
- No secrets in client bundles
