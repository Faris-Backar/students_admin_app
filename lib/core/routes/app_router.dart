import 'package:auto_route/auto_route.dart';
import 'package:student_app_admin/core/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: LoginRoute.page,
          path: PageResources.login,
        ),
        AutoRoute(
            page: LandingRoute.page,
            path: PageResources.landingPage,
            initial: true),
        AutoRoute(page: HomeRoute.page, path: PageResources.home),
        AutoRoute(
          page: DashboardRoute.page,
          path: PageResources.dashboard,
          children: [
            AutoRoute(
                page: HomeRoute.page,
                path: PageResources
                    .homeNested), // child route without leading "/"
            AutoRoute(page: StudentsRoute.page, path: PageResources.students),
            AutoRoute(page: CampaignRoute.page, path: PageResources.campaign),
            AutoRoute(page: SettingsRoute.page, path: PageResources.settings),
          ],
        ),
      ];
}

class PageResources {
  PageResources._();
  static const String login = "/login";
  static const String home = "/home"; // Top-level route with leading "/"
  static const String dashboard =
      "/dashboard"; // Top-level route with leading "/"

  // Nested routes without leading "/"
  static const String homeNested = "home";
  static const String students = "students";
  static const String campaign = "campaign";
  static const String settings = "settings";
  static const String landingPage = "/landing";
}
