# Git Branching Strategy

## Model

**Trunk-based development with short-lived feature branches.**

```
main            # production-ready; protected
  └── develop   # optional integration branch (use if team > ~8); else skip and use main + flags
       └── feat/* fix/* chore/* docs/* security/*
```

### Recommendation for early team

- Default branch: **`main`**
- Feature branches off `main`
- Merge via squash or rebase PR (team preference: **squash**)
- Release tags: `vMAJOR.MINOR.PATCH`
- Hotfixes: `fix/*` from `main`, PR back to `main`

Use `develop` only if release trains need a longer stabilization buffer.

## Branch Naming

```
feat/owner-calendar-basics
fix/hold-ttl-race
docs/adr-011-media
chore/gradle-upgrade
security/refresh-token-rotation
ci/path-filters
```

## Protection Rules (`main`)

- Require PR + 1 approval (2 when team grows)
- Require CI green
- Require linear history (squash)
- No direct pushes
- No force push

## Commit Messages

Conventional Commits:

```
feat(venue): add publish state transition
fix(booking): prevent hold overlap on same unit
docs(adr): accept modular monolith
```

## Versioning

- Apps: semver tags per artifact if needed (`customer-flutter@1.2.0`)
- API: URL version (`v1`) independent of app semver
- Database: sequential Flyway versions

## Release Flow

1. PR → `main`
2. Tag release / auto-tag from CI
3. Deploy staging → smoke → prod
4. Hotfix follows same path with expedited review
