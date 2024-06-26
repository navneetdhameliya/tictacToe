import 'package:flutter/material.dart';
import 'package:tictactoe/models/shared_pref.dart';

class Settings {

  static List<bool> audioValues = [value == null ? true: value!,musicValues == null ? false: musicValues!];
  static List<String> playerRoleNames = ['Your Name', 'Opponent'];
  static List<String> playerNames = [ 'Player 1', 'Player 2'];
  static List playerAvatars = [0, 0];


  static List<int> scores = [winScore == null ? 3: winScore!,drawScore == null ? 5 : drawScore!];
  static List<String> scoreTitles = ['Win Score ', 'Draw Score'];

  static final TextEditingController controllerP1 = TextEditingController();
  static final TextEditingController controllerP2 = TextEditingController();
  static List<TextEditingController> textControllers = [controllerP1, controllerP2];

  static void getTextFieldValues() {
    controllerP1.text = playerNames[0];
    controllerP2.text = playerNames[1];
  }


  static void updatePlayerNames() {
    playerNames[0] = controllerP1.text;
    playerNames[1] = controllerP2.text;
  }

}
