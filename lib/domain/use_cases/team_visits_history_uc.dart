import 'package:c_supervisor/data/models/team_visits_history_list_model.dart';
import 'package:c_supervisor/domain/repositories/team_visits_history_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/empty_model.dart';
import '../../data/models/filter_model.dart';

class TeamVisitsHistoryUC {
  TeamVisitsHistoryRepo teamVisitsHistoryRepo;
  TeamVisitsHistoryUC(this.teamVisitsHistoryRepo);
  Future<BaseResponse<TeamVisitsHistoryListModel?>> getTeamVisitsHistory({
    required FilterModel filterModel,
  }) {
    return teamVisitsHistoryRepo.getTeamVisitsHistory(filterModel: filterModel);
  }

  Future<BaseResponse<SuccessResponseModel?>> startAdtVisit({
    required int visitId,
  }) {
    return teamVisitsHistoryRepo.startAdtVisit(visitId: visitId);
  }

  Future<BaseResponse<SuccessResponseModel?>> finishAdtVisit({
    required int visitId,
  }) {
    return teamVisitsHistoryRepo.finishAdtVisit(visitId: visitId);
  }
}
