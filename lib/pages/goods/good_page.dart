import 'package:bilibiliflu/global/themes.dart';
import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class GoodPage extends StatefulWidget {
  Good goodItem;

  GoodPage({
    this.goodItem
  });

  @override
  GoodPageState createState() => new GoodPageState();
}

class GoodPageState extends State<GoodPage> {
  BehaviorSubject<bool> isPaying = BehaviorSubject.seeded(false);
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
              Container(
                color: Colors.black12,
                child: Image.network(widget.goodItem?.pic,
                  fit: BoxFit.contain,
                  height: 400,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              boxShadow: GlobalTheme.commonShadow()
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 3 / 5,
                  child: Center(
                    child: SafeArea(child: Text('￥${(widget.goodItem.price ~/ 100)}')),
                  ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () => buyGoodItem(),
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Center(child: SafeArea(child: StreamBuilder<Object>(
                        stream: isPaying,
                        initialData: false,
                        builder: (context, snapshot) {
                          if (snapshot.data) {
                            return Text('购买中');
                          }
                          return Text('购买', style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),);
                        }
                      )))),
                ),
              ],
            ),
          ),),
          StreamBuilder<Object>(
            stream: isPaying,
            builder: (context, snapshot) {
              if(snapshot.data) {
                return Center(
                  child: Container(
                      padding: EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: GlobalTheme.commonRadius()
                      ),
                      child: CircularProgressIndicator()),
                );
              } else {
                return Container();
              }
            }
          )
        ],

      ),
    );
  }
  
  

  buyGoodItem() {
    isPaying.add(true);
    Future.delayed(Duration(seconds: 1)).then((c) {
      isPaying.add(false);
      RouterService.resolve('buyedGood', {
        'good': widget.goodItem
      }, context);
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