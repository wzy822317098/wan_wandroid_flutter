import 'package:flutter/material.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';
import 'package:wan_wandroid/widgets/item_system.dart';
import 'package:wan_wandroid/network/network_utils.dart';
import 'package:wan_wandroid/model/system_model.dart';

///@description 体系页面
///
///@created by wangzhouyao on 2019-07-10
class SystemPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SystemPageState();
  }
  
}

class SystemPageState extends State<SystemPage> with AutomaticKeepAliveClientMixin {
  List<SystemEntity> _systemList;
  @override
  void initState() {
    super.initState();
    NetworkUtils.instance.getSystem().then((data){
      setState(() {
        _systemList =data.data;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: ColorsUtils.color_bg,
      appBar: new AppBar(
        title:Text('体系',
          style: TextStyle(fontSize: 16, color: ColorsUtils.color_title),),
      ),
      body:_systemList!=null? ListView.separated(itemBuilder: (context ,index){
        return ItemSystem(_systemList[index]);
      }, separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 0,), itemCount: _systemList.length):Container(),
    );
  }

  @override
  bool get wantKeepAlive => true;
  
}