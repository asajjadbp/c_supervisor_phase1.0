import 'package:networking/client/networking_models/index.dart';
class AddActionTypeModel
    implements BaseNetworkSerializable<AddActionTypeModel> {
  AddActionTypeModel({
    this.actionTypeID,
    this.userID,
    this.supervisorID,
    this.actionDate,
  });

  AddActionTypeModel.fromJson(dynamic json) {
    actionTypeID = json['actionTypeID'];
    userID = json['userID'];
    supervisorID = json['supervisorID'];
    actionDate = json['actionDate'];
  }

  int? actionTypeID;
  int? userID;
  int? supervisorID;
  String? actionDate;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['actionTypeID'] = actionTypeID;
    map['userID'] = userID;
    map['supervisorID'] = supervisorID;
    map['actionDate'] = actionDate;
    return map;
  }
}
