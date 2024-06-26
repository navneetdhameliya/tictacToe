import 'package:flutter/cupertino.dart';

class BgImage extends StatelessWidget {
  const BgImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Image(
          image: AssetImage("assets/images/bgImage.png"),
          fit: BoxFit.fill,
        ));
    ;
  }
}
