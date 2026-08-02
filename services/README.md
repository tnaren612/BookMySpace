# Service Extraction Slots

Physical microservices are **not deployed yet**. Domain logic starts in `backend/platform-api` packages (see ADR-001).

| Folder | Monolith package | Extract when |
|--------|------------------|--------------|
| `auth-service/` | `identity` | Independent scale/auth team or IdP complexity |
| `venue-service/` | `venue` | Catalog write load or team split |
| `booking-service/` | `booking` | Hot path scale / isolation needs |
| `payment-service/` | `payment` | PCI/compliance or payout complexity |
| `notification-service/` | `notification` | High fan-out / provider isolation |
| `search-service/` | `search` | OpenSearch extraction (ADR-007) |

Each subfolder README points to the monolith package until extraction.
