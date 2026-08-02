/// Returns true when [value] is null or only whitespace.
bool isBlank(String? value) => value == null || value.trim().isEmpty;

/// Non-blank guard used by clients before calling APIs.
String requireNonBlank(String? value, {String name = "value"}) {
  if (isBlank(value)) {
    throw ArgumentError.value(value, name, "must not be blank");
  }
  return value!.trim();
}
