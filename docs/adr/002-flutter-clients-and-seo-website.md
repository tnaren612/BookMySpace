# ADR-002: Flutter Clients + SSR Marketing Website

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

We need mobile-first apps for customers and owners, an admin console, and SEO-friendly public pages for city/venue discovery across India.

Flutter Web is excellent as an **application** runtime but weak for organic SEO (content indexing, social previews, crawlable HTML).

## Decision

| Surface | Technology |
|---------|------------|
| Customer app | Flutter (iOS, Android, Web app shell) |
| Owner app | Flutter (iOS, Android, Web) |
| Admin | Flutter Web initially |
| Marketing + public venue SEO pages | SSR/SSG site in `apps/website` (Next.js or Astro) |

Public pages deep-link into the customer Flutter app for booking.

## Consequences

- Best SEO growth channel without abandoning Flutter productivity
- Two web stacks to maintain (acceptable; different jobs)
- Shared design tokens documented; pixel-perfect parity not required between marketing site and app

## Alternatives Considered

1. Flutter Web for everything — rejected for SEO.
2. React Native + Next.js — rejected; Flutter already chosen for product apps.
