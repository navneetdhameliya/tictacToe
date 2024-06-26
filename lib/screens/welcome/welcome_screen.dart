import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/responsive_ui.dart';
import 'package:tictactoe/models/settings.dart';
import 'package:tictactoe/screens/welcome/components/scaffold_body.dart';
import 'package:tictactoe/utilities/audio_player.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    if (!Settings.audioValues[1]) AudioPlayer.playMusic();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUI.getDeviceHeight(context);
    ResponsiveUI.getDeviceWidth(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      // appBar: _buildAppBar(context),
      body: MyScaffoldBody(),
    );
  }

}
