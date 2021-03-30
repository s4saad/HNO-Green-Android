import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttersipay/utils/api_endpoints.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class ResetPasswordWebView extends StatefulWidget {
  final String url;

  ResetPasswordWebView(this.url);

  @override
  _ResetPasswordWebViewState createState() => _ResetPasswordWebViewState();
}

class _ResetPasswordWebViewState extends State<ResetPasswordWebView> {
  @override
  void initState() {
    super.initState();

    final flutterWebviewPlugin = new FlutterWebviewPlugin();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains(
          'https://${APIEndPoints.server}.sipay.com.tr/merchant/login'))
        Navigator.of(context).pop(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(translator.translate("resetPass")),
      ),
      url: widget.url,
      withJavascript: true,
    );
  }
}
