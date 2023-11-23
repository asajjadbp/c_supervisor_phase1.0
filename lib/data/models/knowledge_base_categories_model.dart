class KnowledgeBaseCategoriesModel {
  int? id;
  String? value;
  KnowledgeBaseCategoriesModel({this.value, this.id});
  KnowledgeBaseCategoriesModel.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
  }
}
