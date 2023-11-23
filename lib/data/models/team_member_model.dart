import 'package:c_supervisor/data/models/action_type.dart';
import 'package:networking/client/networking_models/index.dart';

class TeamMemberModel implements BaseNetworkDeserializable {
  TeamMemberModel({
    this.id,
    this.userName,
    this.fullName,
    this.attendance,
    this.imgUrl,
    this.checkInDate,
    this.actionType,
  });

  TeamMemberModel.fromJson(dynamic json) {
    id = json['id'];
    userName = json['userName'];
    fullName = json['fullName'];
    attendance = json['attendance'];
    imgUrl = json['imgUrl'];
    checkInDate = json['checkInDate'];
    actionType = json['actionType'] != null
        ? ActionType().fromJson(json['actionType'])
        : null;
  }

  int? id;
  String? userName;
  String? fullName;
  String? attendance;
  String? imgUrl;
  ActionType? actionType;
  String? checkInDate;

  @override
  TeamMemberModel fromJson(Map<String, dynamic> json) => TeamMemberModel(
        id: json['id'],
        userName: json['userName'],
        fullName: json['fullName'],
        attendance: json['attendance'],
        imgUrl: json['imgUrl'],
        checkInDate: json['checkInDate'],
        actionType: json['actionType'] != null
            ? ActionType().fromJson(json['actionType'])
            : null,
      );
}
