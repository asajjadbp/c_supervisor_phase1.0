
class VisitsCategoriesModel {
  int? id;
  String? categoryname;
  String? categoryPhotopath;
  String? storePhotoPath;

  VisitsCategoriesModel({
    this.id,
    this.categoryname,
    this.categoryPhotopath,
    this.storePhotoPath,
  });
  VisitsCategoriesModel.fromJson(dynamic json) {
    id = json['id'];
    categoryname = json['categoryname'];
    categoryPhotopath = json['categoryPhotopath'];
    storePhotoPath = json['storePhotoPath'];

  }
}
