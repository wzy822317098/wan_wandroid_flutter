import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget{
  final String title;
 final String url;
  const WebPage( {Key key, this.title, this.url}):super(key:key);

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
