import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/pages/goods/good_item.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodListWidget extends StatefulWidget {
  List<Good> goodList = [];

  GoodListWidget({
    this.goodList
  });

  @override
  GoodListWidgetState createState() => new GoodListWidgetState();
}

class GoodListWidgetState extends State<GoodListWidget> {
  bool isInGridMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(child: Container(),),
            Icon(isInGridMode ? Icons.view_module : Icons.view_list),
            Switch(
              value: isInGridMode,
              onChanged: (change) {
                print('InGridMode: $change');
                print('InGridMode: $isInGridMode');
                isInGridMode = change;
                setState(() {
                });
              },
            ),
          ],
        ),
        isInGridMode ? _gridMode() : _listMode()
      ],
    );
  }

  Widget _listMode() {
    return Column(
      children: widget.goodList.map((c) => GoodItem(
      good: c,
      bindTap: _gotoDetail,)).toList(),
    );
  }

  Widget _gridMode() {
    return Wrap(
      runSpacing: 15,
      spacing: 10,
      children: widget.goodList.map((c) {
        return Container(
          width: (MediaQuery.of(context).size.width / 2) - 10,
          child: GoodItem(good: c, bindTap: _gotoDetail, gridMode: true),
        );
      }).toList(),
    );
  }

  void _gotoDetail(Good good) {
    RouterService.resolve('goodPage', {
      'good': good
    }, context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(GoodListWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}