import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/utilities/shared_preferences_client/my_shared_preferences.dart';

/// Provides methods to store and retrieve specific data to the SecureStorage
///
///
class SharedPrefsClient {
  static late SharedPrefsClient _instance;
  static MySharedPreferences? _prefs;

  SharedPrefsClient._internal();

  static Future<SharedPrefsClient> get getInstance async {
    _prefs ??= await MySharedPreferences.getInstance();
    _instance = SharedPrefsClient._internal();
    return _instance;
  }

  /// Returns language from encrypted secure storage
  ///
  String? getStoredLanguage() {
    final language = _prefs?.getValue<String?>(
      SecureStorageConstants.storageLanguageKey,
    );
    return language;
  }

  /// Updates / saves the language to the encrypted secure storage
  ///
  void updateLanguage(String language) => _prefs?.setValue(
        SecureStorageConstants.storageLanguageKey,
        language,
      );
}
