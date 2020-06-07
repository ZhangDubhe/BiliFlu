import 'package:bilibiliflu/global/params.dart';
import 'package:bilibiliflu/global/themes.dart';
import 'package:bilibiliflu/models/good.dart';
import 'package:bilibiliflu/pages/play/music.dart';
import 'package:bilibiliflu/services/global_service_center.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  BehaviorSubject<int> audioIndexState = BehaviorSubject.seeded(0);
  BehaviorSubject<bool> isPaying = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSuccess = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isPlayAudio = BehaviorSubject.seeded(false);
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
              CarouselSlider(
                aspectRatio: 1,
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                items: (widget.goodItem?.previews??[]).map((png) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.only(bottom: 20, top: 20),
                        decoration: BoxDecoration(
                          boxShadow: GlobalTheme.commonShadow(offset: Offset(10, -5))
                        ),
                        child: Image.network('$png?x-oss-process=style/480h',
                          fit: BoxFit.contain
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              MusicPlayer(
                audioIndex: audioIndexState.value,
                forcePlayState: isPlayAudio,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text('${widget.goodItem?.name}', style: Theme.of(context).textTheme.subtitle1,),
                    Text('${widget.goodItem?.desc}', style: Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.pink)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: (widget.goodItem?.previews??[]).map((c) => Image.network('$c?x-oss-process=style/480h', fit: BoxFit.cover,)).toList(),
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
                Expanded(
                  child: RaisedButton(
                    onPressed: () => buyGoodItem(),
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Center(child: SafeArea(child: StreamBuilder<Object>(
                        stream: isPaying,
                        initialData: false,
                        builder: (context, snapshot) {
                          if (snapshot.data) {
                            return Text('购买中');
                          }
                          return Text('立即下单！', style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),);
                        }
                      )))),
                ),
              ],
            ),
          ),),
          StreamBuilder<Object>(
            stream: isPaying,
            initialData: false,
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
          ),
          StreamBuilder<Object>(
              stream: isSuccess,
              initialData: false,
              builder: (context, snapshot) {
                if(snapshot.data) {
                  return Center(
                    child: Container(
                        padding: EdgeInsets.all(40),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: GlobalTheme.commonRadius()
                        ),
                        child: Text('购买成功！', style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),)),
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
  
  
  bindChange() {
    audioIndexState.add(3);
    isPlayAudio.add(true);
  }
  buyGoodItem() {
    isPaying.add(true);
    playPaying();
    Future.delayed(Duration(seconds: 2)).then((c) {
      isPaying.add(false);
      isSuccess.add(true);
      playSuccess();
      isPlayAudio.add(true);
      Future.delayed(Duration(milliseconds: 1000)).then((c) {
        isSuccess.add(false);
        RouterService.resolve('buyedGood', {
          'good': widget.goodItem
        }, context);
      });
    });
  }

  playPreview() {
//    GlobalServiceCenter.http.get(GlobalConfig.actionUrl, query: GlobalConfig.actionList['preview']).then((value) {
//      print(value);
//    });
  }
  playPaying() {
//    GlobalServiceCenter.http.get(GlobalConfig.actionUrl, query: GlobalConfig.actionList['buying']).then((value) {
//      print(value);
//    });
  }
  playSuccess() {
//    GlobalServiceCenter.http.get(GlobalConfig.actionUrl, query: GlobalConfig.actionList['hello']).then((value) {
//      print(value);
//    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playPreview();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    isSuccess.add(false);
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