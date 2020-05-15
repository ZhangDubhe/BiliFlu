import 'package:bilibiliflu/models/good.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodPage extends StatefulWidget {
  Good goodItem;

  GoodPage({
    this.goodItem
  });

  @override
  GoodPageState createState() => new GoodPageState();
}

class GoodPageState extends State<GoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Image.network(widget.goodItem?.pic, fit: BoxFit.cover,),
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text('${widget.goodItem?.name}', style: Theme.of(context).textTheme.subtitle1,),
                    Text('${widget.goodItem?.name}', style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.pink)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: (widget.goodItem?.previews??[]).map((c) => Image.network(c, fit: BoxFit.cover,)).toList(),
                )
              ),
            ],
          ),
          Positioned(bottom: 0,left: 0,right: 0,
          child: Container(
            height: 55,
            child: Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('购买'),
                )
              ],
            ),
          ),)
        ],
      ),
    );
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
  void didUpdateWidget(GoodPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}