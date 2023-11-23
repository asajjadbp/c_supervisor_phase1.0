import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';
import '../../../../data/models/sup_visits/to_json/start_visit_to_json_model.dart';

class StartVisitCubit extends BaseAppCubit<SuccessResponseModel?> {
  final SupVisitsUC supVisitsUC;

  StartVisitCubit({required this.supVisitsUC});

  Future<BaseResponse<SuccessResponseModel?>> startVisitJP({
    required StartVisitToJsonModel model,
  }) async {
    return await networkCall(
      () => supVisitsUC.startVisitJP(model: model),
    );
  }
}
