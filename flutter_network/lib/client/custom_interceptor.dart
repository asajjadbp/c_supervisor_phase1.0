
import 'package:dio/dio.dart';
import 'package:networking/client/networking_models/index.dart';
import 'package:networking/client/networking_models/network_delegates/network_localization_delegate.dart';
import 'package:networking/utilities/constants.dart';


class CustomInterceptor extends QueuedInterceptorsWrapper {
  NetworkAuthDelegate? auth;
  NetworkLocalizationDelegate? locale;
  Dio dio;

  CustomInterceptor(this.dio, {this.auth, this.locale});

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      final error = NetworkError.errorFromCode(
        options: err.requestOptions,
        statusCode: err.response!.statusCode!,
        error: err.error,
      );
      if (error.errorType == NetworkErrorType.unauthorized) {
        _handleUnauthorized(error, handler);
      } else {
        handler.next(error);
      }
    } else {
      handler.next(
        NetworkError.errorFromCode(
          options: err.requestOptions,
          statusCode: err.response?.statusCode ??
              NetworkErrorType.noInternetConnection.statusCode,
          error: err.error,
        ),
      );
    }
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    try {
      handler.next(response);
    } catch (e) {
      auth?.onInvalidResponse();
      handler.reject(
        NetworkError.errorFromCode(
          options: response.requestOptions,
          statusCode: NetworkErrorType.responseExposed.statusCode,
          error: 'Response is invalid',
        ),
      );
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _appendLanguageHeader(options.headers);
    await _appendAuthHeader(options.headers);
    handler.next(options);
  }



  Future<void> _handleUnauthorized(
    DioError error,
    ErrorInterceptorHandler handler,
  ) async {
    final options = error.requestOptions;
    final token = await auth?.refreshToken();
    if (token == null) {
      auth?.onRefreshFail();
      return handler.reject(error);
    }
    options.headers[HeaderConst.authHeader] = 'Bearer $token';
    handler.resolve(await dio.fetch(options));
  }

  Future<void> _appendAuthHeader(Map<String, dynamic> headers) async {
    final bool isTokenRequired =
        headers[HeaderConst.isTokenRequired] as bool? ?? false;
    if (isTokenRequired) {
      final token = await auth?.getToken();
      headers[HeaderConst.authHeader] = 'Bearer $token';
    }
    headers.remove(HeaderConst.isTokenRequired);
  }

  Future<void> _appendLanguageHeader(Map<String, dynamic> headers) async {
    final bool isLanguageRequired =
        headers[HeaderConst.isLanguageRequired] as bool? ?? false;
    if (isLanguageRequired) {
      final language = await locale?.getLocale();
      headers[HeaderConst.languageHeader] = language;
    }
    headers.remove(HeaderConst.isLanguageRequired);
  }
}
