import 'package:bilibiliflu/pages/goods/good_page.dart';
import 'package:bilibiliflu/pages/home/home.dart';
import 'package:bilibiliflu/pages/play/play.dart';
import 'package:bilibiliflu/pages/user_center/buy_good_item.dart';
import 'package:bilibiliflu/pages/user_center/orders.dart';
import 'package:bilibiliflu/pages/web/web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef Widget RouteBuilder(String code, Map<dynamic, dynamic> para, String path);

class RouterService{
  static BuildContext rootContext;
  static Router _route = Router();
  static String currentRoute = 'home';

  RouterService() {
    setup();
  }

  static Map<String, WidgetBuilder> baseRoute = {
    'home': (BuildContext context) => HomePage(title: 'bilibili会员购',),
    'play': (BuildContext context) => PlayPage(),
    'bilibili': (BuildContext context) => WebPage(),
    'goodList': (BuildContext context) => WebPage(),
    'myOrder': (BuildContext context) => OrderPage()
  };

  setup() {
    Map<String, RouteBuilder> _mapping = {
      'home': (code, para, _) => HomePage(title: para['title'],),
      'play': (code, para, _) => PlayPage(),
      'goodPage': (code, para, _) => GoodPage(goodItem: para['good'],),
      'myOrder': (code, para, _) => OrderPage(),
      'buyedGood': (code, para, _) => BuyGoodItem(goodItem: para['good'],),
    };
    _route.register(_mapping);
  }

  static void resolve(String name, Map<dynamic, dynamic> para, BuildContext context) {
    _route.resolve(name, para, context);
  }

  static void pop(BuildContext context, {Map para}) {
    _route.pop(para, context);
  }
}

class Router {
  Map<String, RouteBuilder> routeMapping = {};

  void register(Map<String, RouteBuilder> builders) {
    routeMapping = builders;
  }

  Map _formatPara(Map para){
    Map temp = {};
    for(var key in para?.keys ?? []) {
      if(para[key] == 'true') {
        temp[key] = true;
      } else if(para[key] == 'false') {
        temp[key] = false;
      } else {
        temp[key] = para[key];
      }
    }
    return temp;
  }

  Future resolve(String code, Map<dynamic, dynamic> para, BuildContext context) {
    RouteBuilder _builder = routeMapping[code];


    if (_builder != null) {
      Map params = _formatPara(para);
      MaterialPageRoute route = MaterialPageRoute(
        builder: (context) {
          return _builder(code, params, '');
        },
      );
      return Navigator.push(
        context,
        route,
      );
    }
  }

  void pop(Map para, BuildContext context) {
    if(Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}