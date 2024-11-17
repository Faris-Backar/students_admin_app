import 'package:flutter/material.dart';

extension ThemeContext on BuildContext {
  // Access the entire ColorScheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  // Access specific colors from the ColorScheme
  Color get primaryColor => colorScheme.primary;
  Color get secondaryColor => colorScheme.secondary;
  Color get backgroundColor => colorScheme.background;
  Color get surfaceColor => colorScheme.surface;
  Color get onPrimaryColor => colorScheme.onPrimary;
  Color get onSecondaryColor => colorScheme.onSecondary;
  Color get onBackgroundColor => colorScheme.onBackground;
  Color get onSurfaceColor => colorScheme.onSurface;
  Color get errorColor => colorScheme.error;
}
