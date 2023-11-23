import 'package:c_supervisor/data/data_sources/remote/application_remote_ds.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/data/models/team_journey_plan_list_model.dart';
import 'package:c_supervisor/domain/repositories/team_journey_plan_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

class TeamJourneyPlanRepoImp implements TeamJourneyPlanRepo {
  ApplicationRemoteDS applicationRemoteDS;
  TeamJourneyPlanRepoImp(this.applicationRemoteDS);
  @override
  Future<BaseResponse<TeamJourneyPlanListModel?>> getTeamJourneyPlan({
    required FilterModel filterModel,
  }) async {
    return applicationRemoteDS.getTeamJourneyPlan(
      filterModel: filterModel,
    );
  }

  @override
  Future<BaseResponse<ChartDataList?>> getTeamJPChartsData(FilterModel filterModel) {
    return applicationRemoteDS.getTeamJPChartsData(filterModel);
  }
}
