import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tictactoe/AdHelper/AdHelper.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/responsive_ui.dart';
import 'package:tictactoe/screens/common_logo.dart';
import 'package:tictactoe/screens/pickup/gesture_detector.dart';
import 'package:tictactoe/widgets/bgImage.dart';

import '../game/game_screen.dart';

class PickUpScreen extends StatefulWidget {
  @override
  _PickUpScreenState createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  BannerAd? _bannerAd;
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

  void showBannerAdd(){
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },

        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();
  }

  @override
  void initState() {
    Player.pressed = imageName;
    showBannerAdd();
    showInterstitialAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(image: images(bgImagePath),fit: BoxFit.fill)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * 0.06,
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xff53A9FF), Color(0xff1240B0)],
              ).createShader(bounds),
              child: Text(
                'Choose a side',
                textAlign: TextAlign.center,
                style: kTextStyle.copyWith(
                    fontSize: ResponsiveUI.getFontSize(30.0)),
              ),
            ),
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.X),
              imagePath: Player.pressed == Player.X
                  ? selectedCharBGPath
                  : bgImagePath,
              playerImage: Player.p1,
            ),
            _bannerAd != null
                ? Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: _bannerAd!.size.width.toDouble(),
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!,),
                    ),
                  )
                : const SizedBox(),
            MyGestureDetector(
              onTapFunction: () => setState(() => Player.pressed = Player.O),
              imagePath: Player.pressed == Player.O
                  ? selectedCharBGPath
                  : bgImagePath,
              playerImage: Player.p2,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (_interstitialAd != null) {
                    _interstitialAd?.show();
                  } else {
                    // log("====Alert=====> Come in _interstitialAd null part");
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => GameScreen()),(route) => false);
                  }
                },
                child: SizedBox(
                  height: screenHeight * 0.097,
                  width: screenWidth * 0.83,
                  child: Image(
                    image: images(startButtonPath),
                  ),
                ),
              ),
            ),
            // CommonLogo(context,false),

          ],
        ),
      ),
    );
  }
}
