import 'package:flutter/material.dart';

/// Placeholder Widget Constants
class PlaceHolderPadding {
  /// Padding around widget
  static const padding = EdgeInsets.all(20.0);
}

/// Used to show optional image, title, subtitle and button if any.
class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({
    Key? key,
    this.child,
    this.title,
    this.subtitle,
    this.action,
    this.actionCallback,
  }) : super(key: key);

  /// Top widget, ex: Icon. Hidden if `null`.
  final Widget? child;

  /// Title text. Hidden if `null`.
  final Widget? title;

  /// Subtitle text. Hidden if `null`.
  final Widget? subtitle;

  /// Button title text. Required for the button to be visible.
  final Widget? action;

  /// Button click action. Required for the button to be visible.
  final void Function()? actionCallback;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: PlaceHolderPadding.padding,
        child: Column(
          /// align holder page in center
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (child != null) child!,
            if (title != null) title!,
            if (subtitle != null) subtitle!,
            if (actionCallback != null && action != null)
              TextButton(
                onPressed: actionCallback!,
                child: action!,
              ),
          ],
        ),
      ),
    );
  }
}
