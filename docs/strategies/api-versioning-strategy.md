# API Versioning Strategy

**Related ADR:** [005](../adr/005-api-versioning.md)

## Version Format

```
https://api.bookmyspace.in/api/v1/...
```

- Current: **v1**
- Integer versions only (`v1`, `v2`)

## Compatibility Policy

### Non-breaking (allowed in v1)

- Add optional response field
- Add new endpoint
- Add optional request field with default
- Add enum value **only if** clients tolerate unknowns (document; prefer feature flags for new modes)

### Breaking (requires v2)

- Remove/rename field
- Change field type/meaning
- Make optional field required
- Change auth scheme
- Change error `code` semantics for existing codes

## Deprecation

1. Announce in changelog + `Deprecation` / `Sunset` headers where applicable
2. Minimum **90 days** overlap for mobile clients
3. Telemetry on old version usage before removal
4. Remove only when usage below agreed threshold

## Documentation

- OpenAPI per version under `packages/api_contracts/openapi/v1/`
- Changelog: `docs/api/CHANGELOG.md` (created when first endpoint ships)

## Client Rules

- Apps pin to a major API version
- Unknown fields ignored (forward compatible parsers)
- Unknown error codes → generic handler
