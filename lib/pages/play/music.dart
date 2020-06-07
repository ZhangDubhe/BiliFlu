//import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MusicPlayer extends StatefulWidget {
  bool showMusic;
  int audioIndex;
  BehaviorSubject forcePlayState;
  MusicPlayer({
    this.showMusic = false,
    this.audioIndex = -1,
    this.forcePlayState
  });

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  String onlyMyRuilgun = 'onlymyrailgun.mp3';
  List<String> audioList = [
  '01-你就是我的master吗.wav',
  '02-欢迎回来，主人.wav',
  '02-欢迎回来，主人.wav',//03
  '04-终于等到你啦.wav',
  '05-自我介绍.wav',
  '06-摸头会长不高的.wav',
  '07-哎呀，别闹啦.wav',
  '08-又被你猜中我的心思啦.wav',
  '09-最近有什么新鲜事.wav',
  '10-太好看啦，谢谢你送我这个.wav',
  '11-Bling.wav',
  '12-最近新学了一首歌，来唱给你听.wav',
  '13-《勾指起誓》.wav',
  '13-刚刚在想事情不好意思.wav',//14
  '14-一个人有点无聊，你可以给我推荐一部番剧吗.wav',//15
  '14-深海少女.wav',//16
  '15-他最近有新的投稿，要不要来一起看.wav',//17
  '16-那让我们一起来看吧.wav',//18
  ];
  static AudioPlayer player = AudioPlayer();
  AudioCache audioCache = AudioCache(
    fixedPlayer: player,
    prefix: 'audios/'
  );
  BehaviorSubject<bool> isPlaying = BehaviorSubject.seeded(false);

  play() {
    isPlaying.add(true);
    if (player.state == AudioPlayerState.PAUSED) {
      player.resume();
    } else {
      if (widget.audioIndex < 0) {
        audioCache.play(onlyMyRuilgun, volume: 0.05);
      } else {
        audioCache.play(audioList[widget.audioIndex]);
      }
    }
  }

  stop() {
    isPlaying.add(false);
    player.stop();
  }
  pause() {
    isPlaying.add(false);
    player.pause();
  }
  @override
  Widget build(BuildContext context) {
    if (!widget.showMusic) {
      return Container();
    }
    return Container(
      child: StreamBuilder<Object>(
        stream: isPlaying,
        initialData: false,
        builder: (context, snapshot) {
          bool _isPlaying = snapshot.data;
          return _isPlaying ? _pauseWidget() : _playWidget();
        }
      ),
    );
  }

  Widget _pauseWidget() {
    return GestureDetector(
      onTap: () => pause(),
      child: Column(
        children: <Widget>[
          Icon(Icons.pause_circle_filled, size: 60, color: Colors.amber),
          SizedBox(height: 4,),
          Text('暂停音乐'),
        ],
      ),
    );
  }

  Widget _playWidget() {
    return GestureDetector(
      onTap: () => play(),
      child: Column(
        children: <Widget>[
          Icon(Icons.play_circle_filled, size: 60, color: Colors.amber,),
          SizedBox(height: 4,),
          Text('播放音乐'),
        ],
      ),
    );
  }

  initAudio() async {
//    audioCache.loadAll(audioList);
//    await player.open(
//      Audio("assets/audios/song1.mp3"),
//      autoStart: false,
//      showNotification: true,
//    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAudio();
    player.onPlayerStateChanged.listen((AudioPlayerState state) {
      if (state == AudioPlayerState.PLAYING) {
        isPlaying.add(true);
      } else {
        isPlaying.add(false);
      }
    });
    if (widget.forcePlayState != null && !widget.forcePlayState.hasListener) {
      widget.forcePlayState.listen((value) {
        if (value) {
          play();
        }
      });
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    player.release();
    super.dispose();
  }
}
