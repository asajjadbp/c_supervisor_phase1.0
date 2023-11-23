import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart' as webView;

/// WebView widget which takes a [url] to open a [WebView] page.
class WebView extends StatelessWidget {
  const WebView(
      {Key? key, required this.url, this.backgroundColor = Colors.white})
      : super(key: key);

  final String url;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return webView.WebView(
      onWebViewCreated: (controller) {
        controller.loadUrl(url);
      },
      debuggingEnabled: kDebugMode,
      backgroundColor: backgroundColor,
      javascriptMode: webView.JavascriptMode.unrestricted,
    );
  }
}
