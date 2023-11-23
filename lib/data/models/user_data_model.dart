import 'package:c_supervisor/data/models/user_info.dart';
import 'package:networking/client/networking_models/index.dart';

class UserDataModel
    implements BaseNetworkSerializable, BaseNetworkDeserializable {
  UserDataModel({
    this.userData,
  });

  UserData? userData;

  @override
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userData != null) {
      map['userData'] = userData?.toJson();
    }
    return map;
  }

  @override
  UserDataModel fromJson(Map<String, dynamic> json) {
    return UserDataModel(
        userData: json['userData'] != null
            ? UserData.fromJson(json['userData'])
            : null);
  }
}

class Tokens {
  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  Tokens.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  String? accessToken;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['refreshToken'] = refreshToken;
    return map;
  }
}

class UserData {
  UserData({this.tokens, this.userInfo});

  UserData.fromJson(dynamic json) {
    tokens = json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
    userInfo =
        json['userinfo'] != null ? UserInfo().fromJson(json['userinfo']) : null;
  }

  Tokens? tokens;
  UserInfo? userInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (tokens != null) {
      map['tokens'] = tokens?.toJson();
    }
    if (userInfo != null) {
      map['userinfo'] = userInfo?.toJson();
    }
    return map;
  }
}
