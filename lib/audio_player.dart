
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
class AudioFile extends StatefulWidget
{
 final AudioPlayer advancedPlayer;
 final String audioPath;
  const AudioFile({Key? key,required this.advancedPlayer,required this.audioPath}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();


  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  List<IconData> _icons=[
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void InitState(){
    super.initState();
    this.widget.advancedPlayer.onDurationChanged.listen((d) {setState(() {
      _duration = d;
    }); });
    this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {setState(() {
      _position = p;
    }); });
    this.widget.advancedPlayer.setUrl(this.widget.audioPath);
    this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
      setState(() {
       _position = Duration(seconds: 0);
       if(isRepeat==true){
          isPlaying = true;
       }else {
         isPlaying = false;
         isRepeat = false;
       }
      });
    });
  }

  Widget btnStart(){
    return IconButton(
      padding:const EdgeInsets.only(bottom: 10),
      icon: isPlaying==false?Icon(_icons[0],size: 50,color: Colors.blue,):Icon(_icons[1],size: 50,color: Colors.blue,),
      onPressed: () {
        if (isPlaying == false) {
          this.widget.advancedPlayer.play(this.widget.audioPath);
          setState(() {
            isPlaying=true;
          });
        }
     else if(isPlaying==true){
       this.widget.advancedPlayer.pause();
       setState(() {
         isPlaying=false;
       });
        }
      },
      );
  }

  Widget loadAsset(){
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnRepeat(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnLoop(),
        ],
      ),
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.blue,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });});
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }

Widget btnFast(){
    return IconButton(
      icon: ImageIcon(
        AssetImage('img/forward.png'),
        size: 15,
        color: Colors.black,
      ),
    onPressed:(){
      this.widget.advancedPlayer!.setPlaybackRate(1.5);
    },
    );
}
  Widget btnSlow() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('img/backword.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancedPlayer!.setPlaybackRate(0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon:   ImageIcon(
        AssetImage('img/loop.png'),
        size: 15,
        color: Colors.black,
      ), onPressed: () {  },
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon:   ImageIcon(
        AssetImage('img/repeat.png'),
        size: 15,
        color: color,
      ), onPressed: () {
      if(isRepeat==false){
        this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
        setState(() {
          isRepeat=true;
          color = Colors.blue;
        });
      }
      else if(isRepeat==true){
        this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
       setState(() {
         color=Colors.black;
         isRepeat = false;
       });

      }
    },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(left: 20,right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text(_position.toString().split(".")[0],style: TextStyle(fontSize:16),),
              Text(_duration.toString().split(".")[0],style: TextStyle(fontSize:16),)
            ],
          ),
          ),
          slider(),
          loadAsset(),

        ],
      ),
    );
  }
}
