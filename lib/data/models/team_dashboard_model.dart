import 'package:networking/client/networking_models/index.dart';

import 'dashboard_module.dart';

class TeamDashboardModel implements BaseNetworkDeserializable {
  TeamDashboardModel({
    this.teamDashboardModules,
  });

  List<DashboardModule>? teamDashboardModules;

  @override
  TeamDashboardModel fromJson(Map<String, dynamic> json) {
    if (json['teamDashboardModules'] != null) {
      teamDashboardModules = [];
      json['teamDashboardModules'].forEach((v) {
        teamDashboardModules?.add(DashboardModule.fromJson(v));
      });
    }

    return TeamDashboardModel(teamDashboardModules: teamDashboardModules);
  }
}
