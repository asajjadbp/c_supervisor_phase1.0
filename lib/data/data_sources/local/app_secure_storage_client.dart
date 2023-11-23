import 'dart:convert';

import 'package:c_supervisor/data/models/index.dart';
import 'package:flutter_core/utilities/constants/secure_storage_constants.dart';
import 'package:flutter_core/utilities/secure_storage/secure_storage.dart';


class AppSecureStorageClient {
  AppSecureStorageClient({required this.storageInstance});

  final SecureStorage storageInstance;

  /// Returns token from encrypted secure storage
  ///
  Future<Tokens?> getStoredToken() async {
    try {
      final serializedToken = await storageInstance
          .getValue<String?>(SecureStorageConstants.storageTokenDataKey);
      return serializedToken != null
          ? UserDataModel()
              .fromJson(jsonDecode(jsonDecode(serializedToken)))
              .userData
              ?.tokens
          : null;
    } catch (e) {
      return null;
    }
  }

  //
  // /// Reset secure storage
  Future<void> resetSecureStorage() async {
    try {
      await storageInstance.deleteAll();
    } catch (_) {}
  }

  //
  // /// Updates / saves the token to the encrypted secure storage
  // ///
  Future<bool> updateUserDataModel(UserDataModel userDataModel) =>
      storageInstance.setValue(
        SecureStorageConstants.storageTokenDataKey,
        jsonEncode(userDataModel.toJson()),
      );
//
// /// Returns stored user id from stored token model
// ///
// Future<int?> getStoredUserId() async {
//   final tokenModel = await getStoredToken();
//   return tokenModel?.userId;
// }
//
}
