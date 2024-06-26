import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tictactoe/AdHelper/AdHelper.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/responsive_ui.dart';
import 'package:tictactoe/models/settings.dart';
import 'package:tictactoe/screens/common_logo.dart';
import 'package:tictactoe/screens/game/components/card_gesture_detector.dart';
import 'package:tictactoe/screens/game/components/profile_container.dart';
import 'package:tictactoe/screens/game/components/result_container.dart';
import 'package:tictactoe/screens/game/components/timer.dart';
import 'package:tictactoe/utilities/audio_player.dart';
import 'package:tictactoe/widgets/bgImage.dart';

Player player = Player();

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    Player.resetStaticData();
    Player.resetData1();
    player.getPlayerSides();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  static const maxSeconds = 15;
  int seconds = maxSeconds;
  int pauseSeconds = 0;
  late Timer? timer;

  void resetTimer() => setState(() => seconds = maxSeconds);

  void stopTimer() => setState(() => timer!.cancel());

  void pauseTimer() => setState(() => pauseSeconds = seconds);

  void resumeTimer() => setState(() => seconds = pauseSeconds);

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0 && seconds < 16) {
        setState(() => seconds--);
      } else if (seconds == 0) {
        Player.player1 = !Player.player1;
        player.player1BgChange();
        player.player2BgChange();
        resetTimer();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          const BgImage(),
          if (!Player.completed && (Player.winner || Player.draw))
            WillPopScope(
              onWillPop: onWillPop,
              child: DelayedDisplay(
                child: Center(
                  child: Container(
                    height: screenHeight * 0.46,
                    width: screenWidth * 0.76,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: images(playerWinNotificationPath),
                            fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: images(starIconPath),
                          height: screenHeight * 0.2,
                          width: screenWidth * 0.3,
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Text(
                          Player.getAlertTitle(),
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontFamily: 'Paytone',
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        GestureDetector(
                          onTap: () => nextRoundFunc(),
                          child: Container(
                              height: screenHeight * 0.05,
                              width: screenWidth * 0.5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: images(otherButtonBgPath),
                                      fit: BoxFit.fill)),
                              child: Center(
                                child: Text(
                                  "Next Round",
                                  style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      fontFamily: 'Paytone',
                                      color: Colors.white),
                                ),
                              )),
                        ),
                        // CommonLogo(context,true),

                      ],
                    ),
                  ),
                ),
              ),
            )
          else
            WillPopScope(
              onWillPop: onWillPop,
              child: DelayedDisplay(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.06,
                    ),
                    Visibility(
                        visible: !Player.completed && !Player.winner,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  resetTimer();
                                  Player.resetStaticData();
                                  Player.updatePlayer1();
                                },
                                child: SizedBox(
                                  height: screenHeight * 0.057,
                                  width: screenWidth * 0.27,
                                  child: Image(
                                    image: images(newButtonPath),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pauseTimer();
                                  stopTimer();
                                  pauseAlert(context);
                                },
                                child: SizedBox(
                                  height: screenHeight * 0.057,
                                  width: screenWidth * 0.27,
                                  child: Image(
                                    image: images(pauseButtonPath),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Visibility(
                      visible: !Player.winner,
                      child: Container(
                        height: screenHeight * 0.25,
                        width: double.maxFinite,
                        color: const Color(0xff5c8cc1).withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            MyProfileContainer(
                                playerIndex: 0,
                                symbol: Player.p1,
                                playerBGPath: player.player1BgChange()),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.11,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.02,
                                ),
                                Visibility(
                                  visible: !Player.completed,
                                  child: MyCountDownTimer(
                                      seconds: seconds, maxSeconds: maxSeconds),
                                ),
                                // SizedBox(height: ResponsiveUI.getHeight(0.05)),
                                Image(
                                  image: images(drawIconPath),
                                  width: screenWidth > 500
                                      ? screenWidth * 0.08
                                      : screenWidth * 0.12,
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  "${Player.drawScore}",
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.06),
                                )
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.14,
                            ),
                            MyProfileContainer(
                                playerIndex: 1,
                                symbol: Player.p2,
                                playerBGPath: player.player2BgChange()),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Player.completed
                        ? _buildResultContainer()
                        : Expanded(child: _buildGameContainer(context)),
                    // CommonLogo(context,false),

                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGameContainer(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        constraints: BoxConstraints.tightFor(
          width: screenWidth > 500 ? screenWidth * 0.7 : screenWidth * 0.85,
          height:
              screenHeight > 1000 ? screenHeight * 0.55 : screenHeight * 0.45,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            image: DecorationImage(
              image: images(boardBgPath),
              fit: BoxFit.fill,
            )),
        child: Wrap(children: _buildCardButtons()),
      ),
    );
  }

  pauseAlert(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return DelayedDisplay(
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              title: Container(
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width * 0.64,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: images(playerWinNotificationPath),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              colors: [
                                Color(0xff1240B0),
                                Colors.white,
                              ],
                            ).createShader(bounds),
                        child: const Text(
                          "Game Paused!",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Paytone',
                          ),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.08,
                        child: Image(
                          image: images(pauseIconPath),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        resumeTimer();
                        startTimer();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          image:
                              DecorationImage(image: images(otherButtonBgPath)),
                        ),
                        child: const Center(
                            child: Text(
                          "Resume",
                          style: TextStyle(
                            fontSize: 25.0,
                            fontFamily: 'Paytone',
                          ),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  MyResultContainer _buildResultContainer() {
    return MyResultContainer(
      player: player,
      onPressed: () {
        setState(() {
          resetTimer();
          startTimer();
          Player.resetStaticData();
          Player.resetData1();
          player.player1BgChange();
          player.player2BgChange();
        });
      },
    );
  }

  List<CardGestureDetector> _buildCardButtons() {
    List<CardGestureDetector> buttons = [];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        buttons.add(
          CardGestureDetector(
            onTapFunction: () => showPlayerSide(i, j),
            boxSide: Player.matrix[i][j],
            cardColor: Player.cardColors[i][j],
          ),
        );
      }
    }
    return buttons;
  }

  void showPlayerSide(int x, int y) {
    setState(() {
      if (Player.matrix[x][y] == imageName && !Player.finished) {
        player.updateMatrix(x, y);
        // if (Settings.audioValues[0]) AudioPlayer.playSound(Player.side);
        if (player.checkWinner(x, y)) {
          winnerLogic();
        } else if (Player.count == 9) {
          drawLogic();
        } else {
          player.player1BgChange();
          player.player2BgChange();
          resetTimer();
        }
      }
    });
  }

  void winnerLogic() {
    stopTimer();
    Player.finished = true;
    player.changeWinnerCardColor();
    Future.delayed(const Duration(milliseconds: 100),
        () => setState(() => player.updateCardColors()));
    Future.delayed(
      const Duration(milliseconds: 800),
      () => setState(() {
        Player.winner = true;
        Player.updateScores();
        if (Settings.audioValues[0]) {
          AudioPlayer.playResultSound(Player.winnerPlayer);
        }
      }),
    );
  }

  void drawLogic() {
    stopTimer();
    Future.delayed(
      const Duration(milliseconds: 800),
      () => setState(
        () {
          Player.draw = true;
          Player.updateScores();
          if (Settings.audioValues[0]) {
            AudioPlayer.playResultSound(Player.winnerPlayer);
          }
        },
      ),
    );
  }

  void nextRoundFunc() {
    setState(() {
      Player.resetStaticData();
      player.player1BgChange();
      player.player2BgChange();
      resetTimer();
      startTimer();
      Player.winner = false;
      Player.draw = false;
      // Navigator.pop(context);
    });
  }
  Future<bool> onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => DelayedDisplay(
        child: AlertDialog(
          backgroundColor: Colors.transparent,

          content: Container(
            height:  MediaQuery.of(context).size.height * 0.3,
            width:  MediaQuery.of(context).size.width * 0.7,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/images/playerWin_notification.png"),
                    fit: BoxFit.fill)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you sure?',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Paytone',
                    ),
                  ),
                  Text(
                    'Do you want to exit an App',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Paytone',
                    ),
                  ),
                  SizedBox(height:  MediaQuery.of(context).size.height * 0.05,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('No'),
                      ),
                      // SizedBox(height: ,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                ]
            ),
          ),
        ),
      ),
    )) ??
        false;
  }

}


