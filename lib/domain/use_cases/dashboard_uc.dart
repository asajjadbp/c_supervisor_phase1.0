import 'package:c_supervisor/data/models/dashboard_module.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

class DashboardUC {
  final DashboardRepo dashboardRepo;

  DashboardUC(this.dashboardRepo);

  Future<BaseResponse<List<DashboardModule>?>> getMainDashboard(
      {required int userId}) async {
    final result = await dashboardRepo.getMainDashboard(
      userId: userId,
    );
    return result.copyWith(result.data?.mainDashboardModules);
  }

  Future<BaseResponse<List<DashboardModule>?>> getTeamDashboard(
      {required int userId}) async {
    final result = await dashboardRepo.getTeamDashboard(
      userId: userId,
    );
    return result.copyWith(result.data?.teamDashboardModules);
  }
}
