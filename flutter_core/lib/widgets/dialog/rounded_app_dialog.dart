import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../action_widget/actions_widget.dart';

/// Rounded AppDialog that is shown across the app
///
/// can contain a title, a smaller subtitle, and multiple footer Actions (buttons)
class RoundedAppDialog extends StatelessWidget {
  /// Primary Constructor
  RoundedAppDialog(
      {Key? key,
      required this.titleTxt,
      this.titleAlignment,
      this.titleStyle,
      this.subtitleText,
      this.subTitleTxt,
      this.titlePadding,
      this.subtitleStyle,
      this.footerActions = const [],
      this.subtitlePadding,
      this.insetPadding})
      : title = Text(
          titleTxt,
          textAlign: titleAlignment,
          style: titleStyle,
        ),
        subtitle = subtitleText != null
            ? Text(subTitleTxt ?? '', style: subtitleStyle)
            : null,
        super(key: key);

  /// custom Constructor with specific subtitle and title
  const RoundedAppDialog.withCustomDialog({
    Key? key,
    this.subtitle,
    this.insetPadding,
    required this.footerActions,
    required this.title,
    this.subtitlePadding,
  })  : titlePadding = EdgeInsets.zero,
        subtitleStyle = null,
        titleStyle = null,
        subTitleTxt = '',
        titleTxt = '',
        subtitleText = '',
        titleAlignment = null,
        super(key: key);

  final EdgeInsets? subtitlePadding;

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  final String titleTxt;

  /// The (optional) dialog's smaller title appears below [title]
  final String? subtitleText;

  /// The  dialog's subtitle widget appears below in custom dialog [title]
  final Widget? subtitle;

  /// The (optional) dialog's alignment title to position the title inside the dialog
  final TextAlign? titleAlignment;

  /// The (optional) dialog's title text style to change the style of the title text
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final EdgeInsets? insetPadding;
  final EdgeInsets? titlePadding;
  final String? subTitleTxt;

  /// The (optional) List of dialog actions
  ///
  /// Typically a list of [Buttons]
  final List<Widget> footerActions;
  final Widget title;
  static const EdgeInsets _defaultInsetPadding =
      EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      insetPadding: insetPadding ?? _defaultInsetPadding,
      titlePadding: titlePadding,
      contentPadding: subtitlePadding ??
          EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      title: title,
      clipBehavior: Clip.antiAlias,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subTitleTxt ?? '') ?? const SizedBox(),
          const Divider(
            height: 10,
          ),
          if (footerActions.isNotEmpty) ActionsWidget(actions: footerActions),
        ],
      ),
    );
  }
}
