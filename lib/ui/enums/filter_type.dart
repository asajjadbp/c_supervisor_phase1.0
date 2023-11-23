import 'package:c_supervisor/ui/pages/team_kpi/index.dart';

import '../index.dart';

///[FilterType] will hold the type of filter
enum FilterType {
  teamAttendance,
  teamKPI,
  myCoverage,
  myVisitsHistory,
  teamJP;

  bool getTeamMultipleSelectStatus() {
    switch (this) {
      case FilterType.teamAttendance:
        return true;
      case FilterType.teamKPI:
        return false;
      case FilterType.myCoverage:
        return true;
      case FilterType.myVisitsHistory:
        return true;
      case FilterType.teamJP:
        return true;
    }
  }

  ///[getFilterModel] responsible for creating [FilterModel] based on [FilterType]
  FilterModel getFilterModel(SearchArgs searchArgs) {
    final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    final int userID =
        GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId ?? 0;

    switch (this) {
      case FilterType.teamAttendance:
        return FilterModel(
          pageSize: APIEndpoints.pageSize,
          pageNumber: 1,
          startDate: searchArgs.startDate ?? dateFormat.format(DateTime.now()),
          endDate: searchArgs.startDate ?? dateFormat.format(DateTime.now()),
          childsIDs: searchArgs.childIds,
          roleIDs: [],
          userID: userID,
          status: searchArgs.status ?? 0,
        );
      case FilterType.teamKPI:
        return FilterModel(
          pageSize: APIEndpoints.pageSize,
          pageNumber: 1,
          startDate: searchArgs.startDate,
          endDate: searchArgs.startDate,
          childsIDs: [],
          roleIDs: [],

          ///[userID]
          /// if user select item from search filter then return data of the item
          /// else
          /// return data of user which login in this app
          userID: searchArgs.childIds!.isNotEmpty
              ? searchArgs.childIds?.first
              : userID,
        );
      case FilterType.myCoverage:
        return FilterModel(
          userID: userID,
          pageSize: APIEndpoints.pageSize,
          pageNumber: 1,
          searchWord: '',
          companyId: 1,
          cityIDs: searchArgs.cityIDs ?? [],
          chainIDs: searchArgs.chainIDs ?? [],
        );
      case FilterType.myVisitsHistory:
        return FilterModel(
          pageNumber: 1,
          pageSize: APIEndpoints.pageSize,
          userID: userID,
          visitEndDate:
              searchArgs.visitEndDate ?? dateFormat.format(DateTime.now()),
          visitStartDate:
              searchArgs.visitStartDate ?? dateFormat.format(DateTime.now()),
          childsIDs: searchArgs.childIds ?? [],
          companyIDs: searchArgs.companyIDs ?? [],
          cityIDs: searchArgs.cityIDs ?? [],
          regionIDs: searchArgs.regionIDs ?? [],
        );
      case FilterType.teamJP:
        return FilterModel(
          pageNumber: 1,
          pageSize: APIEndpoints.pageSize,
          userID: userID,
          visitsDate: searchArgs.visitsDate ?? dateFormat.format(DateTime.now()),
          childsIDs: searchArgs.childIds ?? [],
          companyIDs: searchArgs.companyIDs ?? [],
          cityIDs: searchArgs.cityIDs ?? [],
          regionIDs: searchArgs.regionIDs ?? [],
          chainIDs: searchArgs.chainIDs ?? [],
          status: searchArgs.status ?? 4,
        );
    }
  }
}
