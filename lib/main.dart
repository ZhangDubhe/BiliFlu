import 'package:bilibiliflu/global/themes.dart';
import 'package:bilibiliflu/pages/goods/good_page.dart';
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
      home: HomePage(title: 'bilibili会员购'),
      routes: {
        'home': (BuildContext context) => HomePage(title: 'bilibili会员购',),
        'play': (BuildContext context) => PlayPage(),
        'bilibili': (BuildContext context) => WebPage(),
        'goodList': (BuildContext context) => WebPage(),
        'goodPage': (BuildContext context) => GoodPage(),
        'myOrder': (BuildContext context) => OrderPage()
      },
    );
  }
}
