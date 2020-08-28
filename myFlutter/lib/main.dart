import 'package:flutter/material.dart';
import 'package:myFlutter/navigator/tab_navigator.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}
