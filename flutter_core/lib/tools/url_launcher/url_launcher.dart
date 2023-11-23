import 'default_url_launcher.dart';

/// Used to handle various tools using url launching outside the app.
abstract class URLLauncher {
  /// Default URL Launcher. Used as instance of [DefaultURLLauncher].
  factory URLLauncher() = DefaultURLLauncher;

  /// Launch string url if valid
  ///
  /// Example:
  ///
  /// ```dart
  /// launchStringUrl("www.google.com");
  /// ```
  Future<bool> launchStringUrl(String url);

  /// Make a phone call with the number passed to it.
  ///
  /// Example:
  ///
  /// ```dart
  ///     final launcher = URLLauncher();
  ///     launcher.call(phoneNumber: "21213123123");
  /// ```
  Future<bool> call({
    required String phoneNumber,
  });

  /// Open email with the mail passed to it,
  /// you can also pass subject and body which are optional.
  ///
  /// Example:
  ///
  /// ```dart
  ///     final launcher = URLLauncher();
  ///     launcher.openMail(
  ///       email: "a.moatasem@victorylink.com",
  ///       subject: "Test Mail",
  ///       body: "Hello all from flutter",
  ///     );
  /// ```
  Future<bool> openMail({
    required String email,
    String subject,
    String body,
  });

  /// Show system default calendar based on device's platform.
  /// Supporting iOS and Android.
  ///
  /// Example:
  ///
  /// ```dart
  ///     URLLauncher().openSystemCalendar();
  /// ```
  Future<bool> openSystemCalendar();


  /// openMap used to open maps on android & ios
  Future<void> openMap(double latitude, double longitude, {String? title});
}
