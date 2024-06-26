import 'package:firebase_cached_image/firebase_cached_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/models/player.dart';

class MyGestureDetector extends StatelessWidget {
  final String imagePath;
  final FirebaseImageProvider playerImage;
  final Function() onTapFunction;

  const MyGestureDetector({super.key, required this.onTapFunction, required this.imagePath, required this.playerImage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTapFunction,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  child: Image(image: images(imagePath),),
                ),
              ),
              Container(
                          child: playerPickUpImage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playerPickUpImage(BuildContext context) {
    return Center(
      child: Image(
        image: playerImage,
      ),
    );
  }
}
