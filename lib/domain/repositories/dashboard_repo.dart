import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class DashboardRepo {
  Future<BaseResponse<MainDashboardModel?>> getMainDashboard({
    required int userId,
  });

  Future<BaseResponse<TeamDashboardModel?>> getTeamDashboard({
    required int userId,
  });
}
