import 'package:c_supervisor/utilities/router/global_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// hold all main modules ids

enum MainModuleTypes {
  myJP(1),
  myTeam(2),
  myCoverage(3),
  clientsSku(7),
  visits(4),
  knowledgeShare(6);

  const MainModuleTypes(this.moduleId);

  final int moduleId;

  static MainModuleTypes getType(int moduleId) => values.firstWhere(
        (element) => element.moduleId == moduleId,
        orElse: () => MainModuleTypes.visits,
      );

  void navigateToMainModule(
      {required BuildContext context, required String moduleName}) {
    switch (this) {
      case MainModuleTypes.myTeam:
        // context.push(PostAuthRoutes.filter.route.path);
        // context.push(PostAuthRoutes.teamAttendance.route.path);
        context.push(
          PostAuthRoutes.teamDashboard.route.path,
          extra: moduleName,
        );
        break;
      case MainModuleTypes.visits:
        // TODO: Handle this case.
        break;
      case MainModuleTypes.myCoverage:
        context.push(
          PostAuthRoutes.myCoverage.route.path,
          extra: moduleName,
        );
        break;
      case MainModuleTypes.clientsSku:
        context.push(
          PostAuthRoutes.clientsSku.route.path,
          extra: moduleName,
        );
        break;
      case MainModuleTypes.knowledgeShare:
        context.push(
          PostAuthRoutes.knowledgeShare.route.path,
          extra: moduleName,
        );
        break;
      case MainModuleTypes.myJP:
        context.push(
          PostAuthRoutes.myJP.route.path,
          extra: moduleName,
        );
        break;
    }
  }
}

enum TeamModuleTypes {
  addVisit(2),
  attendance(4),
  teamKPI(24),
  visits(3),
  teamJourneyPlane(21),
  visitsHistory(17);

  const TeamModuleTypes(this.moduleId);

  final int moduleId;

  static TeamModuleTypes getType(int moduleId) => values.firstWhere(
        (element) => element.moduleId == moduleId,
        orElse: () => TeamModuleTypes.visits,
      );

  void navigateToTeamModule(
      {required BuildContext context, required String moduleName}) {
    switch (this) {
      case TeamModuleTypes.addVisit:
        break;
      case TeamModuleTypes.attendance:
        context.push(PostAuthRoutes.teamAttendance.route.path,
            extra: moduleName);
        break;
      case TeamModuleTypes.visits:
        // TODO: Handle this case.
        break;
      case TeamModuleTypes.teamKPI:
        context.push(PostAuthRoutes.teamKPI.route.path, extra: moduleName);
        break;
      case TeamModuleTypes.teamJourneyPlane:
        context.push(PostAuthRoutes.teamJourneyPlane.route.path,
            extra: moduleName);
        break;
      case TeamModuleTypes.visitsHistory:
        context.push(PostAuthRoutes.visitsHistoryResult.route.path,
            extra: moduleName);
        break;
    }
  }
}
