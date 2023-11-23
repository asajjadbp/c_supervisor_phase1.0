import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/chart_data_list.dart';
import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/data/models/team_list_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class TeamAttendanceRepoImp implements TeamAttendanceRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  TeamAttendanceRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<TeamListModel?>> getTeamAttendance(
          FilterModel filterModel) async =>
      applicationRemoteDS.getTeamAttendance(filterModel);

  @override
  Future<BaseResponse<ChartDataList?>> getTeamAttendanceChartsData(
          FilterModel filterModel) async =>
      applicationRemoteDS.getTeamAttendanceChartsData(filterModel);
}
