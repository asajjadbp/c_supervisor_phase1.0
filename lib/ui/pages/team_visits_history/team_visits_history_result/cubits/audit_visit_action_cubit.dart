import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

import '../../../../../domain/use_cases/team_visits_history_uc.dart';

class AuditVisitActionCubit extends BaseAppCubit<SuccessResponseModel?> {
  final TeamVisitsHistoryUC teamVisitsHistoryUC;

  AuditVisitActionCubit(this.teamVisitsHistoryUC);

  Future<BaseResponse<SuccessResponseModel?>> startAdtVisit({
    required int visitId,
  }) async {
    return await networkCall(
      () => teamVisitsHistoryUC.startAdtVisit(visitId: visitId),
    );
  }

  Future<BaseResponse<SuccessResponseModel?>> finishAdtVisit({
    required int visitId,
  }) async {
    return await networkCall(
      () => teamVisitsHistoryUC.finishAdtVisit(visitId: visitId),
    );
  }
}
