import 'package:c_supervisor/data/data_sources/remote/index.dart';
import 'package:c_supervisor/data/models/chart_data_list.dart';
import 'package:c_supervisor/data/models/filter_model.dart';
import 'package:c_supervisor/data/models/team_kpi_list_model.dart';
import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';
class TeamKPIRepoImp implements TeamKPIRepo {
  final ApplicationRemoteDS applicationRemoteDS;

  TeamKPIRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<TeamKPIListModel?>> getTeamKPIData(
          FilterModel filterModel) async =>
      applicationRemoteDS.getTeamKPIData(filterModel);

  @override
  Future<BaseResponse<ChartDataList?>> getTeamKPIChartsData(
          FilterModel filterModel) async =>
      applicationRemoteDS.getTeamKPIChartsData(filterModel);
}
