import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/models/responsive_ui.dart';

class CardGestureDetector extends StatelessWidget {
  final Function() onTapFunction;
  final FirebaseImageProvider boxSide;
  final Color cardColor;

  const CardGestureDetector({super.key, required this.onTapFunction, required this.boxSide, required this.cardColor});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: onTapFunction,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              constraints: BoxConstraints.tightFor(
                width: ResponsiveUI.getBoxWidth(constraints.maxWidth, 10.0),
                height: ResponsiveUI.getBoxWidth(constraints.maxWidth, 10.0),
              ),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Image(
                  image: boxSide,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
