import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/dashboard/dashboard.dart';
import '../home/home.dart';
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
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        ),
      ),
    );
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("phone") ?? '';
    bool? checkIn = prefs.getBool("checkIn");

    if (phone != '') {
      if (checkIn == true) {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(
            const Dashboard(),
            transition: Transition.circularReveal,
            duration: const Duration(milliseconds: 800),
          );
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Get.offAll(
            const Home(),
            transition: Transition.circularReveal,
            duration: const Duration(milliseconds: 800),
          );
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(
          const LoginPage(),
          transition: Transition.zoom,
          duration: const Duration(milliseconds: 800),
        );
      });
    }
  }
}
