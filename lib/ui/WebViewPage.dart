

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/DemoColor.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebViewPage extends StatelessWidget{
  String url;
  String title;
  WebViewPage(this.url,this.title);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: DemoColor.currentColorTheme,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.of(context).pop();
        })
      ),
      url:  url,
      withJavascript: true,
      withLocalStorage: true,
      withZoom: false,
    );
  }
}