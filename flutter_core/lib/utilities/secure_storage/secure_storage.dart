import 'dart:convert';

import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'options.dart';

/// Provides SecureStorage for both Android & iOS
class SecureStorage extends SecurePrefs {
  /// Important: you need to disable auto backup in android or allowbackup in manifest
  /// https://developer.android.com/guide/topics/data/autobackup#EnablingAutoBackup
  /// Also need to exclude shared prefernces from backup
  /// https://github.com/mogol/flutter_secure_storage/issues/43
  final _storage = const FlutterSecureStorage();

  /// Returns all the saved key and value pairs saved in the secure storage
  Future<Map<String, String>> getAllPairs({
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async =>
      await _storage.readAll(
        iOptions: iosOptions ?? Options.iosOptions,
        aOptions: androidOptions ?? Options.androidOptions,
      );

  /// Deletes a specific entry depending on the supplied [key]
  Future<void> deleteEntry(
    String key, {
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async =>
      await _storage.delete(
        key: key,
        iOptions: iosOptions ?? Options.iosOptions,
        aOptions: androidOptions ?? Options.androidOptions,
      );

  /// Deletes all the pairs in the secure storage
  Future<void> deleteAll({
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async =>
      await _storage.deleteAll(
        iOptions: iosOptions ?? Options.iosOptions,
        aOptions: androidOptions ?? Options.androidOptions,
      );

  /// Encrypts and saves the [key] and the [value] pair
  Future<void> write(
    String key,
    String value, {
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async =>
      await _storage.write(
        key: key,
        value: value,
        iOptions: iosOptions ?? Options.iosOptions,
        aOptions: androidOptions ?? Options.androidOptions,
      );

  /// Returns [bool] denoting if storage contains the supplied [key]
  Future<bool> containsKey(
    String key, {
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async =>
      await _storage.containsKey(
        key: key,
        iOptions: iosOptions ?? Options.iosOptions,
        aOptions: androidOptions ?? Options.androidOptions,
      );

  // Todo(refactor): should be type T that extends serialization abstract class
  // Todo: For instance all models should extend DataModel which has 2 methods, fromJson and toJson
  //
  /// Returns saved value for key. Returns `null` if the value doesn't exists
  @override
  Future<T?> getValue<T>(SharedPreferencesKey key) async {
    final value = await _storage.read(
      key: key.key,
      iOptions: Options.iosOptions,
      aOptions: Options.androidOptions,
    );
    return value as T;
  }

  /// Sets value for the key
  @override
  Future<bool> setValue<T>(SharedPreferencesKey key, T value) async {
    await _storage.write(
      key: key.key,
      value: jsonEncode(value),
      iOptions: Options.iosOptions,
      aOptions: Options.androidOptions,
    );

    return await containsKey(key.key);
  }
}
