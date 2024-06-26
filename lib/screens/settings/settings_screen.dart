import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show AlertDialog, BuildContext, Colors, Column, Container, Divider, EdgeInsets, MainAxisAlignment, MediaQuery, Row, Scaffold, SizedBox, StatelessWidget, Text, TextStyle, Widget, showDialog;
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/settings.dart';
import 'package:tictactoe/models/shared_pref.dart';
import 'package:tictactoe/screens/settings/components/player_settings.dart';
import 'package:tictactoe/screens/settings/components/score_settings.dart';
import 'package:tictactoe/screens/settings/components/volume_settings.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Column(

        children: [
          SizedBox(height: screenHeight*0.01,),
          ShaderMask( shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFFFFFF),Color(0xffB7DFF8)],
          ).createShader(bounds),child: Text("Setting",style: TextStyle(fontSize: screenWidth*0.07,fontFamily: 'Paytone'),)),
          VolumeSettings(),
          SizedBox(height: screenHeight*0.01),
          const PlayerSettings(playerIndex: 0),
          SizedBox(height: screenHeight*0.008),
          const PlayerSettings(playerIndex: 1),
          SizedBox(height: screenHeight*0.008),
          const ScoreSettings(0),
          const ScoreSettings(1),
          SizedBox(height: screenHeight * 0.03,),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: MediaQuery.of(context).size.height *0.053,
              width: MediaQuery.of(context).size.width *0.39,
              decoration: BoxDecoration(
                image: DecorationImage(image: images(otherButtonBgPath))
              ),
              child: const Center(child: Text('Done',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)),
            ),
          )
        ],
      ),
    );
  }

}
