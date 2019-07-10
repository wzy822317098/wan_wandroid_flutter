import 'package:flutter/material.dart';
import 'page/main_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'wan_android',
      theme: new ThemeData(primaryColor: Colors.white),
      home: new MainPage(),
    );
  }
}


