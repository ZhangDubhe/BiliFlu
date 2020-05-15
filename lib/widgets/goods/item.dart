import 'package:flutter/material.dart';

class GoodItem extends StatelessWidget {
  String pic;
  String name;
  String price;
  String videoUrl;

  GoodItem({
    this.pic, this.name, this.price, this.videoUrl
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.network(pic),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: <Widget>[
                Text(name, style: Theme.of(context).textTheme.headline3,),
                Text('$price円', style: Theme.of(context).textTheme.bodyText1,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
