import 'package:flutter/material.dart';

/// Basic loading view, with a `CircularProgressIndicator` at the center.
class LoadingView extends StatelessWidget {
  const LoadingView({
    Key? key,
    this.color,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: color ?? theme.colorScheme.primary,
      ),
    );
  }
}

/// Places a `CircularProgressIndicator` widget in the middle of a slivered widget.
class LoadingSliverView extends StatelessWidget {
  const LoadingSliverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      child: LoadingView(),
    );
  }
}
