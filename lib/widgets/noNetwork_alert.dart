import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget noNetworkAlert(BuildContext context,void Function()? onPressed){
  return  AlertDialog(
    backgroundColor: Colors.transparent,
    content: Container(
      height: 200,
      width: 350,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/playerWin_notification.png"),fit: BoxFit.fill)
      ),
      // color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           const Text('No internet connection',style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Paytone',
          ),),
          const SizedBox(height: 10,),
          const  Text('Please turn on your internet',style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: 'Paytone',
          ),),
          const SizedBox(height: 20,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent
            ),
            onPressed: onPressed,
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
}