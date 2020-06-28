import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xfvoice/xfvoice.dart';
import 'package:flutter/material.dart';

import 'package:bilibiliflu/global/params.dart';

class ModeruControl extends StatefulWidget {
  Function(String) actionHandler;

  ModeruControl({
    this.actionHandler
  });

  @override
  _ModeruControlState createState() => _ModeruControlState();
}

class _ModeruControlState extends State<ModeruControl> {
  final voice = XFVoice.shared;
  BehaviorSubject<bool> isListening = BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _voiceRecognize(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }

  String voiceMsg = '暂无数据';
  String iflyResultString = '按下方跟我聊天';

  XFJsonResult xfResult;

  initPermission() async {
   bool hasPermission = await Permission.speech.isGranted;
   if (hasPermission) {
   } else {
     Map<Permission, PermissionStatus> statuses = await [
       Permission.speech,
       Permission.storage,
     ].request();
     statuses.forEach((key, value) {
       print(value);
     });
   }
  }

  Future<void> initPlatformState() async {
    voice.init(appIdIos: GlobalConfig.xfKey, appIdAndroid: GlobalConfig.xfAndroidKey);
    final param = new XFVoiceParam();
    param.domain = 'iat';
    // param.asr_ptt = '0';   //取消注释可去掉标点符号
    param.asr_audio_path = 'bili/audio.pcm';
    param.result_type = 'json'; //可以设置plain
    final map = param.toMap();
    map['dwa'] = 'wpgs'; //设置动态修正，开启动态修正要使用json类型的返回格式
    voice.setParameter(map);
  }

  Widget _voiceRecognize() {
    return  Center(
      child: RaisedButton(
        onPressed: () => print('??'),
        child: GestureDetector(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Center(child: Text(iflyResultString,
                softWrap: true,
                style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),)),
              width: 300.0,
            ),
          ),
          onTapDown: (d) {
            setState(() {
              voiceMsg = '按下';
            });
            _recongize();
          },
          onTapUp: (d) {
             _recognizeOver();
          },
        ),
      ),
    );
  }

  AudioPlayer audioPlayer = AudioPlayer();
  
  void _recongize() async {
    final listen = XFVoiceListener(
        onVolumeChanged: (volume) {
        },
        onBeginOfSpeech: () {
          xfResult = null;
        },
        onResults: (String result, isLast) {
          if (xfResult == null) {
            xfResult = XFJsonResult(result);
          } else {
            final another = XFJsonResult(result);
            xfResult.mix(another);
          }
          if (result.length > 0) {
            setState(() {
              iflyResultString = xfResult.resultText();
            });
            detectVoice(iflyResultString);
          }
        },
        onCompleted: (Map<dynamic, dynamic> errInfo, String filePath) {
          setState(() {

          });
        }
    );
    await initRecord();
    XFVoice.shared.start(listener: listen);
  }

  void _recognizeOver() {
    XFVoice.shared.stop();
  }

  void toText(String text) {
    print('Final!');
    print(text);
  }

  void startListen() async {
    final listener = XFVoiceListener(
        onVolumeChanged: (volume) {
          print('$volume');
          print('Volume change!');
        },
        onResults: (String result, isLast) {
          String _res = result.toString();
          toText(_res);
        },
        onBeginOfSpeech: () {
          print('start speech');
        },
        onCompleted: (Map<dynamic, dynamic> errInfo, String filePath) {
          print(errInfo);
          print(filePath);
          print('onCompleted');
        }
    );
    await initRecord();
    setState(() {
      iflyResultString = '...';
    });
    voice.start(listener: listener).then((void _void) {
      isListening.add(true);
    }).catchError((e) => print(e));
  }

  void stopListen() {
    voice.stop();
    isListening.add(false);
  }

  detectVoice(String input) {
    Voice.voiceDirect.forEach((String element) {
      print(element);
      if (input.contains(element)) {
        print('successs!!!!');
        widget.actionHandler(element);
      }
    });
  }

  initRecord() async {
    // Check permissions before starting
    // Get the state of the recorder
    await initPermission();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    voice.clearListener();
    super.dispose();
  }
}
