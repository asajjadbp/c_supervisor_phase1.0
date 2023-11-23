import 'package:flutter/material.dart';
import 'package:networking/client/networking_models/index.dart';

extension NetworkErrorTypeMessage on NetworkErrorType {
  String getErrorMessage(BuildContext context) {
    switch (this) {
      case NetworkErrorType.badRequest:
        return 'badRequest';
      case NetworkErrorType.unauthorized:
        return '';
      case NetworkErrorType.forbidden:
        return 'forbiddenAccess';
      case NetworkErrorType.notFound:
        return 'No Result Found';
      case NetworkErrorType.conflict:
        return '';
      case NetworkErrorType.internalServerError:
        return '';
      case NetworkErrorType.responseExposed:
        return '';
      case NetworkErrorType.noInternetConnection:
        return 'error';
      default:
        return '';
    }
  }
}
