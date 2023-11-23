import 'package:c_supervisor/domain/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../data/models/index.dart';

class TeamKPIUC {
  final TeamKPIRepo teamKPIRepo;

  TeamKPIUC(this.teamKPIRepo);
  Future<BaseResponse<ChartDataList?>> getTeamKPIChartsData(
      FilterModel filterModel) {
    return teamKPIRepo.getTeamKPIChartsData(filterModel);
  }

  Future<BaseResponse<TeamKPIListModel?>> getTeamKPIData(
      FilterModel filterModel) {
    return teamKPIRepo.getTeamKPIData(filterModel);
  }
}
