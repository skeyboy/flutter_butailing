import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

@RoutePage()
class WebScreen extends StatefulWidget {
  const WebScreen({super.key, @pathParam this.url, @pathParam this.title});

  final String? url;
  final String? title;

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  late InAppWebViewController? _controller;
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_controller != null) {
          bool canGoBack = await _controller!.canGoBack();
          if (canGoBack) {
            _controller!.goBack();
            return false;
          }
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title ?? 'Web View')),
        body: InAppWebView(
          onWebViewCreated: (controller) => _controller = controller,
          initialUrlRequest: URLRequest(
            url: WebUri.uri(
              Uri.parse(widget.url ?? 'https://www.github.com/skeyboy'),
            ),
          ),
        ),
      ),
    );
  }
}
