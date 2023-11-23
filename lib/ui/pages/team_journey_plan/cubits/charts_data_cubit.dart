import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/use_cases/team_journey_plan_uc.dart';
import 'package:c_supervisor/ui/bloc/index.dart';

class TeamJPChartDataCubit extends BaseAppCubit<ChartDataList?> {
  TeamJPChartDataCubit({required this.teamJourneyPlanUC});

  final TeamJourneyPlanUC teamJourneyPlanUC;

  Future<void> getTeamJPChartsData({
    required FilterModel filterModel,
  }) async {
    await networkCall(
      () => teamJourneyPlanUC.getTeamJPChartsData(filterModel),
    );
  }
}
