import 'dart:ui';

import 'package:async/async.dart';

class DebouncerUtil {
  DebouncerUtil(int durationInMillis) {
    _debounceDelayTime = Duration(milliseconds: durationInMillis);
  }

  /// [_cancellableOperation] used to cancel debounce  search operation in case user enter new search query
  CancelableOperation<void>? _cancellableOperation;

  /// [_debounceDelayTime] the time is taken before new network call  called
  late final Duration _debounceDelayTime;

  /// _resetDebounceTimer : reset the timer for debounce
  void _resetDebounceTimer() {
    _cancellableOperation = CancelableOperation.fromFuture(
      Future.delayed(_debounceDelayTime),
    );
  }

  void onSearchQueryChanged(VoidCallback action) {
    _cancellableOperation?.cancel();
    _resetDebounceTimer();
    _cancellableOperation?.value.whenComplete(() {
      action.call();
    });
  }
}
