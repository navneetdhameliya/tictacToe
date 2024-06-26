import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/settings.dart';
import 'package:tictactoe/models/shared_pref.dart';
import 'package:tictactoe/utilities/audio_player.dart';

import '../../../models/player.dart';

class VolumeSettings extends StatefulWidget {
  @override
  _VolumeSettingsState createState() => _VolumeSettingsState();
}


class _VolumeSettingsState extends State<VolumeSettings> {

  @override
  void initState() {
    super.initState();
    SharedPref().getSoundValue;
    SharedPref().getMusicValue;
    musicValues!;
    value!;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Sound', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        _buildSwitchButtons(0,),
        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
        Text('Music', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
        SizedBox(width: MediaQuery.of(context).size.width * 0.01),
        _buildSwitchButtons(1,),
      ],
    );
  }

  _buildSwitchButtons(int index) {
    return GestureDetector(
      onTap: () async{
        setState(() {
          if(index == 0){
            if(value!){
              value = false;
              SharedPref().setSoundValue(value!);
            }else{
              value = true;
              SharedPref().setSoundValue(value!);
            }
        }else{
            if(musicValues!){
              musicValues = false;
              SharedPref().setMusicValue(musicValues!);
            }else{
              musicValues = true;
              SharedPref().setMusicValue(musicValues!);
            }
          }


          if (index == 1) _musicHandler();
        });
        Settings.audioValues[0] =  await SharedPref().getSoundValue();

        Settings.audioValues[1] =  await SharedPref().getMusicValue();

      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.051,
        width:  MediaQuery.of(context).size.width * 0.1,
        decoration: BoxDecoration(
          image: DecorationImage(image: images(index == 0 ?( value! ? soundOnPath:soundOffPath) :musicValues! ? soundOffPath : soundOnPath))
        ),
      ),
    );
  }

  void _musicHandler() {
    if (Settings.audioValues[1]) {
      AudioPlayer.playMusic();
    } else if (!Settings.audioValues[1]) {
      AudioPlayer.toggleLoop();
      AudioPlayer.stopMusic();
    }
  }
}
