import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final textPadding;
  final Function() onPressed;

  MaterialButtonWidget({required this.text, required this.textSize, this.textPadding, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: MaterialButton(
        padding: EdgeInsets.all(textPadding ?? 8.0),
        textColor: kTextColor,
        color: kContainerCardColor,
        minWidth: double.infinity,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: onPressed,

        child:  Text(
          text,
          style: TextStyle(fontFamily: 'Paytone', fontSize: textSize),
        ),
      ),
    );
  }
}
