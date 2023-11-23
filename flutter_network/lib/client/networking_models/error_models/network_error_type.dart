enum NetworkErrorType {
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  internalServerError(500),
  noInternetConnection(900),
  responseExposed(901);

  final int statusCode;
  const NetworkErrorType(this.statusCode);


  static NetworkErrorType getType(int code) {
    switch (code) {
      case 400:
        return NetworkErrorType.badRequest;
      case 401:
        return NetworkErrorType.unauthorized;
      case 403:
        return NetworkErrorType.forbidden;
      case 404:
        return NetworkErrorType.notFound;
      case 500:
        return NetworkErrorType.internalServerError;
      case 901:
        return NetworkErrorType.responseExposed;
      default:
        return NetworkErrorType.noInternetConnection;
    }
  }
}
