import 'package:c_supervisor/data/models/team_journey_plan_list_model.dart';

import '../../../../domain/use_cases/team_journey_plan_uc.dart';
import '../../team_kpi/index.dart';

class TeamJourneyPlanCubit
    extends BaseAppPagingCubit<TeamJourneyPlanListModel> {
  final TeamJourneyPlanUC teamJourneyPlanUC;
  TeamJourneyPlanCubit(this.teamJourneyPlanUC);

  @override
  Future<TeamJourneyPlanListModel> loadItemsAtPage(int page, {args}) async {
    final BaseResponse<TeamJourneyPlanListModel?> result;
    FilterModel? filterModel;
    try {
      final map = args as Map<dynamic, dynamic>;
      if (map.containsKey('filterModel')) {
        filterModel = map['filterModel'] as FilterModel?;
        filterModel?.pageNumber=page;
      }
    } catch (e) {}
    final userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    final visitsDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    result = await networkCall(
      () => teamJourneyPlanUC.getTeamJourneyPlan(
        filterModel: filterModel ??
            FilterModel(
              pageNumber: page,
              userID: userID,
              pageSize: 20,
              chainIDs: [],
              cityIDs: [],
              regionIDs: [],
              companyIDs: [],
              childsIDs: [],
              visitsDate: visitsDate,
              status: 4,
            ),
      ),
    );

    return result.data ?? TeamJourneyPlanListModel();
  }
}
