
abstract class NetworkAuthDelegate {
  Future<String> getToken();

  Future<String?> refreshToken();

  Future<void> onRefreshFail();


  dynamic onInvalidResponse();
}
