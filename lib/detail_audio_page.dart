import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart' as AppColors;
import 'audio_player.dart';

import 'package:monkey_player/audio_player.dart';
class DetailAudioPage extends StatefulWidget {
  final BooksData;
  final int index;
  const DetailAudioPage({Key? key,required this.BooksData,required this.index}) : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  late AudioPlayer advancedPlayer;

@override
void initState(){
  super.initState();
  advancedPlayer = AudioPlayer();
}


  @override
  Widget build(BuildContext context) {
    final double ScreenHeight =  MediaQuery.of(context).size.height;
    final double ScreenWidth =  MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
            top: 0,left: 0,right: 0,
              height: ScreenHeight/3,
              child: Container(
             color: AppColors.audioBlueBackground

              )),
          Positioned(
              top: 0,left: 0,right: 0,

              child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
              onPressed: (){},
              ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: (){
                      advancedPlayer.stop();
                      Navigator.of(context).pop();
                      },
                  ),

                ],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
          )),
          Positioned(
              left: 0, right: 0, top: ScreenHeight*0.2, height: ScreenHeight*0.36,
              child: Container(

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
                child: Column(
                  children: [
                    SizedBox(height: ScreenHeight*0.1,),
                    Text(this.widget.BooksData[this.widget.index]["title "], style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Averic"
                    ),),
                    Text(this.widget.BooksData[this.widget.index]["text"],style: TextStyle(
                      fontSize: 20
                    ),),
                    AudioFile(advancedPlayer: advancedPlayer,audioPath: this.widget.BooksData[this.widget.index]["audio"],),
                  ],
                ),
              )),
          Positioned(
              top: ScreenHeight*0.12,
              left: (ScreenWidth-150)/2,
              right: (ScreenWidth-150)/2,
              height: ScreenHeight*0.16,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white,width: 2),
                  color: AppColors.audioGreyBackground
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                   // borderRadius: BorderRadius.circular(20),
                    shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 5),
                image: DecorationImage(
                  image: AssetImage(this.widget.BooksData[this.widget.index]["img"]),
                  fit: BoxFit.cover,
                )
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
