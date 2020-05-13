import 'package:bilibiliflu/widgets/nav_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _assets = [
    '2.png',
    '5.png',
    '7.png',
    '8.png',
    '9.png',
    '10.png',
    '11.png',
    '12.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, 'myOrder'),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CarouselSlider(
              items: _assets.map((png) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.grey
                        ),
                        child: Image.asset('assets/images/$png', fit: BoxFit.cover,)
                    );
                  },
                );
              }).toList(),
            ),
          ),
          NavItem(
            routeName: 'play',
            arguments: {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.calendar_today),
                  Text('日历')
                ],
              ),
            ),
          ),
          NavItem(
            routeName: 'bilibili',
            arguments: {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.tv),
                  Text('bilibili')
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Center(
            child: RaisedButton(
              child: Text('Login'),
              onPressed: () => print('login'),
            ),
          )
        ],
      ),
    );
  }
}
