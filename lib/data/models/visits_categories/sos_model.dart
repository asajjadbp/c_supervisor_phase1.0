class SOSModel {
  int? id;
  String? categoryname;
  String? measureUnit;
  String? actualSize;
  String? sos;
  String? shelfCategorySpace;
  String? shelfTotalSpace;
  List<PhotosSOS>? photos;

  SOSModel({
    this.id,
    this.categoryname,
    this.measureUnit,
    this.actualSize,
    this.sos,
    this.shelfCategorySpace,
    this.shelfTotalSpace,
    this.photos,
  });
  SOSModel.fromJson(dynamic json) {
    id = json["id"];
    categoryname = json["categoryname"];
    measureUnit = json["measureUnit"];
    actualSize = json["actualSize"];
    sos = json["sos"];
    shelfCategorySpace = json["shelfCategorySpace"];
    shelfTotalSpace = json["shelfTotalSpace"];
    photos = List<PhotosSOS>.from(
        (json["photos"] ?? []).map((x) => PhotosSOS.fromJson(x)));
  }
}

class PhotosSOS {
  String? photoPath;
  String? typeName;
  int? typeID;
  PhotosSOS({
    this.photoPath,
    this.typeName,
    this.typeID,
  });
  PhotosSOS.fromJson(dynamic json) {
    photoPath = json["photoPath"];
    typeName = json["typeName"];
    typeID = json["typeID"];
  }
}
