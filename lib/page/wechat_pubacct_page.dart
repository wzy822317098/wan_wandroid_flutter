import 'package:flutter/material.dart';
import 'package:wan_wandroid/network/network_utils.dart';
import 'package:wan_wandroid/widgets/frag_wechat_articles.dart';

///@description
///
///@created by wangzhouyao on 2019-07-16
class WechatPubAcctPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WechatPubAcctPageState();
}

class WechatPubAcctPageState extends State<WechatPubAcctPage>
    with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {
  List<Widget> _wechatPubAcct;
  List<Widget> _articlePages =List();
  TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NetworkUtils.instance.getWechatPubAcct().then((data) {
      setState(() {
        _wechatPubAcct = List();
        data.data.forEach((it) {
          _wechatPubAcct.add(Tab(
            text: it.name,
          ));
          _articlePages.add(FragWechatArticles(it));
        });
        _controller = TabController(length: _articlePages.length, vsync: this);
        _controller.addListener((){
          switch(_controller.index){

          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: _wechatPubAcct != null
            ? TabBar(
                isScrollable: true,
                tabs: _wechatPubAcct,
                controller: _controller,
              )
            : Container(),
      ),
      body:_controller !=null? TabBarView(children: _articlePages,controller: _controller,):Container(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
