import 'dart:convert';

import 'package:c_supervisor/data/models/common_data_list_model.dart';
import 'package:c_supervisor/data/models/user_info.dart';
import 'package:flutter_core/flutter_core.dart';

/// Provides methods to store and retrieve specific data to the SecureStorage
///
///
class AppSharedPrefsClient {
  AppSharedPrefsClient({required this.storageInstance});

  final SharedPrefs storageInstance;

  /// Retrieve current user image
  UserInfo? getCurrentUserInfo() {
    final serializedToken =
        storageInstance.getValue<String?>(SharedPrefsConstants.userTypeDataKey);
    return serializedToken != null
        ? UserInfo().fromJson(jsonDecode(jsonDecode(serializedToken)))
        : null;
  }

  /// Retrieve current user image
  CommonDataListModel? getCurrentUserCheckInList() {
    final serializedCheckInList =
        storageInstance.getValue<String?>(SharedPrefsConstants.userCheckInList);
    return serializedCheckInList != null
        ? CommonDataListModel()
            .fromJson(jsonDecode(jsonDecode(serializedCheckInList)))
        : null;
  }

  /// Save user info
  bool saveCurrentUserInfo(UserInfo? userInfo) => storageInstance.setValue(
        SharedPrefsConstants.userTypeDataKey,
        jsonEncode(userInfo?.toJson()),
      );

  /// save check in list
  bool saveCurrentUserCheckInList(CommonDataListModel? checkInList) =>
      storageInstance.setValue(
        SharedPrefsConstants.userCheckInList,
        jsonEncode(checkInList?.toJson()),
      );

  bool updateUserCheckInStatus() {
    final userInfo = getCurrentUserInfo();
    userInfo?.checkedIn = true;
    return saveCurrentUserInfo(userInfo);
  }
}
