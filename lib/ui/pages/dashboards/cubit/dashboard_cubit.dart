import 'package:c_supervisor/data/models/dashboard_module.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

class DashboardCubit extends BaseAppCubit<List<DashboardModule>?> {
  DashboardCubit({required this.dashboardUC});

  final DashboardUC dashboardUC;

  Future<void> getMainDashboard({
    required int userId,
  }) async {
    await networkCall(
      () => dashboardUC.getMainDashboard(
        userId: userId,
      ),
    );
  }

  Future<void> getTeamDashboard({
    required int userId,
  }) async {
    await networkCall(
      () => dashboardUC.getTeamDashboard(
        userId: userId,
      ),
    );
  }
}
