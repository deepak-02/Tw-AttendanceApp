import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash_background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
