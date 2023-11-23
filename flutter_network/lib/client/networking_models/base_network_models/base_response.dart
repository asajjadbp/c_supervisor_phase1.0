import 'package:networking/client/networking_models/index.dart';

class BaseResponse<T> {
  BaseResponse({
    int? code,
    NetworkErrorType? httpStatusCode,
    this.message,
    this.data,
  }) {
    _code = code;
    _httpStatusCode = httpStatusCode;
  }

  late final int? _code;

  late final NetworkErrorType? _httpStatusCode;

  final String? message;



  int get code => (_code ?? _httpStatusCode?.statusCode) ?? 5;

  final T? data;

  bool get _hasHttpError =>
      _httpStatusCode != null &&
      !(_httpStatusCode!.statusCode >= 200 &&
          _httpStatusCode!.statusCode <= 300);

  bool get _hasServerSideError => _code != null && _code! > 0;

  bool get hasError {
    return _hasServerSideError || _hasHttpError;
  }
}

extension ToEntityMapper on BaseResponse {
  BaseResponse<K> copyWith<K>(K data) {
    return BaseResponse(
      code: _code,
      httpStatusCode: _httpStatusCode,
      message: message,
      data: data,
    );
  }
}
