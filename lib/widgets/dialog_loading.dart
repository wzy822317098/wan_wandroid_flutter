import 'package:flutter/material.dart';

///@description 网络加载loading
///
///@created by wangzhouyao on 2019-07-16
class DialogLoading extends StatefulWidget {
  String _msg;

  DialogLoading(this._msg, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => DialogLoadingState();
}

class DialogLoadingState extends State<DialogLoading> {
  @override
  Widget build(BuildContext context) {
    return Center();
  }
}
