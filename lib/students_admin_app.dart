import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:student_app_admin/core/routes/app_router.dart';
import 'package:student_app_admin/core/theme/app_theme.dart';

class StudentsAdminApp extends StatelessWidget {
  StudentsAdminApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, screenType) {
      return MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
      );
    });
  }
}
