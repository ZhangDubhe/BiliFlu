import 'package:bilibiliflu/global/themes.dart';
import 'package:bilibiliflu/pages/home/home.dart';
import 'package:bilibiliflu/pages/play/play.dart';
import 'package:bilibiliflu/pages/user_center/orders.dart';
import 'package:bilibiliflu/pages/web/web.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '假的会员购',
      theme: GlobalTheme.buildTheme(),
      home: HomePage(title: 'Bilibili'),
      routes: {
        'home': (BuildContext context) => HomePage(title: 'Bilibili',),
        'play': (BuildContext context) => PlayPage(),
        'bilibili': (BuildContext context) => WebPage(),
        'myOrder': (BuildContext context) => OrderPage()
      },
    );
  }
}
