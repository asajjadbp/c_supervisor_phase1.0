import 'dart:async';

import 'package:c_supervisor/main.dart';
import 'package:c_supervisor/ui/pages/clients_sku/clients_sku_page.dart';
import 'package:c_supervisor/ui/pages/my_coverage/filter/filter_my_coverage_page.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/check_list/check_list_page.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/my_jp_dashboard/my_jp_dashboard_page.dart';
import 'package:c_supervisor/ui/pages/my_jp/module/photo_activity/photo_page.dart';
import 'package:c_supervisor/ui/pages/team_attendance/filter/filter_team_attendance_page.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/filter/filter_team_jp_page.dart';
import 'package:c_supervisor/ui/pages/team_journey_plan/team_journey_plan_page.dart';
import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
import '../../ui/index.dart';
import '../../ui/pages/my_jp/my_jp_page.dart';
import '../../ui/pages/team_visits_history/team_visits_history_result/filter/filter_my_visit_history_page.dart';
import '../../ui/pages/team_visits_history/team_visits_history_result/team_visit_history_result_page.dart';

/// Contains all the possible routes of the app
class AppRouter {
  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: InitialRoutes.splash.route.path,
    refreshListenable: GoRouterRefreshStream(GetIt.I<AuthCubit>().stream),
    redirect: handleRedirect,
    routes: [
      ..._initialRoutes,
      ..._preAuthRoutes,
      ..._postAuthRoutes,
    ],
    errorPageBuilder: (ctx, state) {
      logger.e(state.error);
      return MaterialPage(
        key: state.pageKey,
        child: Container(),
      );
    },
  );

  static String? handleRedirect(
    BuildContext context,
    GoRouterState state,
  ) {
    final authCubit = GetIt.I<AuthCubit>();

    final isOnPreAuthRoute = PreAuthRoutes.searchRoutePath(state.fullPath!);

    final isOnSplashPage = InitialRoutes.splash.route.path == state.fullPath;

    /// Redirect user to login page if the user is not in any [PreAuthRoutes] and
    /// the current state is [UnauthorizedState]
    if (authCubit.state is UnauthorizedState && !isOnPreAuthRoute) {
      return PreAuthRoutes.login.route.path;
    }

    /// Redirect user to home page in case the current page isn't one of the
    /// [PostAuthRoutes]
    if (authCubit.state is AuthorizedState &&
        (isOnPreAuthRoute || isOnSplashPage)) {
      if (GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.checkedIn ??
          false) {
        return state.namedLocation(
          PostAuthRoutes.mainDashboard.name,
        );
      } else {
        return state.namedLocation(
          PostAuthRoutes.checkIn.name,
        );
      }
    }
    return null;
  }

  static final _initialRoutes = [
    GoRoute(
      name: InitialRoutes.splash.route.name,
      path: InitialRoutes.splash.route.path,
      pageBuilder: (context, state) => MaterialPage(
        name: InitialRoutes.splash.route.name,
        key: state.pageKey,
        child: const SplashPage(),
      ),
    ),
  ];

  /// Contains all the authentication routes
  static final _preAuthRoutes = [
    GoRoute(
      name: PreAuthRoutes.login.route.name,
      path: PreAuthRoutes.login.route.path,
      pageBuilder: (context, state) => MaterialPage(
        name: PreAuthRoutes.login.route.name,
        key: state.pageKey,
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      name: PreAuthRoutes.otpVerificationPage.route.name,
      path: PreAuthRoutes.otpVerificationPage.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: SendOtpPage(
          changePasswordArgs: state.extra as ChangePasswordArgs,
        ),
      ),
    ),
    GoRoute(
      name: PreAuthRoutes.terms.route.name,
      path: PreAuthRoutes.terms.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: Container(),
      ),
    ),
    GoRoute(
      name: PreAuthRoutes.forgetPassword.route.name,
      path: PreAuthRoutes.forgetPassword.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ForgetPasswordPage(),
      ),
    ),
    GoRoute(
      name: PreAuthRoutes.resetPassword.route.name,
      path: PreAuthRoutes.resetPassword.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ResetPasswordPage(
          changePasswordArgs: state.extra as ChangePasswordArgs,
        ),
      ),
    ),
  ];

  /// Contains all the home routes
  static final _postAuthRoutes = [
    GoRoute(
      name: PostAuthRoutes.checkIn.route.name,
      path: PostAuthRoutes.checkIn.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const CheckInPage(),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.mainDashboard.route.name,
      path: PostAuthRoutes.mainDashboard.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const MainDashboard(),
      ),
    ),

    /// my jp
    GoRoute(
      name: PostAuthRoutes.myJP.route.name,
      path: PostAuthRoutes.myJP.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: MyJPPage(moduleName: state.extra as String),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.myJPDashBoard.route.name,
      path: PostAuthRoutes.myJPDashBoard.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child:  const MyJpDashBoardPage(),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.jPPhotos.route.name,
      path: PostAuthRoutes.jPPhotos.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child:  const JPPhotosPage(),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.checkList.route.name,
      path: PostAuthRoutes.checkList.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const CheckListPage(),
      ),
    ),

    ///
    GoRoute(
      name: PostAuthRoutes.myCoverage.route.name,
      path: PostAuthRoutes.myCoverage.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: MyCoveragePage(moduleName: state.extra as String),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.knowledgeShare.route.name,
      path: PostAuthRoutes.knowledgeShare.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: KnowledgeSharePage(moduleName: state.extra as String),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.clientsSku.route.name,
      path: PostAuthRoutes.clientsSku.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: ClientsSkuPage(moduleName: state.extra as String),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.teamJourneyPlane.route.name,
      path: PostAuthRoutes.teamJourneyPlane.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: TeamJourneyPlanPage(moduleName: state.extra as String),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.visitsHistoryResult.route.name,
      path: PostAuthRoutes.visitsHistoryResult.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: TeamVisitsHistoryResultPage(moduleName: state.extra as String),
      ),
    ),
    // GoRoute(
    //   name: PostAuthRoutes.categories.route.name,
    //   path: PostAuthRoutes.categories.route.path,
    //   pageBuilder: (context, state) => MaterialPage(
    //     key: state.pageKey,
    //     child:  CategoriesPage(moduleName: state.extra as String),
    //   ),
    // ),
    GoRoute(
      name: PostAuthRoutes.teamDashboard.route.name,
      path: PostAuthRoutes.teamDashboard.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: TeamDashboard(moduleName: state.extra as String),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.teamAttendance.route.name,
      path: PostAuthRoutes.teamAttendance.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: TeamAttendancePage(
          moduleName: state.extra as String,
        ),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.teamKPI.route.name,
      path: PostAuthRoutes.teamKPI.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: TeamKPIPage(
          moduleName: state.extra as String,
        ),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.filter.route.name,
      path: PostAuthRoutes.filter.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: FilterPage(
          filterArgs: state.extra as FilterArgs,
        ),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.filterCoverage.route.name,
      path: PostAuthRoutes.filterCoverage.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: FilterMyCoveragePage(
          filterArgs: state.extra as FilterArgs,
        ),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.filterVisitHistory.route.name,
      path: PostAuthRoutes.filterVisitHistory.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: FilterMyVisitHistoryPage(
          filterArgs: state.extra as FilterArgs,
        ),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.filterTeamJP.route.name,
      path: PostAuthRoutes.filterTeamJP.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: FilterTeamJPPage(
          filterArgs: state.extra as FilterArgs,
        ),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.filterTeamAttendance.route.name,
      path: PostAuthRoutes.filterTeamAttendance.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: FilterTeamAttendancePage(
          filterArgs: state.extra as FilterArgs,
        ),
      ),
    ),
    GoRoute(
      name: PostAuthRoutes.setting.route.name,
      path: PostAuthRoutes.setting.route.path,
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SettingPage(),
      ),
    ),
  ];
}

class GoRouterRefreshStream extends ChangeNotifier {
  /// Creates a [GoRouterRefreshStream].
  ///
  /// Every time the [stream] receives an event the [GoRouter] will refresh its
  /// current route.
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
