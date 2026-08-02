# API Contracts

OpenAPI specifications for BookMySpace public APIs.

```
openapi/
  v1/
    openapi.yaml    # added in Phase 2
```

Rules:

- Contract-first for public endpoints
- Breaking changes require `/api/v2` (see API versioning strategy)
- CI should fail on unintentional breaking diffs once spectral/oasdiff is wired
