import 'dart:convert';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provides SharedPreferences for both Android & iOS
class MySharedPreferences extends SharedPrefs {
  MySharedPreferences._internal();

  static SharedPreferences? _prefs;

  static Future<MySharedPreferences?> getInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
    return MySharedPreferences._internal();
  }

  /// Returns saved value for key. Returns `null` if the value doesn't exists
  @override
  T? getValue<T>(SharedPreferencesKey key) {
    final value = _prefs?.get(key.key);
    return value as T;
  }

  /// Sets value for the key
  @override
  bool setValue<T>(SharedPreferencesKey key, T value) {
    _prefs?.setString(key.key, jsonEncode(value));

    return containsKey(key.key);
  }

  /// Returns [bool] denoting if storage contains the supplied [key]
  bool containsKey(
    String key, {
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) =>
      _prefs?.containsKey(
        key,
      ) ??
      false;
}
