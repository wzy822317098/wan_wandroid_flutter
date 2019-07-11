import 'package:flutter/material.dart';

///@description 提示弹框工具类
///
///@created by wangzhouyao on 2019-07-10
class DialogUtils {
  static DialogUtils _instance;
  static DialogUtils getInstance() {
    if (_instance == null) {
      _instance = DialogUtils();
    }
    return _instance;
  }

  void showAlertDialog(BuildContext context, String title, String msg,
      {positiveStr,
      positiveListener,
      negativeStr,
      negativeListener,
      bool canCancel = true}) {
    showDialog(
        context: context,
        barrierDismissible: canCancel,
        builder: (BuildContext context) => WillPopScope(
              child: AlertDialog(
                title: Text(title),
                content: Text(msg),
                actions: <Widget>[
                  negativeStr != null
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            alignment: Alignment.center,
//                        padding: const EdgeInsets.all(14),
                            child: Text(
                              negativeStr,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            negativeListener();
                          },
                        )
                      : Container(),
                  positiveStr != null
                      ? GestureDetector(
                    behavior: HitTestBehavior.opaque,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              positiveStr,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            positiveListener();
                          },
                        )
                      : Container()
                ],
              ),
              onWillPop: () async {
                return Future.value(canCancel);
              },
            )
//        builder: (BuildContext context) {
//          return
//          AlertDialog(
//            title: Text(title),
//            content: Text(msg),
//            actions: <Widget>[
//              negativeStr != null
//                  ? GestureDetector(
//                      child: Container(
//                        padding: const EdgeInsets.all(10),
//                        child: Text(
//                          negativeStr,
//                          style: TextStyle(color: Colors.grey),
//                        ),
//                      ),
//                      onTap: () {
//                        Navigator.pop(context);
//                        negativeListener();
//                      },
//                    )
//                  : Container(),
//              positiveStr != null
//                  ? GestureDetector(
//                child:Container(
//                  padding: const EdgeInsets.all(10),
//                  child: Text(positiveStr,style: TextStyle(
//                    color: Colors.black
//                  ),),
//                ),
//                onTap: (){Navigator.pop(context);
//                positiveListener();},
//              ) : Container()
//            ],
        );
//        });
  }
}
