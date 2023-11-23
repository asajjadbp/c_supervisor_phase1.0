import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:networking/client/custom_interceptor.dart';
import 'package:networking/client/networking_models/config_models/global_network_config.dart';
import 'package:networking/client/networking_models/config_models/route_config.dart';
import 'package:networking/client/networking_models/index.dart';
import 'package:networking/client/tools/network_decoder.dart';
import 'package:networking/utilities/constants.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class NetworkManager {
  NetworkManager._internal() {
    _dio = Dio();
  }

  static final NetworkManager instance = NetworkManager._internal();
  late Dio _dio;
  GlobalNetworkConfig config = GlobalNetworkConfig();

  void configure(GlobalNetworkConfig config) {
    this.config = config;
    _setupDio();
  }

  void _setupDio() {
    _dio.options = BaseOptions(baseUrl: config.baseUrl);
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      CustomInterceptor(
        _dio,
        auth: config.auth,
        locale: config.locale,
      ),
    );

    if (kDebugMode) {
      // _dio.interceptors.add(
      //   LoggerInterceptor(),
      // );
      _dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: true,
            printResponseHeaders: true,
            printResponseMessage: true,
            printRequestData: true,
            printResponseData: true,
          ),
        ),
      );
    }
  }

  Future<BaseResponse<K?>> request<T extends BaseNetworkDeserializable, K>(
    RouteConfig routeConfig,
    T responseType,
  ) async {
    final headers = _setupHeaders(routeConfig);
    try {
      Response<dynamic> response;
      if (routeConfig.requestType == RequestType.upload) {
        response = await _handleUpload(routeConfig, headers);
      } else {
        response = await _handleRequest(routeConfig, headers);
      }
      return NetworkDecoder.shared
          .decode<T, K>(response: response, responseType: responseType);
    } on NetworkError catch (error, stackTrace) {
      log(
        'Request Error',
        name: 'NetworkError',
        error: error,
        stackTrace: stackTrace,
      );

      return BaseResponse(
        httpStatusCode: error.errorType,
      );
    } catch (error, stackTrace) {
      log(
        'Request Error',
        name: 'NetworkError',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Map<String, dynamic> _setupHeaders(RouteConfig routeConfig) {
    /// Injects Flags Into The Headers for Interceptors to handle
    final Map<String, dynamic> headers = {};
    headers.addEntries(routeConfig.headers.entries);
    headers[HeaderConst.isTokenRequired] = routeConfig.isTokenRequired;
    headers[HeaderConst.isLanguageRequired] = config.isLanguageRequired;
    return headers;
  }

  Future<Response<dynamic>> _handleRequest(
    RouteConfig routeConfig,
    Map<String, dynamic> headers,
  ) async {
    return _dio.fetch(
      RequestOptions(
        baseUrl: routeConfig.baseUrl ?? config.baseUrl,
        method: routeConfig.requestType.method,
        path: routeConfig.path,
        queryParameters: routeConfig.parameters,
        data: routeConfig.body,
        sendTimeout: NetworkConst.timeout,
        headers: headers,
        onReceiveProgress:
            routeConfig.requestProgressDelegate?.onReceiveProgress,
      ),
    );
  }

  Future<Response<dynamic>> _handleUpload(
    RouteConfig routeConfig,
    Map<String, dynamic> headers,
  ) async {
    if (routeConfig.files != null && routeConfig.files!.isNotEmpty) {
      final List<MultipartFile> multipartFiles = [];
      for (final file in routeConfig.files!) {
        multipartFiles.add(MultipartFile.fromFileSync(file.path));
      }
      return _dio.post(
        (routeConfig.baseUrl ?? config.baseUrl) + routeConfig.path,
        options: Options(
          method: routeConfig.requestType.method,
          headers: headers,
        ),
        data: FormData.fromMap(
          {
            routeConfig.filesArrayName ?? '': multipartFiles,
          },
        ),
        onSendProgress: routeConfig.requestProgressDelegate?.onReceiveProgress,
      );
    } else {
      throw Exception('Files either null or is empty');
    }
  }
}
