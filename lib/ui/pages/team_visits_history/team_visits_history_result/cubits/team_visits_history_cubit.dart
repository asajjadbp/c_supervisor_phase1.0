import '../../../../../data/models/filter_model.dart';
import 'index.dart';

class TeamVisitsHistoryCubit
    extends BaseAppPagingCubit<TeamVisitsHistoryListModel> {
  final TeamVisitsHistoryUC teamVisitsHistoryUC;
  TeamVisitsHistoryCubit(this.teamVisitsHistoryUC);

  @override
  Future<TeamVisitsHistoryListModel> loadItemsAtPage(int page, {args}) async {
    FilterModel? filterModel;
    try {
      final map = args as Map<dynamic, dynamic>;
      if (map.containsKey('filterModel')) {
        filterModel = map['filterModel'] as FilterModel?;
        filterModel?.pageNumber = page;
      }
    } catch (e) {}
    final BaseResponse<TeamVisitsHistoryListModel?> result;
    final userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    final visitsStartDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    final visitEndDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    result = await networkCall(
      () => teamVisitsHistoryUC.getTeamVisitsHistory(
        filterModel: filterModel ??
            FilterModel(
              pageNumber: page,
              userID: userID,
              visitStartDate: visitsStartDate,
              visitEndDate: visitEndDate,
              childsIDs: [],
              companyIDs: [],
              cityIDs: [],
              regionIDs: [],
              pageSize: APIEndpoints.pageSize,
            ),
      ),
    );

    return result.data ?? TeamVisitsHistoryListModel();
  }
}
