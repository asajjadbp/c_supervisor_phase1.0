import 'package:shared_preferences/shared_preferences.dart' as prefs;

import 'key.dart';
import 'secure_preferences.dart';

/// Default shared preferences for set and retrieve values
///
/// Supported types:
/// [bool], [String], [int], [double], [List<String>], [DateTime]
class DefaultSharedPreferences implements SecurePrefs {
  /// Returns saved value for key. Returns `null` if the value doesn't exists
  @override
  Future<T?> getValue<T>(SharedPreferencesKey key) async {
    final instance = await prefs.SharedPreferences.getInstance();
    final keyValue = key.key;

    if (T is bool) {
      return instance.getBool(keyValue) as T?;
    } else if (T is String) {
      return instance.getString(keyValue) as T?;
    } else if (T is int) {
      return instance.getInt(keyValue) as T?;
    } else if (T is double) {
      return instance.getDouble(keyValue) as T?;
    } else if (T is List<String>) {
      return instance.getStringList(keyValue) as T?;
    } else if (T == DateTime) {
      final dateAsString = instance.getString(keyValue);
      return (dateAsString == null) ? null : DateTime.parse(dateAsString) as T?;
    } else {
      return instance.get(keyValue) as T?;
    }
  }

  /// Sets value for the key
  @override
  Future<bool> setValue<T>(SharedPreferencesKey key, T value) async {
    final instance = await prefs.SharedPreferences.getInstance();
    final keyValue = key.key;

    if (value is bool) {
      return instance.setBool(keyValue, value);
    } else if (value is String) {
      return instance.setString(keyValue, value);
    } else if (value is int) {
      return instance.setInt(keyValue, value);
    } else if (value is double) {
      return instance.setDouble(keyValue, value);
    } else if (value is List<String>) {
      return instance.setStringList(keyValue, value);
    } else if (value is DateTime) {
      return instance.setString(keyValue, value.toIso8601String());
    }

    throw Exception('Unsupported type!');
  }
}
