import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/data/models/team_journey_plan_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/chart_data_list.dart';

abstract class TeamJourneyPlanRepo {
  Future<BaseResponse<TeamJourneyPlanListModel?>> getTeamJourneyPlan({
    required FilterModel filterModel,
  });

  Future<BaseResponse<ChartDataList?>> getTeamJPChartsData(
      FilterModel filterModel);
}
