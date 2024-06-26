import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';
import 'package:tictactoe/models/settings.dart';
import 'package:tictactoe/models/shared_pref.dart';

class PlayerSettings extends StatefulWidget {
  final int playerIndex;
  const PlayerSettings({super.key, required this.playerIndex});

  @override
  _PlayerSettingsState createState() => _PlayerSettingsState();
}

class _PlayerSettingsState extends State<PlayerSettings> {
  @override
  void initState() {
    super.initState();
    Settings.getTextFieldValues();
  }

  @override
  void dispose() {
    super.dispose();
    Settings.updatePlayerNames();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Settings.playerRoleNames[widget.playerIndex],
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03,fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        Container(width: MediaQuery.of(context).size.width * 0.6, height: MediaQuery.of(context).size.height * 0.06, decoration: BoxDecoration(
            image: DecorationImage(image: images(textFieldBg),fit: BoxFit.fill)
        ), child: Center(child: _buildTextField())),
      ],
    );
  }

  TextField _buildTextField() {
    return TextField(
      cursorColor: kXColor,
      // maxLength: 10,
      textCapitalization: TextCapitalization.words,
      controller: Settings.textControllers[widget.playerIndex],
      style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),

      decoration: InputDecoration(
        filled: false,
        fillColor: kContainerColor,
        focusColor: Colors.red,
        counterText: '',

        contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent,width: 0), borderRadius: BorderRadius.circular(5.0)),
        enabledBorder: const OutlineInputBorder(
          borderSide:  BorderSide(color: Colors.transparent,width: 0),
        ),
      ),
    );
  }
}
