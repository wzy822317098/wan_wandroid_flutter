import 'package:flutter/material.dart';
import 'package:wan_wandroid/utils/colors_utils.dart';
import 'package:wan_wandroid/model/system_model.dart';
import 'package:wan_wandroid/page/system_child_page.dart';

///@description 体系item组件
///
///@created by wangzhouyao on 2019-07-15
class ItemSystem extends StatefulWidget {
  final SystemEntity _systemModelEntity;
  const ItemSystem(this._systemModelEntity);
  @override
  State<StatefulWidget> createState() => ItemSystemState();
}

class ItemSystemState extends State<ItemSystem> {
  List<Widget> _categoryWidges = List();
  @override
  void initState() {
    super.initState();
    _getWigets();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child:Text(
                widget._systemModelEntity.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, color: ColorsUtils.color_title),
              ) ,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.centerLeft,
              child: Wrap(
                children: _categoryWidges,
                spacing: 10,
                runSpacing: 10,
              ),
            )

          ],
        )
    );
  }

  void _getWigets() {
    widget._systemModelEntity.children.forEach((it){
        _categoryWidges.add(new GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: Text(it.name),
          ),
          onTap: (){
            _toSystemChild(it);
        },
        ));
    });
  }

  void _toSystemChild(SystemEntity entity){
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return SystemChildPage(entity);
    }));
  }
}
