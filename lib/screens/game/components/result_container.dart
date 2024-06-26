import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tictactoe/AdHelper/AdHelper.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/responsive_ui.dart';
import 'package:tictactoe/screens/game/game_screen.dart';
import 'package:tictactoe/screens/welcome/welcome_screen.dart';

class MyResultContainer extends StatefulWidget {
  final Player player;
  final Function() onPressed;

  const MyResultContainer(
      {super.key, required this.player, required this.onPressed});

  @override
  State<MyResultContainer> createState() => _MyResultContainerState();
}

class _MyResultContainerState extends State<MyResultContainer> {
  InterstitialAd? _interstitialAd;

  // TODO: Implement _loadInterstitialAd()
  void showInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                      (route) => false);
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    showInterstitialAd();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose=
    super.dispose();
    _interstitialAd?.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double containerHeight = ResponsiveUI.getHeight(0.44);
    return DelayedDisplay(
      child: Center(
        child: Column(
          children: [
            Container(
                constraints: BoxConstraints.tightFor(
                  width: ResponsiveUI.getWidth(context, 40.0),
                  height: containerHeight,
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: images(playerWinNotificationPath))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: images(
                        Player.pressed == Player.O
                            ? (Player.winnerPlayer == "p2"
                                ? player0Path
                                : player1Path)
                            : (Player.p1 == Player.side
                                ? player0Path
                                : player1Path),
                      ),
                      height: containerHeight * 0.63,
                    ),
                    Text(
                      Player.getResultText(),
                      style: kTextStyle.copyWith(
                          fontSize: ResponsiveUI.getFontSize(35.0)),
                    )
                  ],
                )),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _interstitialAd != null ? () => _interstitialAd?.show():widget.onPressed,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    image: DecorationImage(image: images(otherButtonBgPath))),
                child: Center(
                    child: Text(
                  "Play Again",
                  style: TextStyle(
                      fontFamily: 'Paytone',
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                )),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                widget.player.resetData();
                Player.resetData1();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    (route) => false);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    image: DecorationImage(image: images(otherButtonBgPath))),
                child: Center(
                    child: Text(
                  "Home",
                  style: TextStyle(
                      fontFamily: 'Paytone',
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
