enum InitialRoutes {
  splash(RouteModel(name: 'splash', path: '/'));

  const InitialRoutes(this.route);

  final RouteModel route;

  /// used to navigate between routes using names
  String get name => route.name;
}

/// Contains all pre-authentication routes
enum PreAuthRoutes {
  login(RouteModel(name: 'login', path: '/login')),
  terms(RouteModel(name: 'terms_unauthorized', path: '/terms_unauthorized')),
  forgetPassword(RouteModel(name: 'forget_password', path: '/forgetPassword')),
  checkIn(RouteModel(name: 'check_in', path: '/checkIn')),
  otpVerificationPage(RouteModel(
      name: 'otp_verification_result', path: '/otp_verification_result')),

  /// To navigate to [resetPassword] route it's required to pass
  /// [ResetPasswordArgs] instance as extra parameter when navigating
  resetPassword(RouteModel(name: 'resetPassword', path: '/resetPassword'));

  const PreAuthRoutes(this.route);

  final RouteModel route;

  /// used to navigate between routes using names
  String get name => route.name;

  /// Searches through [PreAuthRoutes] paths and returns true
  /// if the given [path] is found in the [PreAuthRoutes]
  static bool searchRoutePath(String path) {
    try {
      PreAuthRoutes.values.firstWhere(
        (element) => element.route.path == path,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

/// Contains all post-authentication routes
enum PostAuthRoutes {
  checkIn(RouteModel(name: "checkIn", path: "/check_in")),
  mainDashboard(
    RouteModel(
      name: "mainDashboard",
      path: "/main_dashboard",
    ),
  ),
  teamDashboard(
    RouteModel(
      name: "teamDashboard",
      path: "/team_dashboard",
    ),
  ),
  myJP(
    RouteModel(
      name: "myJP",
      path: "/myJP",
    ),
  ),
  myJPDashBoard(
    RouteModel(
      name: "myJPDashBoard",
      path: "/myJPDashBoard",
    ),
  ),
  jPPhotos(
    RouteModel(
      name: "jPPhotos",
      path: "/jPPhotos",
    ),
  ),
  checkList(
    RouteModel(
      name: "checkList",
      path: "/checkList",
    ),
  ),
  myCoverage(
    RouteModel(
      name: "myCoverage",
      path: "/myCoverage",
    ),
  ),
  knowledgeShare(
    RouteModel(
      name: "knowledgeShare",
      path: "/knowledgeShare",
    ),
  ),
  clientsSku(
    RouteModel(
      name: "clientsSku",
      path: "/clientsSku",
    ),
  ),
  teamJourneyPlane(
    RouteModel(
      name: "teamJourneyPlane",
      path: "/teamJourneyPlane",
    ),
  ),
  visitsHistoryResult(
    RouteModel(
      name: "visitsHistory",
      path: "/visitsHistory",
    ),
  ),
  categories(
    RouteModel(
      name: "categories",
      path: "/categories",
    ),
  ),
  teamAttendance(
    RouteModel(
      name: "teamAttendance",
      path: "/team_attendance",
    ),
  ),
  teamKPI(
    RouteModel(
      name: "teamKPI",
      path: "/team_kpi_page",
    ),
  ),
  filter(RouteModel(name: 'filter', path: '/filter')),
  filterCoverage(RouteModel(name: 'filterCoverage', path: '/filterCoverage')),
  filterVisitHistory(
      RouteModel(name: 'filterVisitHistory', path: '/filterVisitHistory')),
  filterTeamJP(RouteModel(name: 'filterTeamJP', path: '/filterTeamJP')),
  filterTeamAttendance(
      RouteModel(name: 'filterTeamAttendance', path: '/filterTeamAttendance')),
  setting(RouteModel(name: 'settingPage', path: '/setting_page'));

  const PostAuthRoutes(this.route);

  final RouteModel route;

  /// used to navigate between routes using names
  String get name => route.name;
}

/// Blueprint for route configuration
class RouteModel {
  const RouteModel({required this.name, required this.path});

  final String name;
  final String path;
}
