import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarIconBrightness: Brightness.light,
    // ));

    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(
        // const Home(),
        const LoginPage(),
        transition: Transition.zoom,
        duration: const Duration(milliseconds: 800),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SizedBox(
          width: 80,
          child: SvgPicture.asset(
            "assets/icons/splash_logo1.svg",
          ),

          // Image.asset(
          //   "assets/icons/splash_logo.png",
          //   fit: BoxFit.fitWidth,
          // )
        ),
      ),
    );
  }
}
