import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/pages/goods/good_item.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Good> _goodList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: ListView(
        children: _goodList.map((c) => GoodItem(
          good: c,
          bindTap: gotoBuyItem,
        )).toList(),
      ),
    );
  }

  void gotoBuyItem(Good c) {
    RouterService.resolve('buyedGood', {
      'good': c
    }, context);
  }
}
