import 'package:flutter/material.dart';
import 'package:flutter_core/extensions/index.dart';

import '../../models/identifiable.dart';
import 'selection_data_provider.dart';
import 'selection_stream_builder_widget.dart';

/// Wraps selection sheet show handlers as an extension on [BuildContext]
extension SelectionSheetPresenter on BuildContext {
  /// Show bottom sheet selection based on [SelectionDataProvider]
  /// and on select action to handler selection.
  ///
  /// Example:
  /// ```dart
  ///   context.showSelectionAsBottomSheet(
  ///      DemoSelectionDataProvider(),
  ///      (e) => [DO SOMETHING],
  ///      'Retry',
  ///    );
  /// ```
  Future<List<int>> showSelectionAsBottomSheet<T extends Identifiable>(
      {required SelectionDataProvider<T> dataProvider,
      required void Function(List<T>) onSelect,
      required String titleText,
      bool isMultipleSelection = false,
      List<int>? prevSelectedItem,
      Object? args,
      required String retryButtonText,
      required String serverErrorMessage,
      required String noConnectionErrorMessage,
      required VoidCallback unAuthorizedCallback}) async {
    final theme = Theme.of(this);
    return await showModalBottomSheet(
      barrierColor: colorScheme.primary.withOpacity(.9),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      context: this,
      builder: (context) => SelectionStreamBuilderWidget(
        prevSelectedItems: prevSelectedItem,
        isMultipleSelection: isMultipleSelection,
        dataProvider: dataProvider,
        retryButtonText: retryButtonText,
        retryButtonColor: theme.colorScheme.secondary,
        titleText: titleText,
        args: args,
        onFinishSelection: onSelect,
        serverErrorMessage: serverErrorMessage,
        noConnectionErrorMessage: noConnectionErrorMessage,
        unAuthorizedCallback: unAuthorizedCallback,
      ),
    );
  }
}
