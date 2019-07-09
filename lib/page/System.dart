import 'package:flutter/material.dart';

class System extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SystemState();
  }
  
}

class SystemState extends State<System> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title:Text('体系'),
        
      ),
      body: Text('这里是体系'),
    );
  }
  
}