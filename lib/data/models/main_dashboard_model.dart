import 'package:networking/client/networking_models/index.dart';

import 'dashboard_module.dart';

class MainDashboardModel implements BaseNetworkDeserializable {
  MainDashboardModel({
    this.mainDashboardModules,
  });

  List<DashboardModule>? mainDashboardModules;

  @override
  MainDashboardModel fromJson(Map<String, dynamic> json) {
    if (json['mainDashboardModules'] != null) {
      mainDashboardModules = [];
      json['mainDashboardModules'].forEach((v) {
        mainDashboardModules?.add(DashboardModule.fromJson(v));
      });
    }

    return MainDashboardModel(mainDashboardModules: mainDashboardModules);
  }
}
