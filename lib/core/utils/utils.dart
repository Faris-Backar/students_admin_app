import 'package:flutter/material.dart';
import 'package:student_app_admin/core/app_core.dart';
import 'package:student_app_admin/core/extensions/extensions.dart';
import 'package:student_app_admin/core/theme/app_theme.dart';

class AppUtils {
  AppUtils._();

  static showSnackBar(BuildContext context,
          {required String content, bool? isForErrorMessage}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          content,
          style: context.textTheme.bodySmall,
        ),
        backgroundColor:
            isForErrorMessage == true ? Colors.red : AppTheme.darkPurple,
      ));

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailCannotBeEmpty;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return AppStrings.enterValidEmail;
    }
    return null;
  }

  static String? passWordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  static String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    } else if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(value)) {
      return 'Full name can only contain letters and spaces';
    } else if (value.trim().split(' ').length < 2) {
      return 'Please enter your full name';
    } else if (value.length < 3) {
      return 'Full name must be at least 3 characters long';
    }
    return null;
  }

  static String? mobileNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }
}
