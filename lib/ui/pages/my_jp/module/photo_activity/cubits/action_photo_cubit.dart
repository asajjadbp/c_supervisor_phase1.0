import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/data/models/sup_visits/to_json/add_photo_to_json_model.dart';
import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';

class ActionPhotoCubit extends BaseAppCubit<SuccessResponseModel?> {
  final SupVisitsUC supVisitsUC;

  ActionPhotoCubit({required this.supVisitsUC});

  Future<BaseResponse<SuccessResponseModel?>> addPhoto({
    required AddPhotoToJsonModel model,
  }) async {
    return await networkCall(
      () => supVisitsUC.addPhoto(model: model),
    );
  }

  Future<BaseResponse<SuccessResponseModel?>> removePhoto({
    required int photoId,
  }) async {
    return await networkCall(
      () => supVisitsUC.removePhoto(photoId: photoId),
    );
  }
}
