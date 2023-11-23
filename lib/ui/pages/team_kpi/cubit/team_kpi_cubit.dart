import 'package:c_supervisor/ui/pages/team_kpi/index.dart';
class TeamKPICubit extends BaseAppPagingCubit<TeamKPIListModel> {
  final TeamKPIUC teamKPIUC;

  TeamKPICubit(this.teamKPIUC);
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  @override
  Future<TeamKPIListModel> loadItemsAtPage(int page, {args}) async {
    FilterModel? filterModel;

    try {
      final map = args as Map<dynamic, dynamic>;
      if (map.containsKey('filterModel')) {
        filterModel = map['filterModel'] as FilterModel?;
        filterModel?.pageNumber = page;
      }
    } catch (e) {}

    final BaseResponse<TeamKPIListModel?> result;

    int userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;
    result = await networkCall(
      () => teamKPIUC.getTeamKPIData(
        filterModel ??
            FilterModel(
              pageNumber: page,
              pageSize: APIEndpoints.pageSize,
              userID: userID,
              childsIDs: [],
              startDate: dateFormat.format(DateTime.now()),
              endDate: dateFormat.format(DateTime.now()),
            ),
      ),
    );

    return result.data ?? TeamKPIListModel();
  }
}
