# Complete Folder Structure

This is the **authoritative** monorepo layout. Empty directories exist today; code arrives phase-by-phase.

```
bookmyspace/
├── README.md
├── LICENSE
├── .gitignore
├── .editorconfig
├── .github/
│   └── workflows/
│       ├── ci-backend.yml              # Phase 2+
│       ├── ci-flutter.yml              # Phase 2+
│       ├── ci-website.yml              # Phase 2+
│       └── deploy.yml                  # Phase 3+
│
├── apps/
│   ├── customer_flutter/
│   │   ├── lib/
│   │   │   ├── app/
│   │   │   ├── core/
│   │   │   ├── design_system/
│   │   │   └── features/
│   │   ├── test/
│   │   ├── integration_test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   │
│   ├── owner_flutter/
│   │   ├── lib/
│   │   │   ├── app/
│   │   │   ├── core/
│   │   │   ├── design_system/
│   │   │   └── features/
│   │   ├── test/
│   │   ├── integration_test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   │
│   ├── admin_web/
│   │   ├── lib/
│   │   ├── test/
│   │   ├── pubspec.yaml
│   │   └── README.md
│   │
│   └── website/                        # SSR/SSG (Next.js or Astro)
│       ├── src/
│       ├── public/
│       ├── package.json
│       └── README.md
│
├── services/                           # Physical services AFTER extraction
│   ├── auth-service/                   # Extracted from identity package
│   ├── booking-service/
│   ├── venue-service/
│   ├── payment-service/
│   ├── notification-service/
│   └── search-service/
│
├── backend/                            # Phase 1 modular monolith (RECOMMENDED ADD)
│   └── platform-api/                   # Single Spring Boot app
│       ├── src/main/java/com/bookmyspace/
│       │   ├── bootstrap/
│       │   ├── shared/
│       │   ├── identity/
│       │   ├── venue/
│       │   ├── booking/
│       │   ├── payment/
│       │   ├── notification/
│       │   └── search/
│       ├── src/main/resources/
│       ├── src/test/java/
│       ├── build.gradle.kts
│       └── README.md
│
├── packages/
│   ├── shared_models/                  # Cross-app DTOs / enums (Dart)
│   │   ├── lib/
│   │   ├── test/
│   │   └── pubspec.yaml
│   ├── shared_ui/                      # Design system (Flutter)
│   │   ├── lib/
│   │   ├── test/
│   │   └── pubspec.yaml
│   ├── common_utils/                   # Pure Dart helpers
│   │   ├── lib/
│   │   ├── test/
│   │   └── pubspec.yaml
│   └── api_contracts/                  # OpenAPI specs (RECOMMENDED ADD)
│       ├── openapi/
│       │   └── v1/
│       └── README.md
│
├── docs/
│   ├── README.md
│   ├── adr/
│   ├── architecture/
│   ├── standards/
│   ├── strategies/
│   ├── security/
│   └── roadmap/
│
└── infrastructure/
    ├── docker/
    │   ├── Dockerfile.platform-api
    │   ├── docker-compose.yml          # local: api, postgres, redis, mailhog
    │   └── README.md
    ├── environments/
    │   ├── local.env.example
    │   ├── staging.env.example
    │   └── production.env.example      # no secrets; names only
    └── github-actions/
        └── README.md                   # reusable workflow notes
```

## Important Addition vs Original Brief

| Path | Why added |
|------|-----------|
| `backend/platform-api/` | Houses the modular monolith before service extraction |
| `packages/api_contracts/` | Contract-first APIs; codegen later |
| `.editorconfig` | Consistent formatting across languages |

`services/*` remains reserved. Until extraction, those folders contain only a `README.md` pointing to the corresponding package inside `backend/platform-api`.

## Flutter Feature Template

```
features/{feature_name}/
├── data/
│   ├── datasources/
│   ├── dto/
│   ├── mappers/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/          # abstract ports
│   └── usecases/
└── presentation/
    ├── providers/
    ├── screens/
    ├── widgets/
    └── controllers/           # if needed
```

## Backend Context Template

```
{context}/
├── api/
│   ├── {Context}Controller.java
│   ├── request/
│   └── response/
├── application/
│   ├── command/
│   ├── query/
│   └── {UseCase}.java
├── domain/
│   ├── model/
│   ├── event/
│   ├── exception/
│   └── port/
└── infrastructure/
    ├── persistence/
    ├── messaging/
    └── client/
```

## Ownership Rules

1. Apps may depend on `packages/*`, never on other apps.
2. Backend contexts may depend on `shared/`, never on another context’s `infrastructure`.
3. Cross-context calls go through application APIs or events — not JPA entities.
4. `website` may call public GET APIs only.
5. No secrets in git; only `*.env.example` files.
