import 'package:flutter/material.dart';

/// Typography foundation. Phase 4 will swap in brand typefaces.
abstract final class AppTypography {
  static TextTheme textTheme(ColorScheme scheme) {
    final base = ThemeData(brightness: scheme.brightness).textTheme;
    return base.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );
  }
}
