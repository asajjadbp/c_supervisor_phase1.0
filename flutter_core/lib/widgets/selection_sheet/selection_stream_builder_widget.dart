import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';

import '../placeholder_widget.dart';
import 'selection_header_widget.dart';
import 'selection_list_widget.dart';

/// Used to fetch and show scrollable list of selected text tiles.
///
/// A [PlaceholderWidget] should be shown in case of failure.
/// If loading, a [CircularProgressIndicator] will be shown.
/// Retry is available in case of failure.
///
class SelectionStreamBuilderWidget<T extends Identifiable>
    extends StatefulWidget {
  /// Used to provide data feed.
  final SelectionDataProvider dataProvider;

  /// Title to be shown in the header.
  final String titleText;

  /// Placeholder widget retry button text.
  final String retryButtonText;

  ///in case [isMultipleSelection] is 'true' enable multiple selection
  final bool? isMultipleSelection;

  /// call back called when user finish his selection
  final void Function(List<T>) onFinishSelection;

  /// initial selected items
  final List<int>? prevSelectedItems;

  /// hold args used in  fetch data
  final Object? args;

  final String serverErrorMessage;

  final String noConnectionErrorMessage;

  final Color retryButtonColor;

  final VoidCallback unAuthorizedCallback;

  const SelectionStreamBuilderWidget(
      {Key? key,
      required this.dataProvider,
      required this.titleText,
      required this.retryButtonText,
      required this.onFinishSelection,
      this.prevSelectedItems,
      this.args,
      this.isMultipleSelection = false,
      required this.serverErrorMessage,
      required this.noConnectionErrorMessage,
      required this.retryButtonColor,
      required this.unAuthorizedCallback})
      : super(key: key);

  @override
  _SelectionStreamBuilderWidgetState createState() =>
      _SelectionStreamBuilderWidgetState<T>();
}

class _SelectionStreamBuilderWidgetState<T extends Identifiable>
    extends State<SelectionStreamBuilderWidget> {
  late StreamController<List<Identifiable>> _streamController;

  /// [selectedListStreamController] hold current selected list
  late StreamController<List<T>> selectedListStreamController;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  /// Fetch data if the stream is not closed.
  Future<void> _fetchData() async {
    try {
      _refreshStream();
      final response = await widget.dataProvider.fetchData(args: widget.args);
      _performStreamIfPossible(() => _streamController.add(response));
        } catch (exception) {
      _performStreamIfPossible(
          () => _streamController.addError(getErrorMessage(1)));
      /*   _performStreamIfPossible(
              () => _streamController.addError(getErrorMessage(1)));
      if (exception is NetworkingException) {
        if (exception is UnauthorizedException) {
          /// check if [exception] is [UnauthorizedException]  call [unAuthorizedCallback] to direct user to login page
          widget.unAuthorizedCallback.call();
        } else {

        }
      } else {
        _performStreamIfPossible(() => _streamController.addError(exception));
      }*/
    }
  }

  /// Check if the stream if not closed before performing any operation on it.
  void _performStreamIfPossible(void Function() action) {
    if (!_streamController.isClosed) {
      action();
    }
  }

  /// Refresh stream, called when the refresh if requested.
  void _refreshStream() {
    setState(() {
      _streamController = StreamController<List<T>>();
      selectedListStreamController = StreamController<List<T>>();
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (ctx, snapshot) => SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.50,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectionHeaderWidget<T>(
                title: widget.titleText,
                isMultipleSelection: widget.isMultipleSelection ?? false,
                onFinishSelection: widget.onFinishSelection,
                selectedListStreamController: selectedListStreamController,
              ),
              _VisibleContentWidget<T>(
                this,
                snapshot,
                widget.isMultipleSelection,
                widget.prevSelectedItems,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getErrorMessage(int errorStatusCode) {
    const String errorMessage = 'initial error message ';
    /* final type = exception.networkExceptionTypes;
    switch (type) {
      case NetworkExceptionTypes.serverError:
        errorMessage = widget.serverErrorMessage;
        break;
      case NetworkExceptionTypes.connectionError:
        errorMessage = widget.noConnectionErrorMessage;
        break;
      default:
        errorMessage = exception.message;
    }*/
    return errorMessage;
  }
}

/// Holds logic for visible widget based on current snapshot state.
class _VisibleContentWidget<T extends Identifiable> extends StatelessWidget {
  const _VisibleContentWidget(
    this.sourceWidgetState,
    this.snapshot,
    this.isMultipleSelection,
    this.prevSelectedItems, {
    Key? key,
  }) : super(key: key);

  final _SelectionStreamBuilderWidgetState<T> sourceWidgetState;
  final AsyncSnapshot snapshot;

  /// initial selected items
  final List<int>? prevSelectedItems;

  ///in case [isMultipleSelection] is 'true' enable multiple selection
  final bool? isMultipleSelection;

  @override
  Widget build(BuildContext context) {
    switch (snapshot.connectionState) {
      case (ConnectionState.waiting):
        return const Padding(
          padding: EdgeInsets.all(40.0),
          child: CircularProgressIndicator(),
        );

      case (ConnectionState.active):
        if (snapshot.hasError) {
          return PlaceholderWidget(
            title: Text(snapshot.error.toString()),
            action: Text(
              sourceWidgetState.widget.retryButtonText,
              style:
                  TextStyle(color: sourceWidgetState.widget.retryButtonColor),
            ),
            actionCallback: sourceWidgetState._fetchData,
          );
        }

        if (snapshot.hasData) {
          return SelectionListWidget<T>(
            selectedList: prevSelectedItems ?? [],
            originList: snapshot.data as List<T>,
            selectedListStreamController:
                sourceWidgetState.selectedListStreamController,
            isMultipleSelection: isMultipleSelection,
          );
        }
        break;

      default:
        break;
    }

    return const SizedBox(
      height: double.minPositive,
      width: double.minPositive,
    );
  }
}
