class StartVisitToJsonModel {
  final int userId;
  final int visitID;
  final String photoPath;
  final num userLatitude;
  final num userLongitude;
  StartVisitToJsonModel({
    required this.userId,
    required this.visitID,
    required this.photoPath,
    required this.userLatitude,
    required this.userLongitude,
  });
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userId;
    map['userLatitude'] = userLatitude;
    map['userLongitude'] = userLongitude;
    map['photoPath'] = photoPath;
    map['visitID'] = visitID;

    return map;
  }
}
