import 'package:networking/client/networking_models/index.dart';

import '../../data/models/index.dart';

abstract class TeamAttendanceRepo {
  Future<BaseResponse<TeamListModel?>> getTeamAttendance(
      FilterModel filterModel);

  Future<BaseResponse<ChartDataList?>> getTeamAttendanceChartsData(
      FilterModel filterModel);


}
