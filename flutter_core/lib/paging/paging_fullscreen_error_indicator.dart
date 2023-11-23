import 'package:flutter/material.dart';

import '../widgets/placeholder_widget.dart';

/// Displays icon, title, message and retry button actions
///
class PagingFullscreenErrorIndicator extends StatelessWidget {
  const PagingFullscreenErrorIndicator({
    Key? key,
    this.title,
    this.message,
    required this.retryTitle,
    required this.onAction,
  }) : super(key: key);

  static SizedBox spacing() => const SizedBox(height: 5);

  final String? title;
  final String? message;
  final String retryTitle;
  final Function onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PlaceholderWidget(
      subtitle: Text(
        message ?? '' /*context.localization.somethingWentWrong*/,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      action: Text(
        retryTitle,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
      actionCallback: () => onAction(),
      child: Icon(
        Icons.error_outline_rounded,
        size: 120,
        color: theme.colorScheme.secondary,
      ),
    );
  }
}
