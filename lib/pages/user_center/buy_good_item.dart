import 'dart:math';

import 'package:bilibiliflu/global/params.dart';
import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/pages/play/control.dart';
import 'package:bilibiliflu/pages/play/music.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
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
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('${widget.goodItem.name}'),
//                SizedBox(height: 30,),
//                (widget.goodItem.suits??[]).length > 0 ? Text('换装', style: Theme.of(context).textTheme.subtitle2,) : Container(),
                SizedBox(height: 20,),
                _switchDecoration()
              ],
            ),
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
    audioState.add(9); // 10
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
      case '唱首歌':
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
      case '深海少女':
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

  Widget _switchDecoration() {
    int index = 0;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: (widget.goodItem.suits??[]).map((e) {
        index++;
        return GestureDetector(
          onTap: () => selectIndex(index),
          child: Column(
            children: <Widget>[
              ClipOval(
                child: Container(
                  color: Colors.pinkAccent,
                  padding: EdgeInsets.all(4),
                  child: ClipOval(
                    child: Image.network('${e.pic}?x-oss-process=style/480h',
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Text('${e.name}')
            ],
          ),
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