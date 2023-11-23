
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggerInterceptor extends QueuedInterceptorsWrapper {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log(
      '┌🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬',
      name: 'NetworkError',
    );
    log(
      '''
| Time: ${DateTime.now()}
| Endpoint: ${err.requestOptions.method} ${err.requestOptions.uri}
| Error: ${err.error}: ${err.response}''',
      name: 'NetworkError',
    );
    log(
      '└🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬🤬',
      name: 'NetworkError',
    );
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headers = '';
    options.headers.forEach((key, value) {
      headers += '| $key: $value\n';
    });

    log(
      '┌🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀',
      name: 'Request',
    );
    log(
      '''
| Time: ${DateTime.now()}
| Request: ${options.method} ${options.uri}
| Request Body: ${options.data}
| Headers:\n$headers''',
      name: 'Request',
    );
    log(
      '└🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀',
      name: 'Request',
    );
    handler.next(options); //continue
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log(
      '┌✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅',
      name: 'Response',
    );
    log(
      '''
| Time: ${DateTime.now()}
| Endpoint: ${response.requestOptions.method} ${response.requestOptions.uri}
| Response Body [code ${response.statusCode}]: \n${response.data}''',
      name: 'Response',
    );
    log(
      '└✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅✅',
      name: 'Response',
    );
    handler.next(response);
  }
}
