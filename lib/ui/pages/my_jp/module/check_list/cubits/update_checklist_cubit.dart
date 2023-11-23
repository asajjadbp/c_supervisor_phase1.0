import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';
import '../../../../../../data/models/sup_visits/to_json/checklist_to_json_model.dart';

class UpdateCheckListCubit extends BaseAppCubit<SuccessResponseModel?> {
  final SupVisitsUC supVisitsUC;

  UpdateCheckListCubit({required this.supVisitsUC});

  Future<BaseResponse<SuccessResponseModel?>> updateVisitCheckList({
    required UpdateCheckListToJsonModel model,
  }) async {
    return await networkCall(
      () => supVisitsUC.updateVisitCheckList(model: model),
    );
  }
}
