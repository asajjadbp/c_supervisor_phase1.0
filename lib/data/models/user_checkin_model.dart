
import 'package:networking/client/networking_models/index.dart';

class UserCheckInModel
    implements
        BaseNetworkSerializable,
        BaseNetworkDeserializable<UserCheckInModel> {
  UserCheckInModel({
    this.userID,
    this.userLatitude,
    this.userLongitude,
    this.photoPath,
    this.comment,
  });

  int? userID;
  double? userLatitude;
  double? userLongitude;
  String? photoPath;
  String? comment;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userID'] = userID;
    map['userLatitude'] = userLatitude;
    map['userLongitude'] = userLongitude;
    map['photoPath'] = photoPath;
    map['comment'] = comment;
    return map;
  }

  @override
  UserCheckInModel fromJson(Map<String, dynamic> json) {
    return UserCheckInModel(
      userID: json['userID'],
      userLatitude: json['userLatitude'],
      userLongitude: json['userLongitude'],
      photoPath: json['photoPath'],
      comment: json['comment'],
    );
  }
}
