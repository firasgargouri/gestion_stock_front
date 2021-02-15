import 'package:flutter/material.dart';
import 'package:gestionstock/screens/auth/login.dart';
import 'package:gestionstock/screens/home/home.dart';
import 'package:gestionstock/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gestion_stock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Wrapper(),
      routes: <String, WidgetBuilder>{
        '/wrapper': (BuildContext context) => Wrapper(),
        '/login': (BuildContext context) => Login(),
        '/home': (BuildContext context) => Home(),
      },
    );
  }
}
