import 'package:networking/client/networking_models/index.dart';

class UserInfo implements BaseNetworkDeserializable, BaseNetworkSerializable {
  UserInfo({
    this.userId,
    this.userEmail,
    this.fullName,
    this.userTelephone,
    this.photoPath,
    this.agency,
    this.role,
    this.checkedIn,
  });

  UserInfo.fromJson(dynamic json) {
    userId = json['userId'];
    userEmail = json['userEmail'];
    fullName = json['fullName'];
    userTelephone = json['userTelephone'];
    photoPath = json['photoPath'];
    agency = json['agency'];
    role = json['role'];
    checkedIn = json['checkedIn'];
  }

  int? userId;
  String? userEmail;
  String? fullName;
  String? userTelephone;
  String? photoPath;
  String? agency;
  String? role;
  bool? checkedIn;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['userEmail'] = userEmail;
    map['fullName'] = fullName;
    map['userTelephone'] = userTelephone;
    map['photoPath'] = photoPath;
    map['agency'] = agency;
    map['role'] = role;
    map['checkedIn'] = checkedIn;
    return map;
  }

  @override
  UserInfo fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['userId'],
      userEmail: json['userEmail'],
      fullName: json['fullName'],
      userTelephone: json['userTelephone'],
      photoPath: json['photoPath'],
      agency: json['agency'],
      role: json['role'],
      checkedIn: json['checkedIn'],
    );
  }
}
