import 'key.dart';

abstract class SecurePrefs {
  /// Returns value with key if exists
  Future<T?> getValue<T>(SharedPreferencesKey key);

  /// Set value with key
  Future<bool> setValue<T>(SharedPreferencesKey key, T value);
}

abstract class SharedPrefs {
  /// Returns value with key if exists
  T? getValue<T>(SharedPreferencesKey key);

  /// Set value with key
  bool setValue<T>(SharedPreferencesKey key, T value);
}
