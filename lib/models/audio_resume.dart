import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:tictactoe/models/settings.dart';
import 'package:tictactoe/utilities/audio_player.dart';

class Handler extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!Settings.audioValues[1]) {
      if (state == AppLifecycleState.resumed ) {
        AudioPlayer.playMusic(); // Audio player is a custom class with resume and pause static methods
      }
      else{
        AudioPlayer.stopMusic();
      }
    }
  }
}
