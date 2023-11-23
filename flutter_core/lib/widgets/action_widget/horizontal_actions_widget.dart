import 'package:flutter/material.dart';

/// Widget that shows the supplied action widgets horizontally
///
/// [actions] are the action widgets that are to be displayed horizontally
/// next to each other
/// ///  i.e.: displayed as follows :
///  Parent(-- Action - Action --)
class HorizontalActionsWidget extends StatelessWidget {
  const HorizontalActionsWidget({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions
            .map((e) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: e,
                  ),
                ))
            .toList());
  }
}
