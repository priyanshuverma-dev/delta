import 'dart:async';

import 'package:delta/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

import '../utils/global_vars.dart';

final webViewKey = GlobalKey<WebViewContainerState>();

class FeedBackScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => const FeedBackScreen(),
      );
  const FeedBackScreen({super.key});

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final Completer<WebViewController> controller =
      Completer<WebViewController>();

  late String _url = 'https://google.com';

  @override
  void initState() {
    super.initState();

    setState(() {
      _url = _url.contains("http:") ? _url.replaceAll("http:", "https:") : _url;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.darkScaffoldColor,
        elevation: 10,
        actions: [
          IconButton(
            tooltip: 'reload',
            icon: Icon(
              Icons.refresh,
              color: Colours.textColor,
            ),
            onPressed: () {
              // using currentState with question mark to ensure it's not null
              webViewKey.currentState?.reloadWebView();
            },
          )
        ],
        title: Text(
          'Feedback',
          style: TextStyle(
            color: Colours.textColor,
          ),
        ),
      ),
      body: WebViewContainer(key: webViewKey),
    );
  }
}

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({Key? key}) : super(key: key);

  @override
  WebViewContainerState createState() => WebViewContainerState();
}

class WebViewContainerState extends State<WebViewContainer> {
  late WebViewController _webViewController;
  bool isloading = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          backgroundColor: Colours.darkScaffoldColor,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
            _webViewController = controller;
          },
          initialUrl: Globals.formUrl,
          onPageFinished: (finish) {
            setState(() {
              isloading = false;
            });
          },
        ),
        isloading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colours.textColor,
                ),
              )
            : const Stack(),
      ],
    );
  }

  void reloadWebView() {
    _webViewController.reload();
  }
}
