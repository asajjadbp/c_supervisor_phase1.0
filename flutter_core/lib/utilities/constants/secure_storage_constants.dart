import '/tools/shared_preferences/key.dart';

/// SecureStorage key constants
///
/// contains keys used to store and retrieve secure storage values
class SecureStorageConstants {
  static const storageTokenDataKey = SharedPreferencesKey('token-data-key');
  static const storageUserDataKey = SharedPreferencesKey('user-data-key');
  static const storageLanguageKey = SharedPreferencesKey('language-key');
  static const isShowBiometricSetup =
      SharedPreferencesKey('is-show-biometric-key');
  static const fileSettingsDataKey =
      SharedPreferencesKey('file-settings-data-key');
}

class SharedPrefsConstants {
  static const userTypeDataKey = SharedPreferencesKey('user-type-key');
  static const userCheckInList = SharedPreferencesKey('user-check-in-list');
  static const onBoardingState = SharedPreferencesKey('on_boarding_state');
}
