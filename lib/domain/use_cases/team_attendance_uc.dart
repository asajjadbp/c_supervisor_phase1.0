import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../data/models/index.dart';

class TeamAttendanceUC {
  final TeamAttendanceRepo teamAttendanceRepo;

  TeamAttendanceUC(this.teamAttendanceRepo);

  Future<BaseResponse<TeamListModel?>> getTeamAttendance(
      FilterModel filterModel) {
    return teamAttendanceRepo.getTeamAttendance(filterModel);
  }

  Future<BaseResponse<ChartDataList?>> getTeamAttendanceChartsData(
      FilterModel filterModel) {
    return teamAttendanceRepo.getTeamAttendanceChartsData(filterModel);
  }
}
