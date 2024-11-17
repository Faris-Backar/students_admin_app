import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:student_app_admin/core/di/shared_preference_manager.dart';
import 'package:student_app_admin/core/resources/shared_prefs_resources.dart';
import 'package:student_app_admin/core/routes/app_router.gr.dart';

@RoutePage()
class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  init() async {
    final isLoggedIn =
        SharedPrefManager.getBool(SharedPrefsResources.isLoggedin);
    if (isLoggedIn) {
      AutoRouter.of(context).replaceAll([const DashboardRoute()]);
    } else {
      AutoRouter.of(context).replaceAll([const LoginRoute()]);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async => init());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
