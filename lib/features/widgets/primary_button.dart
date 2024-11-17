import 'package:flutter/material.dart';
import 'package:student_app_admin/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final String label;
  final VoidCallback? onTap;
  final bool? isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const PrimaryButton(
      {super.key,
      this.child,
      required this.label,
      this.onTap,
      this.isLoading,
      this.backgroundColor,
      this.foregroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.darkPurple,
          foregroundColor: foregroundColor ?? AppTheme.white,
        ),
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ))
            : child ?? Text(label));
  }
}
