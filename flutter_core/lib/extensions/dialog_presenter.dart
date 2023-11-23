import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/index.dart';

import '/widgets/dialog/rounded_app_dialog.dart';

extension DialogPresenter on BuildContext {
  /// Shows the Basic AppDialog and returns any data passed on popping
  ///
  /// Returns a [Future] that resolves to the value (if any) that was passed to
  /// [Navigator.pop] when the dialog was closed.
  ///
  ///
  /// Example:
  /// ```dart
  /// final footerActions = [
  ///   OutlinedButton(
  ///     child: const Text('Cancel'),
  ///     onPressed: () {
  ///       Navigator.of(context).pop();
  ///     },
  ///   ),
  ///   ElevatedButton(
  ///     child: const Text('Okay'),
  ///     onPressed: () {},
  ///   ),
  /// ];
  /// context.showAppDialog("Change Language?",
  /// "are you sure you want to change language", footerActions);
  /// ```
  ///
  Future<T?> showAppDialog<T>({
    required String title,
    String? subtitle,
    TextStyle? titleTextStyle,
    TextStyle? subtitleStyle,
    TextAlign? titleTextAlignment,
    required List<Widget> footerActions,
    Color? backgroundColor = Colors.transparent,
    bool? barrierDismissible,
    EdgeInsets? insetPadding,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: this,
      barrierColor: backgroundColor,
      builder: (BuildContext ctx) {
        return RoundedAppDialog(
          titleTxt: title,
          titleStyle: titleTextStyle,
          subTitleTxt: subtitle ?? '',
          subtitleStyle: subtitleStyle,
          titleAlignment: titleTextAlignment,
          footerActions: footerActions,
          insetPadding: insetPadding,
        );
      },
    );
  }
 /// show custom dialog with specific subtitle and dialogTitle widgets
  Future<T?> showCustomAppDialog<T>({
    required Widget subtitle,
    required Widget dialogTitle,
    required List<Widget> footerActions,
    Color? backgroundColor = Colors.transparent,
    bool? barrierDismissible,
    EdgeInsets? insetPadding,
    EdgeInsets? subtitlePadding,
  }) {
    return showDialog(
      barrierDismissible: barrierDismissible ?? true,
      context: this,
      barrierColor: backgroundColor,
      builder: (BuildContext ctx) {
        return RoundedAppDialog.withCustomDialog(
          title: dialogTitle,
          footerActions: footerActions,
          subtitle: subtitle,
          insetPadding: insetPadding,
          subtitlePadding: subtitlePadding,
        );
      },
    );
  }
}

extension ErrorDialogPresenter on BuildContext {
  Future<T?> showErrorDialog<T>({
    String? title,
    String? errorMessage,
    String? buttonText,
    TextStyle? buttonStyle,
    VoidCallback? retryCallback,
  }) {
    return showAppDialog(
      title: title ?? '',
      subtitle: errorMessage ?? '',
      footerActions: [
        ElevatedButton(
          child: FittedBox(
            child: Text(
              buttonText ?? '',
              style: buttonStyle,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
          ),
          onPressed: () {
            retryCallback?.call();
            Navigator.of(this).pop();
          },
        ),
      ],
    );
  }
}
