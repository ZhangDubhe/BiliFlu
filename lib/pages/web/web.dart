import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  String uri;

  WebPage({this.uri = 'https://www.bilibili.com'});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: widget.uri,
          javascriptMode: JavascriptMode.unrestricted,
          initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
        ),
      ),
    );
  }
}
