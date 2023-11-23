import 'package:flutter/material.dart';

extension NoticePresenter on BuildContext {
  static const Duration _snackBarDisplayDuration = Duration(milliseconds: 4000);

  /// Show snackBar with default app theme and configurations
  ///
  /// For an action to be shown, [actionTitle] and [action] should not be `null`
  showNotice(Notice notice) {
    final snackBar = SnackBar(
      content: Text(notice.message),
      duration: notice.duration ?? _snackBarDisplayDuration,
      behavior: SnackBarBehavior.floating,
      action: (notice.action != null && notice.actionCallback != null)
          ? SnackBarAction(
              label: notice.action!,
              onPressed: () => notice.actionCallback?.call(),
            )
          : null,
    );

    /// Generate feedback if has value
    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

/// Used to hold the data needed for notice presenter
class Notice {
  Notice(
      {required this.message,
      this.action,
      this.actionCallback,
      this.duration});

  /// Message
  String message;

  /// Action title
  String? action;

  /// Action callback
  Function? actionCallback;


  /// snackbar duration
  Duration? duration;
}
