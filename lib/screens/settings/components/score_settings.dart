import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/settings.dart';
import 'package:tictactoe/models/shared_pref.dart';
import 'package:tictactoe/screens/settings/components/material_button.dart';

class ScoreSettings extends StatefulWidget {
  final int index;
  const ScoreSettings(this.index);

  @override
  _ScoreSettingsState createState() => _ScoreSettingsState();
}

class _ScoreSettingsState extends State<ScoreSettings> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(Settings.scoreTitles[widget.index], style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
        MyMaterialButton(
          index: widget.index,
          icon: minusIconPah,
          onPressed: Settings.scores[widget.index] > 1 ? decrementFunc : null,
        ),
        Text('${Settings.scores[widget.index]}',style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03)),
        MyMaterialButton(
          index: widget.index,
          icon: plusIconPath,
          onPressed: Settings.scores[widget.index] < 20 ? incrementFunc : null,
        ),
      ],
    );
  }

  void incrementFunc() {
    setState(() {
      Settings.scores[widget.index]++;
      SharedPref().setWinValue(Settings.scores[0]);
      SharedPref().setDrawValue(Settings.scores[1]);

    });
  }

  void decrementFunc() {
    setState(() {
      Settings.scores[widget.index]--;
      SharedPref().setWinValue(Settings.scores[0]);
      SharedPref().setDrawValue(Settings.scores[1]);
    });
  }
}
