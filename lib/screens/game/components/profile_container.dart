import 'package:delayed_display/delayed_display.dart';
import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/responsive_ui.dart';
import 'package:tictactoe/screens/game/components/score_container.dart';

class MyProfileContainer extends StatelessWidget {
  final FirebaseImageProvider symbol;
  final String playerBGPath;
  final int playerIndex;

  const MyProfileContainer({required this.playerIndex, required this.symbol, required this.playerBGPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.008,),
        Container(
          height: ResponsiveUI.getHeight(0.16),
          width: MediaQuery.of(context).size.width * 0.28,
          decoration: BoxDecoration(image: DecorationImage(image: images(playerBGPath))),
          child: Center(child: Image(image: symbol,width: MediaQuery.of(context).size.width *0.25,)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height *0.01,),

        MyScoreContainer('${Player.playerScores[playerIndex]}'),
      ],
    );
  }
}
