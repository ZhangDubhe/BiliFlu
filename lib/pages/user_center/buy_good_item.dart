import 'dart:math';

import 'package:bilibiliflu/global/params.dart';
import 'package:bilibiliflu/global/themes.dart';
import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/pages/play/control.dart';
import 'package:bilibiliflu/pages/play/music.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BuyGoodItem extends StatefulWidget {
  Good goodItem;

  BuyGoodItem({
    this.goodItem
  });

  @override
  BuyGoodItemState createState() => new BuyGoodItemState();
}

class BuyGoodItemState extends State<BuyGoodItem> {
  BehaviorSubject<int> _selectedIndex = BehaviorSubject.seeded(0);
  BehaviorSubject<int> audioState = BehaviorSubject.seeded(4);
  BehaviorSubject<bool> isPlayAudio = BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('${widget.goodItem.name}'),
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () => annoy(),
            child: Container(
              child: Image.network(widget.goodItem?.pic,
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
          ),
          // 换装
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//                SizedBox(height: 30,),
//                (widget.goodItem.suits??[]).length > 0 ? Text('换装', style: Theme.of(context).textTheme.subtitle2,) : Container(),
              SizedBox(height: 10,),
              _switchDecoration()
            ],
          ),
          ModeruControl(
            actionHandler: bindAction,
          ),
          StreamBuilder<int>(
            stream: audioState,
            builder: (context, snapshot) {
              return MusicPlayer(
                forcePlayState: isPlayAudio,
                audioIndex: audioState.value,
              );
            }
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  void annoy() {
    Random _ran = Random();
    int _index = _ran.nextInt(Voice.touch.length);
    audioState.add(Voice.touch[_index]);
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isPlayAudio.add(true);
    });
  }

  void selectIndex(int index) {
    if (index == 0 )return;
    audioState.add(8 + index); // 10
    _selectedIndex.add(index - 1);
    Future.delayed(Duration(seconds: 1)).then((value) {
      isPlayAudio.add(true);
    });
//    GlobalServiceCenter.http.get('http://10.23.99.14:8080/test', query: {
//      'action': 1
//    });
  }

  bindAction(String actionName) {
    print(actionName);
    bool _ux = false;
    switch (actionName) {
      case '歌':
        singSong();
        break;
      case '想什么':
        think();
        break;
      case 'UX':
        _ux = true;
        break;
      case '更新':
        _ux = true;
        break;
      case 'UP':
        _ux = true;
        break;
      case '深海':
        singSea();
        break;
      default:
        break;
    }
    if (_ux) {
      ux();
    }
  }

  void singSong() {
    audioState.add(11);
    Future.delayed(Duration(seconds: 1)).then((value) {
      isPlayAudio.add(true);
      Future.delayed(Duration(milliseconds: 6000)).then((value) {
        audioState.add(12);
        Future.delayed(Duration(milliseconds: 500)).then((value) {
          isPlayAudio.add(true);
        });
      });
    });
  }

  void think() {
    audioState.add(14);
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isPlayAudio.add(true);
    });
  }
  void singSea() {
    audioState.add(15);
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isPlayAudio.add(true);
    });
  }
  void ux() {
    audioState.add(16);
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      isPlayAudio.add(true);
    });
  }
  playShow() {
//    GlobalServiceCenter.http.get(GlobalConfig.actionUrl, query: GlobalConfig.actionList['show']).then((value) {
//      print(value);
//    });
  }

  Widget _switchDecoration() {
    int index = 0;
    return CarouselSlider(
      aspectRatio: 1.4,
      viewportFraction: 0.5,
      enlargeCenterPage: true,
      enableInfiniteScroll: false,
      onPageChanged: (c) => selectIndex(c),
      items: (widget.goodItem.suits??[]).map((e) {
        index++;
        if (e.pic.isEmpty) {
          return Container(
            child: Center(child: Text('换一个装扮吧')),
          );
        }
        return Builder(
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: GestureDetector(
                onTap: () => selectIndex(index),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: GlobalTheme.commonShadow(),
                        color: Colors.pinkAccent,
                      ),
                      padding: EdgeInsets.all(4),
                      child: Image.network('${e.pic}?x-oss-process=style/480h',
                        width: 140,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    ),
                    Text('${e.name}')
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
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
    Future.delayed(Duration(seconds: 1)).then((c) {
      playShow();
    });
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