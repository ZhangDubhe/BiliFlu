import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/pages/goods/good_list.dart';
import 'package:bilibiliflu/pages/goods/good_view_model.dart';
import 'package:bilibiliflu/pages/play/music.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String title;

  HomePage({this.title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  List _assets = [
//    '2.png',
//    '5.png',
//    '7.png',
//    '8.png',
//    '9.png',
//    '10.png',
//    '11.png',
//    '12.png',
//  ];
  GoodViewModel _goodViewModel = GoodViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, 'bilibili'),
          ),
          IconButton(
            icon: Icon(Icons.live_tv, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, 'bilibili'),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
//          Padding(
//            padding: const EdgeInsets.symmetric(vertical: 12),
//            child: CarouselSlider(
//              items: _assets.map((png) {
//                return Builder(
//                  builder: (BuildContext context) {
//                    return Container(
//                        width: MediaQuery.of(context).size.width,
//                        margin: EdgeInsets.symmetric(horizontal: 5.0),
//                        decoration: BoxDecoration(
//                            color: Colors.grey
//                        ),
//                        child: Image.asset('assets/images/$png', fit: BoxFit.cover,)
//                    );
//                  },
//                );
//              }).toList(),
//            ),
//          ),
//          TestDemo(),
          SizedBox(height: 10,),
          _goodList(),
        ],
      ),
    );
  }

  Widget _goodList() {
    return FutureBuilder(
      future: _goodViewModel.fetch(),
      builder: (BuildContext context, AsyncSnapshot<List<Good>> snapshot) {
        if (snapshot.hasData) {
          return GoodListWidget(goodList: snapshot.data??[],);
        } else if (snapshot.hasError) {
          return Container();
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
