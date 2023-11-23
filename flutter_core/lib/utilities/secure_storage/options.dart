import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Options {
  /// Gets the common android options for secure storage
  ///
  /// enables securing the data using the [encryptedSharedPreferences]
  static AndroidOptions get androidOptions => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  /// Gets the ios options
  ///
  /// [IOSOptions.defaultAccountName] is the namespace where all the entries are kept
  /// if we save 'abc' in the account namespace 'account' and change to another account namespace
  /// like 'account5'; we won't find the entry 'abc'.
  static IOSOptions get iosOptions => const IOSOptions();
}
