import 'package:c_supervisor/data/constants/api_endpoints.dart';
import 'package:c_supervisor/data/data_sources/local/app_shared_prefs_client.dart';
import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/data/models/team_list_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:c_supervisor/ui/bloc/base_app_paging_cubit.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:intl/intl.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamAttendanceCubit extends BaseAppPagingCubit<TeamListModel> {
  final TeamAttendanceUC teamAttendanceUC;

  TeamAttendanceCubit(this.teamAttendanceUC);
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  @override
  Future<TeamListModel> loadItemsAtPage(int page, {args}) async {
    FilterModel? filterModel;
    try {
      final map = args as Map<dynamic, dynamic>;
      if (map.containsKey('filterModel')) {
        filterModel = map['filterModel'] as FilterModel?;
        filterModel?.pageNumber = page;
      }
    } catch (e) {}

    final BaseResponse<TeamListModel?> result;
    final userID = GetIt.I<AppSharedPrefsClient>().getCurrentUserInfo()?.userId;

    result = await networkCall(
      () => teamAttendanceUC.getTeamAttendance(
        filterModel ??
            FilterModel(
              pageNumber: page,
              pageSize: APIEndpoints.pageSize,
              userID:userID,
              childsIDs: [],
              startDate: dateFormat.format(DateTime.now()),
              endDate: dateFormat.format(DateTime.now()),
              roleIDs: [],
              status: 0,
            ),
      ),
    );

    return result.data ?? TeamListModel();
  }
}
