import 'package:c_supervisor/domain/use_cases/sup_visits_uc.dart';
import '../../../../data/models/image_response_model.dart';
import '../../../bloc/base_app_cubit.dart';
import '../../../index.dart';

class UploadImageJPCubit extends BaseAppCubit<ImageResponseModel?> {
  UploadImageJPCubit({required this.supVisitsUC});

  final SupVisitsUC supVisitsUC;

  Future<BaseResponse<ImageResponseModel?>> uploadImageJP({
    required List<File> files,
  }) async {
    return await networkCall(
      () => supVisitsUC.uploadImageJP(files),
    );
  }
}
