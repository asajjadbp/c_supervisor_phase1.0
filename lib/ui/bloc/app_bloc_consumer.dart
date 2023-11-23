import 'package:c_supervisor/ui/common_reusable/custom_shimmer_list.dart';
import 'package:c_supervisor/utilities/mixins/error_message_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/tools/base_consumer/base_custom_cubit.dart';
import 'package:networking/client/networking_models/index.dart';
import '../common_reusable/custom_error_page.dart';
import '../common_reusable/custom_error_widget.dart';

class AppBlocConsumer<C extends CustomBaseCubit<T>, T extends BaseResponse>
    extends BaseBlocConsumer<C, T> with ErrorMessagesMixin {
  const AppBlocConsumer({
    super.key,
    required super.onSuccessBuilder,
    super.isConsumerAction,
    super.errorViewTopPadding,
    super.isLoadingShown,
    super.showNoticeOnSuccess,
    super.retryCallback,
    super.customLoadingWidget = const CustomShimmerList(),
    super.listenerCallBack,
    this.showErrorAsWidget = false,
    this.errorWidgetPadding = EdgeInsets.zero,
  });

  /// When `true` displays error as a widget instead of error page with scaffold
  final bool showErrorAsWidget;
  final EdgeInsets errorWidgetPadding;

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<C, T>(
      onSuccessBuilder: onSuccessBuilder,
      onErrorBuilder: (context, state) {
        final String errorMessage = getErrorMessage(
          message: state.message,
          statusCode: state.statusCode,
          context: context,
        );
        if (showErrorAsWidget) {
          return CustomErrorWidget(
            errorWidgetPadding: errorWidgetPadding,
            message: errorMessage,
            onRetryPressed: () {
              if (retryCallback != null) retryCallback?.call();
            },
          );
        }
        return CustomErrorPage(
          onRetryPressed: () {
            if (retryCallback != null) retryCallback?.call();
          },

          /// TODO: Handle error messages for internet connection and unhandled network errors here
          message: errorMessage,
        );
      },
      listenerCallBack: listenerCallBack,
      isLoadingShown: isLoadingShown,
      customErrorMessage: getErrorMessage(
        message: context.watch<C>().state.message,
        statusCode: context.watch<C>().state.statusCode,
        context: context,
      ),
      showNoticeOnSuccess: showNoticeOnSuccess,
      isConsumerAction: isConsumerAction,
      customLoadingWidget: customLoadingWidget,
      retryCallback: retryCallback,
    );
  }
}
