import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
class TeamKPIChartDataCubit extends BaseAppCubit<ChartDataList?> {
  TeamKPIChartDataCubit({required this.teamKPIUC});

  final TeamKPIUC teamKPIUC;

  Future<void> getTeamKPIChartData({
    required FilterModel filterModel,
  }) async {
    await networkCall(
      () => teamKPIUC.getTeamKPIChartsData(filterModel),
    );
  }
}
