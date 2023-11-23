import 'package:c_supervisor/data/models/team_visits_history_list_model.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/empty_model.dart';
import '../../data/models/filter_model.dart';

abstract class TeamVisitsHistoryRepo {
  Future<BaseResponse<TeamVisitsHistoryListModel?>> getTeamVisitsHistory({
    required FilterModel filterModel,
  });
  Future<BaseResponse<SuccessResponseModel?>> startAdtVisit({
    required int visitId,
  });
  Future<BaseResponse<SuccessResponseModel?>> finishAdtVisit({
    required int visitId,
  });
}
