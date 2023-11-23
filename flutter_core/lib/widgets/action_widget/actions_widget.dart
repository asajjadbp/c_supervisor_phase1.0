import 'package:flutter/material.dart';

import 'horizontal_actions_widget.dart';
import 'vertical_actions_widget.dart';

/// Shows Actions provided either horizontally or vertically
///
/// i.e.: if two action widgets are provided; they are displayed horizontally using [HorizontalActionsWidget]
///       otherwise they are displayed vertically using [VerticalActionItems]
/// @see [HorizontalActionsWidget], [VerticalActionsWidget]
class ActionsWidget extends StatelessWidget {
  const ActionsWidget({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return HorizontalActionsWidget(actions: actions);
  }
}
