import 'package:flutter/material.dart';

/// Widget that shows the supplied action widgets Vertically below each other
///
/// [actions] are the action widgets that are to be displayed vertically below one another
///  and each widget is centered and occupies half the parent's width
///  i.e.: displayed as follows :
///  Parent(--- Action ---)
///  Parent(--- Action ---)
///  Parent(--- Action ---)
///
///  @see [WidgetActions]
class VerticalActionsWidget extends StatelessWidget {
  const VerticalActionsWidget({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: actions
          .map((e) => Flexible(
                    child: e,
                  ),)
          .toList(),
    );
  }
}
