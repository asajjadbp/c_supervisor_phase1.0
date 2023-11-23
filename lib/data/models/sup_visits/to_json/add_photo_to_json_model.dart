class AddPhotoToJsonModel {
  final int visitID;
  final String photoPath;

  AddPhotoToJsonModel({
    required this.visitID,
    required this.photoPath,
  });
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['photoPath'] = photoPath;
    map['visitID'] = visitID;

    return map;
  }
}
