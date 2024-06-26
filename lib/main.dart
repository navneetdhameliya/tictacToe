import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/audio_resume.dart';
import 'package:tictactoe/models/shared_pref.dart';
import 'package:tictactoe/widgets/noNetwork_alert.dart';
import 'package:tictactoe/utilities/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:  FirebaseOptions( projectId: 'tictactoe-a0520', appId: Platform.isAndroid ? '1:612211353783:android:15a17c3fdcf93227004532' : '1:612211353783:ios:549b63b17b73a52d004532', messagingSenderId: '', apiKey: Platform.isAndroid ? "AIzaSyCX66ArSC4uYOs2I1_u7-K8SLwwZit0BjU" :"AIzaSyDRN9PGKHYFnd6BUy8eHRoH4f3mvPsepNc"));
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
  WidgetsBinding.instance!.addObserver(new Handler());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Future<InitializationStatus> _initGoogleMobileAds() {
  //   // TODO: Initialize Google Mobile Ads SDK
  //   return MobileAds.instance.initialize();
  // }

  bool showPopup = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();

  }

  _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time') ?? true;

    if (connectivityResult == ConnectivityResult.none ) {

      if (firstTime) {
        setState(() {
          showPopup = true;
        });

        // await prefs.setBool('first_time', false);
      }
    }else if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi ){
            await prefs.setBool('first_time', false);
    }
    await SharedPref().getSoundValue();
    await SharedPref().getMusicValue();
    await SharedPref().getWinValue();
    await SharedPref().getDrawValue();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: showPopup
          ? noNetworkAlert(context, () async {
        if (await Connectivity().checkConnectivity() !=
            ConnectivityResult.none) {
          setState(() {
            showPopup = false;
          });
        }
      })
          : SplashScreen(),
    );
  }
}
