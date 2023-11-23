import 'dart:io';
import 'package:c_supervisor/domain/use_cases/update_category/update_category_uc.dart';
import 'package:c_supervisor/ui/bloc/index.dart';
import 'package:networking/client/networking_models/index.dart';
import '../../../../../../data/models/image_response_model.dart';

class UpdateImagesCubit extends BaseAppCubit<ImageResponseModel?> {
  UpdateImagesCubit({required this.updateCategoryUC});

  final UpdateCategoryUC updateCategoryUC;

  Future<BaseResponse<ImageResponseModel?>> updateImage({
    required List<File> files,
  }) async {
    return await networkCall(
      () => updateCategoryUC.uploadImagesSOS(files),
    );
  }
}
