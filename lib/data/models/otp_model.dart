import 'package:networking/client/networking_models/index.dart';
class OtpModel implements BaseNetworkSerializable {
  OtpModel({
    this.userName,
    this.code,
    this.newPassword,
  });

  OtpModel.fromJson(dynamic json) {
    userName = json['userName'];
    code = json['code'];
    newPassword = json['newPassword'];
  }
  String? userName;
  String? code;
  String? newPassword;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['code'] = code;
    map['newPassword'] = newPassword;
    return map;
  }
}
