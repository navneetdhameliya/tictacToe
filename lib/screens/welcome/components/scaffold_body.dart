import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/responsive_ui.dart';
import 'package:tictactoe/screens/common_logo.dart';
import 'package:tictactoe/screens/game/game_screen.dart';
import 'package:tictactoe/screens/pickup/pickup_screen.dart';
import 'package:tictactoe/screens/settings/settings_screen.dart';
import 'package:tictactoe/widgets/bgImage.dart';

class MyScaffoldBody extends StatefulWidget {

  @override
  State<MyScaffoldBody> createState() => _MyScaffoldBodyState();
}

class _MyScaffoldBodyState extends State<MyScaffoldBody> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Container(
         height: double.maxFinite,
         width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(image: images(bgImagePath),fit: BoxFit.fill)
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.06,),
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
              child: Row(children: [
                GestureDetector(
                  onTap: () => settingDialog(context),
                  child: SizedBox(
                    width: screenWidth*0.11,
                    height: screenWidth*0.11,
                    child: Image(image: images(settingButtonPath),),
                  ),
                ),
                SizedBox(width: screenWidth * 0.05,),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xff53A9FF), Color(0xff1240B0)],
                  ).createShader(bounds),
                  child: Text(
                    'TIC TAC TOE',
                    textAlign: TextAlign.center,
                    style: kTextStyle.copyWith(
                      fontSize: ResponsiveUI.getFontSize(33.0),
                    ),
                  ),
                ),
              ],),
            ),
            Expanded(child: homeScreenIcon(context)),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PickUpScreen()),),
                child: SizedBox(
                  height: screenHeight*0.097,
                  width: screenWidth*0.83,
                  child: Image(image: images(pickSideButtonPath),),
                ),
              ),
            ),
            // CommonLogo(context,false),


          ],
        ),
      ),
    );
  }

  Widget homeScreenIcon(BuildContext context) {
    return Center(
      child: Image(
        image: images(homeIconPath),
      )
    );
  }

  settingDialog(BuildContext context){
    showDialog(context: context, builder: (BuildContext context) {

      Orientation currentOrientation = MediaQuery.of(context).orientation;
      double screenHeight;
      double screenWidth;
      if(currentOrientation == Orientation.portrait){
        screenHeight = MediaQuery.of(context).size.height;
        screenWidth = MediaQuery.of(context).size.height;
      } else {
        screenHeight = MediaQuery.of(context).size.width;
        screenWidth = MediaQuery.of(context).size.width;
      }
      return DelayedDisplay(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            AlertDialog(
              backgroundColor: Colors.transparent,
              title: Container(
                height: screenHeight * 0.6,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                    image: DecorationImage(image: images(playerWinNotificationPath),fit: BoxFit.fill)),
                child: SettingsScreen(),
              ),
            ),
          ],
        ),
      ),
    );
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
