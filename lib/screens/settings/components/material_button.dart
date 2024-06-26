import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/models/player.dart';

class MyMaterialButton extends StatelessWidget {
  final int index;
  final String icon;
  final Function()? onPressed;

  const MyMaterialButton({super.key, required this.index, required this.icon, required this.onPressed, });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 24.0,
      shape: const CircleBorder(),
      disabledTextColor: kTextColor,
      onPressed: onPressed,
      child: Image(image: images(icon),width: MediaQuery.of(context).size.width*0.08),
    );
  }
}
