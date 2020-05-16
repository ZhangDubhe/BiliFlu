import 'package:bilibiliflu/global/themes.dart';
import 'package:bilibiliflu/pages/goods/good_page.dart';
import 'package:bilibiliflu/pages/home/home.dart';
import 'package:bilibiliflu/pages/play/play.dart';
import 'package:bilibiliflu/pages/user_center/orders.dart';
import 'package:bilibiliflu/pages/web/web.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '假的会员购',
      theme: GlobalTheme.buildTheme(),
      home: HomePage(title: 'bilibili会员购'),
      routes: RouterService.baseRoute,
      navigatorObservers: [routeObserver],
    );
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((duration){
      RouterService();
      RouterService.rootContext = context;
    });
  }


}
