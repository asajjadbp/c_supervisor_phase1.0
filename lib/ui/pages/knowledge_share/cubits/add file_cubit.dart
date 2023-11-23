import 'package:c_supervisor/domain/use_cases/knowledge_share_uc.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../../../data/models/add_file_model.dart';
import '../../../../data/models/empty_model.dart';
import '../../../bloc/base_app_cubit.dart';

class AddFileCubit extends BaseAppCubit<EmptyModel?> {
  final KnowledgeShareUC knowledgeShareUC;

  AddFileCubit(this.knowledgeShareUC);

  Future<BaseResponse<EmptyModel?>> addFile({
    required AddFileModel addFileModel,
  }) async {
    return await networkCall(
      () => knowledgeShareUC.addFile(addFileModel),
    );
  }
}
