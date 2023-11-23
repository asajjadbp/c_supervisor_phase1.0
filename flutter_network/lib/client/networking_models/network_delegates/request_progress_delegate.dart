
class RequestProgressDelegate {

  void Function(int count, int total)? onReceiveProgress;

  RequestProgressDelegate({this.onReceiveProgress});
}
