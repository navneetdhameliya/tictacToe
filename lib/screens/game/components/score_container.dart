import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';

class MyScoreContainer extends StatelessWidget {
  final String text;
  const MyScoreContainer(this.text);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight > 1000 ?screenHeight * 0.06:screenHeight * 0.05,
      width: screenWidth > 500 ? screenWidth * 0.08 : screenWidth * 0.1,
      decoration: BoxDecoration(image: DecorationImage(image: images(scoreBgButtonPath),fit: BoxFit.fill,),
    ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: kTextStyle.copyWith(
            fontSize: screenWidth *0.04,
          ),
        ),
      ),
    );
  }
}
