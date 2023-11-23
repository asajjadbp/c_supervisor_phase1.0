import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/base_consumer/base_custom_cubit.dart';
import 'package:flutter_core/tools/request_builder/request_state.dart';

import '/utilities/snackbar_presenter.dart';

typedef RequestWidgetBuilder<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
);

/// [BaseBlocConsumer] used to handle status emitted from [BaseCubit]
///
/// Handles [RequestState.error], [RequestState.loading], [RequestState.loaded], [RequestState.unAuthorized] for the UI
/// In case of [RequestState.error] => [ErrorView] is shown and a [retryCallback] is passed to handle retries
/// In case of [RequestState.loading] => on a view which isn't a form ([isConsumerAction] is false)
///   we show [LoadingView]
/// In case of [RequestState.loaded] => we show the passed [childBuilder]
/// Otherwise in case of [RequestState.unAuthorized] => We call [unAuthorizedNavigator.navigateToLogin]
///   Which navigates to login and is implemented in a the application layer
class BaseBlocConsumer<C extends CustomBaseCubit<T>, T>
    extends StatelessWidget {
  /// Denotes that the BlocConsumer is used with an action e.g.: FAB or Button
  ///
  /// Used to show snackBar for the form/actions on submit api failures
  final bool isConsumerAction;

  /// This builder is used to handle the UI in loaded state
  final RequestWidgetBuilder<T> onSuccessBuilder;

  /// This builder is used to handle the UI in error state
  /// in case that we need to show a custom error widget
  final RequestWidgetBuilder<T>? onErrorBuilder;

  /// callback for listener
  final Function(BuildContext, T?)? listenerCallBack;

  /// Error View top padding (optional)
  final double? errorViewTopPadding;

  /// Shows notice on success of the api call
  final bool showNoticeOnSuccess;

  /// this contains the api call to reload the data
  final Function? retryCallback;

  /// Localized retry title added to snack
  final String? localizedActionRetryTitle;

  /// retry snack bar duration
  final Duration? retrySnackBarDuration;

  final String? customErrorMessage;

  final bool isLoadingShown;

  /// This widget passed in case that we need to show custom loading widget
  /// & if [isLoadingShown] is false
  final Widget? customLoadingWidget;

  const BaseBlocConsumer({
    Key? key,
    required this.onSuccessBuilder,
    this.listenerCallBack,
    this.isConsumerAction = false,
    this.errorViewTopPadding,
    this.showNoticeOnSuccess = false,
    this.isLoadingShown = false,
    this.localizedActionRetryTitle,
    this.retrySnackBarDuration,
    this.retryCallback,
    this.onErrorBuilder,
    this.customLoadingWidget,
    this.customErrorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, RequestState<T>>(builder: (context, state) {
      switch (state.status) {
        case RequestStatus.error:
          if (!isConsumerAction && onErrorBuilder != null) {
            return onErrorBuilder!(context, state);
          }
          continue loaded;
        case RequestStatus.loading:
          if (isLoadingShown) {
            return customLoadingWidget ?? const LoadingView();
          }
          continue loaded;
        loaded:
        default:
          return onSuccessBuilder(
            context,
            state,
          );
      }
    }, listener: (context, state) {
      /// handle dialogs
      if (state.status == RequestStatus.error) {
        /// show error dialog if server return some error
        /// TODO(refactor) : show error in SnackBar
        if (isConsumerAction) {
          /// TODO localize error message based on [state.statusCode]
          context.showNotice(
            Notice(
              message: (state.message != null && state.message!.isNotEmpty)
                  ? state.message!
                  : (customErrorMessage ?? ''),
              action: localizedActionRetryTitle,
              actionCallback: retryCallback,
              duration: retrySnackBarDuration,
            ),
          );
        }
      }

      /// call custom [listenerCallBack] if UI have some special implementation
      if (state.status == RequestStatus.loaded) {
        listenerCallBack?.call(context, state.value);
        if (showNoticeOnSuccess) {
          context.showNotice(
            Notice(
              message: state.message ?? '',
            ),
          );
        }
      }
    });
  }
}
