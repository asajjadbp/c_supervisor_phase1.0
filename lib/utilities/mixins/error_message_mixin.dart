import 'package:c_supervisor/utilities/extensions/network_error_type_ext.dart';
import 'package:flutter/material.dart';
import 'package:networking/client/networking_models/index.dart';

mixin ErrorMessagesMixin {
  /// Returns either the [message] or
  /// the [NetworkErrorTypeMessage.getErrorMessage]
  String getErrorMessage({
    String? message,
    int? statusCode,
    required BuildContext context,
  }) {
    final String errorMessage;
    if (message?.isNotEmpty == true) {
      errorMessage = message ?? '';
    } else {
      errorMessage =
          NetworkErrorType.getType(statusCode ?? 5).getErrorMessage(context);
    }
    return errorMessage;
  }
}
