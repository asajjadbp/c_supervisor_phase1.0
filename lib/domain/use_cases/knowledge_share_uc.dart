import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/add_file_model.dart';
import '../../data/models/empty_model.dart';
import '../../data/models/image_response_model.dart';
import '../../data/models/knowledge_base_categories_list_model.dart';
import '../repositories/knowledge_share_repo.dart';
import 'dart:io';

class KnowledgeShareUC {
  KnowledgeShareRepo knowledgeShareRepo;
  KnowledgeShareUC(this.knowledgeShareRepo);
  Future<BaseResponse<KnowledgeBaseCategoriesListModel?>>
      getKnowledgeBaseCategories() {
    return knowledgeShareRepo.getKnowledgeBaseCategories();
  }

  Future<BaseResponse<EmptyModel?>> addFile(AddFileModel addFileModel) async {
    return await knowledgeShareRepo.addFile(addFileModel);
  }

  Future<BaseResponse<ImageResponseModel?>> uploadFiles(
      List<File> files) async {
    return await knowledgeShareRepo.uploadFiles(files);
  }
}
