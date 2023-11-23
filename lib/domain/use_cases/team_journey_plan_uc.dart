import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/domain/repositories/team_journey_plan_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/chart_data_list.dart';
import '../../data/models/team_journey_plan_list_model.dart';

class TeamJourneyPlanUC {
  TeamJourneyPlanRepo teamJourneyPlanRepo;
  TeamJourneyPlanUC(this.teamJourneyPlanRepo);
  Future<BaseResponse<TeamJourneyPlanListModel?>> getTeamJourneyPlan({
    required FilterModel filterModel,
  }) {
    return teamJourneyPlanRepo.getTeamJourneyPlan(
      filterModel: filterModel,
    );
  }
  Future<BaseResponse<ChartDataList?>> getTeamJPChartsData(
      FilterModel filterModel){
    return teamJourneyPlanRepo.getTeamJPChartsData(filterModel);
  }
}
