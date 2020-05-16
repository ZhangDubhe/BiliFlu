import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodItem extends StatefulWidget {
  Good good;
  bool gridMode;

  GoodItem({
    this.good,
    this.gridMode = false
  });

  @override
  GoodItemState createState() => new GoodItemState();
}

class GoodItemState extends State<GoodItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.good == null) return Container();
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 15),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network('${widget.good.pic}?x-oss-process=style/480h',
            fit: BoxFit.cover,
            height: widget.gridMode ? 200 : 400,
            alignment: Alignment.topCenter,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20
            ),
            child: Row(
              children: <Widget>[
                Expanded(child: Text('${widget.good.name}', overflow: TextOverflow.ellipsis,)),
                RaisedButton(
                  child: Text('💰${(widget.good.price ~/ 100)}'),
                  padding: EdgeInsets.all(0),
                  onPressed: () => RouterService.resolve('goodPage', {
                    'good': widget.good
                  }, context),
                )
              ],
            ),
          )
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
  void didUpdateWidget(GoodItem oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}