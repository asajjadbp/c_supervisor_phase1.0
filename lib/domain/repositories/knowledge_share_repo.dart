import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../../data/models/add_file_model.dart';
import '../../data/models/empty_model.dart';
import '../../data/models/image_response_model.dart';
import '../../data/models/knowledge_base_categories_list_model.dart';
import 'dart:io';

abstract class KnowledgeShareRepo {
  Future<BaseResponse<KnowledgeBaseCategoriesListModel?>>
      getKnowledgeBaseCategories();
  Future<BaseResponse<EmptyModel?>> addFile(AddFileModel addFileModel);
  Future<BaseResponse<ImageResponseModel?>> uploadFiles(List<File> files);
}
