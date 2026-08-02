import 'package:flutter/material.dart';
import 'package:shared_ui/src/theme/app_spacing.dart';

/// Page chrome primitive: safe area + consistent horizontal/vertical padding.
class AppPage extends StatelessWidget {
  const AppPage({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}
