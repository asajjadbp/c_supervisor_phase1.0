import 'dart:async';

import 'package:flutter/material.dart';

import '/models/identifiable.dart';
import '/widgets/selection_sheet/selection_stream_builder_widget.dart';

/// Used as a part of [SelectionStreamBuilderWidget] wo show a list of selection items.
class SelectionListWidget<T extends Identifiable> extends StatefulWidget {
  SelectionListWidget({
    Key? key,
    required this.originList,
    this.selectedListStreamController,
    this.isMultipleSelection,
    required this.selectedList,
  }) : super(key: key) {
    isMultipleSelection ?? false ? _fillInitialSelectedItems(selectedList) : {};
  }

  ///in case [isMultipleSelection] is 'true' enable multiple selection
  final bool? isMultipleSelection;

  /// contains all list items that appears on bottom sheet
  final List<T> originList;

  /// initial selected items
  final List<int> selectedList;

  /// [selectedListStreamController]  used to stream the selected list to the header
  late final StreamController<List<T>>? selectedListStreamController;

  /// filing actual selected list with initial selected values using   [selectedListStreamController]
  void _fillInitialSelectedItems(List<int> ids) {
    List<T> initialSelectedItems = [];
    for (final id in ids) {
      initialSelectedItems
          .add(originList.firstWhere((element) => element.value == id));
    }
    selectedListStreamController?.add(initialSelectedItems);
  }

  @override
  State<SelectionListWidget<T>> createState() => SelectionListWidgetState<T>();
}

class SelectionListWidgetState<T extends Identifiable>
    extends State<SelectionListWidget<T>> {
  final List<int> currentSelectedItems = [];

  @override
  void initState() {
    super.initState();
    currentSelectedItems.addAll(widget.selectedList);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) => ListTile(
            tileColor: _validateSelectedSelection(index),
            title: Text(widget.originList[index].toString()),
            onTap: () => _onUserTap(index)),
        itemCount: widget.originList.length,
      ),
    );
  }

  /// detected when user tap on item
  _onUserTap(int index) {
    /// stream the selected list to the header
    widget.selectedListStreamController?.add([widget.originList[index]]);
    setState(() {
      /// change list tile BG if it's selected
      if (currentSelectedItems.contains((widget.originList[index].value))) {
        currentSelectedItems.remove(widget.originList[index].value as int);
      } else {
        currentSelectedItems.add(widget.originList[index].value as int);
      }
    });
  }

  /// highlight initially selected items
  Color? _validateSelectedSelection(int index) {
    if (currentSelectedItems.contains((widget.originList[index].value))) {
      return Theme.of(context).colorScheme.secondary;
    } else {
      return null;
    }
  }
}
