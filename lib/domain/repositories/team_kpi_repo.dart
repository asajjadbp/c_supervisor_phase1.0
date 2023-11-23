import 'package:c_supervisor/data/models/index.dart';
import 'package:networking/client/networking_models/index.dart';

abstract class TeamKPIRepo {
  Future<BaseResponse<TeamKPIListModel?>> getTeamKPIData(
      FilterModel filterModel);

  Future<BaseResponse<ChartDataList?>> getTeamKPIChartsData(
      FilterModel filterModel);
}
