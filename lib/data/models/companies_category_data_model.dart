class CompaniesCategoryDataModel {
  String? categoryName;
  String? categoryImage;
  CompaniesCategoryDataModel.fromJson(dynamic json) {
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
  }
}
