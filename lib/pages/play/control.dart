import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:xfvoice/xfvoice.dart';
import 'package:flutter/material.dart';
import 'package:audio_recorder/audio_recorder.dart';

class ModeruControl extends StatefulWidget {
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
          StreamBuilder<bool>(
            stream: isListening,
            initialData: false,
            builder: (context, snapshot) {
              if (snapshot.data) {
                return RaisedButton(
                  onPressed: () => stopListen(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.font_download),
                      Text('END')
                    ],
                  ),
                );
              }
              return RaisedButton(
                onPressed: () => startListen(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.voice_chat),
                    Text('TTS')
                  ],
                ),
              );
            }
          )
        ],
      ),
    );
  }

  String voiceMsg = '暂无数据';
  String iflyResultString = '按下方块说话';

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
    //.contacts.shouldShowRequestRationale;
  }
  Future<void> initPlatformState() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    voice.init(appIdIos: '5edb073a', appIdAndroid: '5edb073a');
    final param = new XFVoiceParam();
    param.domain = 'iat';
    // param.asr_ptt = '0';   //取消注释可去掉标点符号
    param.asr_audio_path = 'bili/audio.pcm';
    param.result_type = 'json'; //可以设置plain
    final map = param.toMap();
    map['dwa'] = 'wpgs';        //设置动态修正，开启动态修正要使用json类型的返回格式
    voice.setParameter(map);
  }

  Widget _voiceRecognize() {
    return  Center(
      child: GestureDetector(
        child: Container(
          child: Center(child: Text(iflyResultString)),
          width: 300.0,
          height: 44.0,
          color: Colors.blueAccent,
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
    voice.start(listener: listener).then((void _void) {
      isListening.add(true);
    }).catchError((e) => print(e));
  }

  void stopListen() {
    voice.stop();
    isListening.add(false);
  }

  initRecord() async {
    // Check permissions before starting
    // Get the state of the recorder
    bool isRecording = await AudioRecorder.isRecording;
    if (isRecording) {
      await AudioRecorder.stop();
    }
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
