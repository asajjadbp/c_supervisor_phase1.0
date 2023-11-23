import 'package:networking/client/networking_models/index.dart';

import 'knowledge_base_categories_model.dart';

class KnowledgeBaseCategoriesListModel
    implements BaseNetworkDeserializable<KnowledgeBaseCategoriesListModel> {
  List<KnowledgeBaseCategoriesModel>? dataList;

  KnowledgeBaseCategoriesListModel({
    this.dataList = const [],
  });

  @override
  KnowledgeBaseCategoriesListModel fromJson(dynamic json) {
    return KnowledgeBaseCategoriesListModel(
      dataList: ['dataList'] == null
          ? []
          : List<KnowledgeBaseCategoriesModel>.from(
              json["dataList"].map(
                (x) => KnowledgeBaseCategoriesModel.fromJson(x),
              ),
            ),
    );
  }
}
