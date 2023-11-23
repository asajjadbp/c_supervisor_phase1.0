import 'package:dio/dio.dart';
import 'package:networking/client/networking_models/error_models/network_error_type.dart';

class NetworkError extends DioError {
  final NetworkErrorType errorType;

  NetworkError({
    required super.requestOptions,
    required this.errorType,
    super.error,
  });

  factory NetworkError.errorFromCode({
    required RequestOptions options,
    required int statusCode,
    required dynamic error,
  }) {
    return NetworkError(
      requestOptions: options,
      error: error,
      errorType: NetworkErrorType.getType(statusCode),
    );
  }
}
