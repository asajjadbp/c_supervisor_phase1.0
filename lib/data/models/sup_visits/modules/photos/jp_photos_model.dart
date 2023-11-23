class JPPhotosModel {
  int? id;
  String? photoPath;
  JPPhotosModel.fromJson(dynamic json) {
    id = json['id'];
    photoPath = json['photoPath'];
  }
}
