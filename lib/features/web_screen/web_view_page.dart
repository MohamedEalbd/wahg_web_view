import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  const WebViewPage({super.key, required this.url});

  static const route = "webViewPage";

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final WebViewController _viewController = WebViewController();

  WebViewController _display(String url) {
    return _viewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (d, v) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Haye"),
                  content: Text("Are you sure you want to exit"),
                  actions: [
                    Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.maybePop(context);
                          },
                          child: Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            exit(0);
                          },
                          child: Text("Yes"),
                        ),
                      ],
                    ),
                  ],
                ));
      },
      child: Scaffold(
        body: SafeArea(child: WebViewWidget(controller: _display(widget.url))),
      ),
    );
  }
}
