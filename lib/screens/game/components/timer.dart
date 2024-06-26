import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';

class MyCountDownTimer extends StatelessWidget {
  final int seconds;
  final int maxSeconds;

  const MyCountDownTimer({required this.seconds, required this.maxSeconds});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width:  screenWidth > 500 ? screenWidth * 0.13:screenWidth* 0.13,
      height: screenHeight > 900 ? screenHeight * 0.12 : screenHeight * 0.08,
      child: Column(
        children: [
          Image(image: images(clockPath),width: screenWidth * 0.08,),
          Center(child: Text(seconds < 10 ? '00:0$seconds': '00:$seconds',style: TextStyle(fontSize: screenWidth *0.036),)),
        ],
      ),
    );
  }
}
