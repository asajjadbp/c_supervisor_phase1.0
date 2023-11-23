import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/main_dashboard_model.dart';
import 'package:c_supervisor/data/models/team_dashboard_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class DashboardRepoImp implements DashboardRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  DashboardRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<MainDashboardModel?>> getMainDashboard(
      {required int userId}) async {
    return applicationRemoteDS.getMainDashboard(userId: userId, langId: 1);
  }

  @override
  Future<BaseResponse<TeamDashboardModel?>> getTeamDashboard(
      {required int userId}) async {
    return applicationRemoteDS.getTeamDashboard(userId: userId, langId: 1);
  }
}
