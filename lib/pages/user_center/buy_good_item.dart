import 'package:bilibiliflu/models/good.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyGoodItem extends StatefulWidget {
  Good goodItem;

  BuyGoodItem({
    this.goodItem
  });

  @override
  BuyGoodItemState createState() => new BuyGoodItemState();
}

class BuyGoodItemState extends State<BuyGoodItem> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('${widget.goodItem.name}'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: Colors.black12,
            child: Image.network(widget.goodItem?.pic,
              fit: BoxFit.contain,
              height: 400,
            ),
          ),
          // 换装
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('${widget.goodItem.name}'),
                SizedBox(height: 20,),
                _switchDecoration()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchDecoration() {
    return Container();
  }

  void _bindChangeDecoration() {
    setState(() {

    });
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
  void didUpdateWidget(BuyGoodItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}