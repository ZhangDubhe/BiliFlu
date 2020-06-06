import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/global/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GoodItem extends StatefulWidget {
  Good good;
  bool gridMode;
  Function bindTap;
  GoodItem({
    this.good,
    this.gridMode = false,
    this.bindTap
  });

  @override
  GoodItemState createState() => new GoodItemState();
}

class GoodItemState extends State<GoodItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.good == null) return Container();
    return Container(
      decoration: BoxDecoration(
        boxShadow: GlobalTheme.commonShadow(),
        color: Theme.of(context).backgroundColor,
        borderRadius: GlobalTheme.commonRadius(radius: 0),
      ),
      child: Ink(
        child: InkWell(
          onTap: widget.bindTap,
          child: Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text('${widget.good.name}', style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                      Text('￥${(widget.good.price ~/ 100)}', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.pinkAccent[100])),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
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