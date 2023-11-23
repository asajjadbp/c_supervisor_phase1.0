import 'dart:async';

import 'package:flutter/material.dart';

import '/models/identifiable.dart';

/// Show a title in center with a leading close button.
/// A divider is added at the bottom.
class SelectionHeaderWidget<T extends Identifiable> extends StatelessWidget {
  SelectionHeaderWidget(
      {Key? key,
      required this.title,
      required this.isMultipleSelection,
      required this.onFinishSelection,
      required this.selectedListStreamController})
      : super(key: key);

  /// Header title
  final String title;

  ///in case [isMultipleSelection] is 'true' show confirm button
  final bool isMultipleSelection;

  /// on finish selection call back return list of items picked
  final void Function(List<T>) onFinishSelection;

  /// [selectedListStreamController] stream used to detect item clicked and get it's value
  final StreamController<List<T>> selectedListStreamController;

  /// selected list hold all current selected items
  final List<T> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: selectedListStreamController.stream,
        builder: (ctx, snapshot) {
          snapshot.hasData
              ? _handleSelectedItemsFromStreams(
                  snapshot.data as List<T>, context)
              : {};
          return Column(
            children: [
              Row(
                children: [
                  const CloseButton(),
                  const Spacer(),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  // To match close button size thus center the title
                  Visibility(
                    visible: isMultipleSelection,
                    child: IconButton(
                      onPressed: () {
                        /// on confirmation  send the selected items to callback and dismiss the dialog
                        onFinishSelection.call(selectedList);
                        _dismissSheetDialog(context);
                      },
                      icon: Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 0,
              ),
            ],
          );
        });
  }

  /// handle selecting item from list view
  _handleSelectedItemsFromStreams(List<T> selectedItems, BuildContext context) {
    /// if selectedItems length > 1 mean that it's first time to initial   [selectedList] from previous selection
    ///  if selectedItems length  is 1 mean it's normal selection
    if (selectedItems.isNotEmpty) {
      selectedItems.length > 1
          ? selectedList.addAll(selectedItems)
          : selectedList.contains(selectedItems[0])
              ? selectedList.remove(selectedItems[0])
              : selectedList.add(selectedItems[0]);

      /// check if selection is not multiple send the selected items to callback and dismiss the dialog
      if (!isMultipleSelection) {
        onFinishSelection.call(selectedList);
        _dismissSheetDialog(context);
      }
    }
  }

  /// dismiss sheet dialog
  _dismissSheetDialog(BuildContext context) {
    /// convert [selectedList] to list of int ids passed to [SelectionSheetFormRow] when pop
    Iterable<int> _localIDs = selectedList.map((e) => e.value as int);
    Future.delayed(Duration.zero, () async {
      Navigator.pop(context, _localIDs.toList());
    });
  }
}
