import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_app_admin/core/di/shared_preference_manager.dart';
import 'package:student_app_admin/firebase_options.dart';
import 'package:student_app_admin/students_admin_app.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefManager.initialise();
  runApp(ProviderScope(child: StudentsAdminApp()));
}
