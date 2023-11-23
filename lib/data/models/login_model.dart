import 'package:networking/client/networking_models/index.dart';

class LoginModel implements BaseNetworkSerializable {
  LoginModel({
    this.userName,
    this.password,
    this.langID,
  });

  String? userName;
  String? password;
  int? langID;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['password'] = password;
    map['langID'] = langID;
    return map;
  }
}
