import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';

///@description web页面展示工具
///
///@created by wangzhouyao on 2019-07-10
class WebPage extends StatefulWidget {
  final String title;
  final String url;
  const WebPage({Key key, this.title, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WebPageState();
}

class WebPageState extends State<WebPage> {
  WebViewController _controller;
  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: ColorsUtils.color_title,
              ),
              onPressed: (){
                if(_controller !=null){
                  _controller.canGoBack().then((b){
                    if(b){
                      _controller.goBack();
                    }else{
                      Navigator.maybePop(context);
                    }
                  });
                }else{
                  Navigator.maybePop(context);
                }
              }),
          title: Text(
            widget.title,
            style: TextStyle(color: ColorsUtils.color_title, fontSize: 16),
          ),
          actions: <Widget>[
            loading
                ? Container(
                    margin: const EdgeInsets.all(18),
                    width: 20.0,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ))
                : Container(),
            IconButton(
              icon: Icon(Icons.clear),
              color: ColorsUtils.color_title,
              onPressed: () {
                Navigator.maybePop(context);
              },
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController web) {
                _controller = web;
                web.loadUrl(widget.url);
              },
              onPageFinished: (url) {
                setState(() {
                  loading = false;
                });
              },
            )
          ],
        ),
      ),
      onWillPop: _onBack,
    );
  }

  Future<bool> _onBack() async{

    if (_controller != null) {
      return _controller.canGoBack().then((b) {
        if (b) {
          _controller.goBack();
        }
        return Future.value(!b);
      });
    }
    return Future.value(true);
  }
}
