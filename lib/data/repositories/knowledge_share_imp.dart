import 'dart:io';

import 'package:c_supervisor/data/models/add_file_model.dart';
import 'package:c_supervisor/data/models/empty_model.dart';
import 'package:c_supervisor/data/models/image_response_model.dart';
import 'package:c_supervisor/data/models/knowledge_base_categories_list_model.dart';
import 'package:c_supervisor/domain/repositories/knowledge_share_repo.dart';
import 'package:networking/client/networking_models/base_network_models/base_response.dart';

import '../data_sources/remote/application_remote_ds.dart';

class KnowledgeShareRepoImp implements KnowledgeShareRepo {
  ApplicationRemoteDS applicationRemoteDS;
  KnowledgeShareRepoImp(this.applicationRemoteDS);

  @override
  Future<BaseResponse<KnowledgeBaseCategoriesListModel?>>
      getKnowledgeBaseCategories() async {
    return applicationRemoteDS.getKnowledgeBaseCategories();
  }

  @override
  Future<BaseResponse<EmptyModel?>> addFile(AddFileModel addFileModel) async {
    return applicationRemoteDS.addFile(addFileModel);
  }

  @override
  Future<BaseResponse<ImageResponseModel?>> uploadFiles(List<File> files) {
    return applicationRemoteDS.uploadFiles(files);
  }
}
