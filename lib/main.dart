import 'package:flutter/material.dart';
import 'page/main_page.dart';
import 'utils/colors_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'wan_android',

      theme: new ThemeData(
          primaryColor: Colors.white,
//          primarySwatch: Colors.blue,
          dividerColor: Colors.white,
          tabBarTheme: TabBarTheme(labelStyle: TextStyle(
            fontSize: 14,color: ColorsUtils.color_title
          )),
          disabledColor: Colors.white,
          accentColor: ColorsUtils.color_title,
          textTheme: TextTheme(
            title: TextStyle(
              fontSize: 16,
              color: ColorsUtils.color_title
            )
          ),
          cursorColor:ColorsUtils.color_content,
          bottomAppBarColor: Colors.white,

          dialogTheme: DialogTheme(
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(fontSize: 16,color: ColorsUtils.color_title),
              contentTextStyle:
                  TextStyle(color: ColorsUtils.color_content, fontSize: 14))),
      home: new MainPage(),
    );
  }
}
