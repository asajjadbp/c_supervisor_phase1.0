import 'package:networking/client/networking_models/index.dart';

class FeedBackModel implements BaseNetworkSerializable<FeedBackModel> {
  FeedBackModel({
    this.feedBackID,
    this.userID,
    this.supervisorID,
    this.actionDate,
    this.comment,
    required this.feedBackType,
  });

  int? feedBackID;
  int? userID;
  int? supervisorID;
  String? actionDate;
  String? comment;
  int? feedBackType;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['feedBackID'] = feedBackID;
    map['userID'] = userID;
    map['supervisorID'] = supervisorID;
    map['actionDate'] = actionDate;
    map['comment'] = comment;
    map['feedBackType'] = feedBackType;
    return map;
  }
}
