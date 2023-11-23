import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/team_visits_history_list_model.dart';
import 'package:c_supervisor/domain/repositories/team_visits_history_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../data_sources/remote/application_remote_ds.dart';
import '../models/filter_model.dart';

class TeamVisitsHistoryImp implements TeamVisitsHistoryRepo {
  ApplicationRemoteDS applicationRemoteDS;
  TeamVisitsHistoryImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<TeamVisitsHistoryListModel?>> getTeamVisitsHistory({
    required FilterModel filterModel,
  }) async {
    return applicationRemoteDS.getTeamVisitsHistory(
      filterModel: filterModel,
    );
  }

  @override
  Future<BaseResponse<SuccessResponseModel?>> startAdtVisit({
    required int visitId,
  }) async {
    return applicationRemoteDS.startAdtVisit(visitId: visitId);
  }

  @override
  Future<BaseResponse<SuccessResponseModel?>> finishAdtVisit({
    required int visitId,
  }) async {
    return applicationRemoteDS.finishAdtVisit(visitId: visitId);
  }
}
