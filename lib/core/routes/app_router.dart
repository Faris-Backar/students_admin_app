import 'package:auto_route/auto_route.dart';
import 'package:student_app_admin/core/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page, path: PageResources.login),
        AutoRoute(
          page: HomeRoute.page,
          path: PageResources.home,
        ),
        AutoRoute(
          page: DashboardRoute.page,
          path: PageResources.dashboard,
          initial: true,
        ),
      ];
}

class PageResources {
  PageResources._();
  static const String login = "/login";
  static const String home = "/home";
  static const String dashboard = "/dashboard";
}
