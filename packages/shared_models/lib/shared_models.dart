/// Phase 1 stub. Shared DTOs/enums arrive with API contracts (Phase 3+).
enum AppSurface { customer, owner, admin }

class AppVersion {
  const AppVersion(this.value);
  final String value;
}
