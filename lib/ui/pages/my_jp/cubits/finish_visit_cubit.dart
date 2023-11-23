import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';

import '../../team_kpi/index.dart';

class FinishVisitCubit extends BaseAppCubit<SuccessResponseModel?> {
  FinishVisitCubit({required this.supVisitsUC});

  final SupVisitsUC supVisitsUC;

  Future<BaseResponse<SuccessResponseModel?>> finishVisit({
    required int visitId,
    required String comment,
  }) async {
    return await networkCall(
      () => supVisitsUC.finishVisit(
        comment: comment,
        visitId: visitId,
      ),
    );
  }
}
