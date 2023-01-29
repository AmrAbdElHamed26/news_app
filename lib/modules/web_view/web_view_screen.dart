import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewScreen extends StatelessWidget {
  final String url ;

  WebViewScreen( {Key? key, required this.url}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Web Data',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.web_rounded),
          ),
        ],
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold ,
          fontSize: 20 ,
        ),
      ),
      body: WebView(

        initialUrl: url ,
      ),
    );
  }
}
