import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget{
  String title;
  String url;
  WebPage(String title, String link){
    this.title =title;
    this.url =link;
  }

  @override
  State<StatefulWidget> createState()=>WebPageState();

}

class WebPageState extends State<WebPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
            onWebViewCreated: (WebViewController web){
              web.loadUrl(widget.url);
            },

          )
        ],
      ) ,
    );
  }

}
