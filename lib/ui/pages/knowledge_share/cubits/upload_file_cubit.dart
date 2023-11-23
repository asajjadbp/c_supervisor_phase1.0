import 'package:c_supervisor/domain/use_cases/knowledge_share_uc.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../data/models/image_response_model.dart';
import '../../../bloc/base_app_cubit.dart';
import 'dart:io';

class UploadFileCubit extends BaseAppCubit<ImageResponseModel?> {
  UploadFileCubit( this.knowledgeShareUC);

  final KnowledgeShareUC knowledgeShareUC;

  Future<BaseResponse<ImageResponseModel?>> uploadFiles({
    required List<File> files,
  }) async {
    return await networkCall(
      () => knowledgeShareUC.uploadFiles(files),
    );
  }
}
