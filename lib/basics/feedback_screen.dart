import 'dart:async';

import 'package:answer_it/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webview_flutter/webview_flutter.dart';

final webViewKey = GlobalKey<WebViewContainerState>();

class FeedBackScreen extends StatefulWidget {
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
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colours.textColor,
          ),
        ),
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
  @override
  void dispose() {
    super.dispose();
  }

  late WebViewController _webViewController;
  bool isloading = true;

  String url =
      'https://docs.google.com/forms/d/e/1FAIpQLSdQ1APKp1-7VOLQ_xV6URhPT4n3MwDD_Kzkx5qzOE_dhTE2jw/viewform?usp=sf_link';

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
          initialUrl: url,
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
