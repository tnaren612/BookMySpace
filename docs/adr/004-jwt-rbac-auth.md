# ADR-004: JWT Access Tokens + Refresh Rotation + RBAC

- **Status:** Accepted
- **Date:** 2026-08-02

## Context

Mobile and web clients need stateless auth at the edge, revoke capability, and fine-grained authorization across platform and organization roles.

## Decision

- **Access token:** JWT, short-lived (e.g. 15 minutes), contains `sub`, roles, token version.
- **Refresh token:** Opaque, stored hashed server-side, rotated on use, family revocation on reuse detection.
- **RBAC:** Permission strings checked in application layer; org-scoped permissions require membership.
- Transport: HTTPS only; secure storage on clients (Keychain/Keystore; no shared prefs for refresh tokens).

## Consequences

- Mobile offline UX must handle 401 → refresh → retry
- Requires refresh token storage table and rotation logic
- MFA can be added later without changing resource authorization model

## Alternatives Considered

1. Session cookies only — poor fit for mobile APIs.
2. Long-lived JWTs without refresh — rejected (theft window).
3. OAuth2 Authorization Server product (Keycloak) day one — deferred until multi-IdP demand.
