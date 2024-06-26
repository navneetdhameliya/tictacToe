import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/screens/common_logo.dart';
import 'package:tictactoe/screens/welcome/welcome_screen.dart';
import 'package:tictactoe/widgets/bgImage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

    @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    showAnimation();
  }

  void showAnimation() {
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
      }
    });
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image(image: images(player0Path),),
          Image(image: images(player1Path),),
          Image(image: images(bgImagePath),),
          Image(image: images(settingButtonPath),),
          Image(image: images(homeIconPath),),
          Image(image: images(pickSideButtonPath),),
          Image(image: images(newButtonPath),),
          Image(image: images(startButtonPath),),
          Image(image: images(selectedCharBGPath),),
          Image(image: images(pauseButtonPath),),
          Image(image: images(clockPath),),
          Image(image: images(drawIconPath),),
          Image(image: images(scoreBgButtonPath),),
          Image(image: images(player1BgPath),),
          Image(image: images(player2BgPath),),
          Image(image: images(boardBgPath),),
          Image(image: images(otherButtonBgPath),),
          Image(image: images(playerWinNotificationPath),),
          Image(image: images(pauseIconPath),),
          Image(image: images(soundOffPath),),
          Image(image: images(soundOnPath),),
          Image(image: images(textFieldBg),),
          Image(image: images(minusIconPah),),
          Image(image: images(plusIconPath),),
          Image(image: images(starIconPath),),
          const BgImage(),
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
            image: const AssetImage("assets/images/splash_icon.png"),
            height: MediaQuery.of(context).size.height * 0.46,
            width: MediaQuery.of(context).size.width * 0.64,
          ),
               // CommonLogo(context,false),
                ],
              )),
        ],
      ),
    );
  }
}
