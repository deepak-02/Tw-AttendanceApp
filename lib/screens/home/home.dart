import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/home/qr_scan_page.dart';

import '../../widgets/background.dart';
import '../../widgets/home_tile.dart';
import '../profile/profile_page.dart';
import 'dashboard/dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Timer? _timer;

  String ? name;
  String ? jobInfo;
  String ? image;

  @override
  void initState() {
    super.initState();
    loadProfile();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('dd.MM.yyyy EEEE h:mm a');
    final formattedDate = formatter.format(now);
    final now1 = TimeOfDay.now();
    final greeting = _getGreeting(now1);
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                const ProfilePage(),
                                transition: Transition.leftToRightWithFade,
                                duration: const Duration(milliseconds: 500),
                              );
                            },
                            child:
                              image == "" || image!.isEmpty || image == null ?
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                            ) : Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage("$image")),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name ?? "User Name",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 0,
                              ),
                            ),
                            Text(
                              jobInfo ?? 'Senior Creative Designer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                height: 0,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 32,
                          child: Image.asset(
                            "assets/icons/splash_logo.png",
                            fit: BoxFit.fitWidth,
                          )),
                    ),
                  ],
                ),

                // const SizedBox(height: 50,),
                const Spacer(),

                Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: greeting == 'Good Morning'
                          ? const Icon(
                              Icons.sunny,
                              color: Color(0xFFA1DDFF),
                              size: 20,
                            )
                          : greeting == 'Good Afternoon'
                              ? const Icon(
                                  Icons.light_mode_sharp,
                                  color: Color(0xFFA1DDFF),
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.nightlight,
                                  color: Color(0xFFA1DDFF),
                                  size: 20,
                                ),
                    ),
                    Text(
                      greeting,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFA1DDFF),
                        fontSize: 16.84,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '“Perfection is not attainable, but if we chase perfection we can catch excellence.”',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        height: 0,
                      ),
                    ),
                    Text(
                      '- Vince Lombardi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ],
                ),

                // const SizedBox(height: 30,),
                const Spacer(),

                Center(
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: [
                      HomeTile(
                        onTap: () {
                          Get.to(
                            // const Dashboard(index: 0,),
                            const QrScanPage(),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        backgroundColor: const Color(0xFF8DC63F),
                        img: "assets/icons/let_me_checkin_light.svg",
                        name: "LET ME\n CHECK IN",
                        textColor: Colors.white,
                      ),
                      HomeTile(
                        onTap: () {
                          Get.to(
                            const Dashboard(
                              index: 1,
                            ),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        backgroundColor: Colors.white,
                        img: "assets/icons/attendance_history_dark.svg",
                        name: "ATTENDANCE \nHISTORY",
                        textColor: Colors.black,
                      ),
                      HomeTile(
                        onTap: () {
                          Get.to(
                            const Dashboard(
                              index: 2,
                            ),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        backgroundColor: Colors.white,
                        img: "assets/icons/time_sheet_dark.svg",
                        name: "MY \nTIME SHEET",
                        textColor: Colors.black,
                      ),
                      HomeTile(
                        onTap: () {
                          Get.to(
                            const Dashboard(
                              index: 3,
                            ),
                            transition: Transition.zoom,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        backgroundColor: Colors.white,
                        img: "assets/icons/working_on_dark.svg",
                        name: "WORKING ON \nTICKETS",
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 20,),
                const Spacer(),

                Center(
                  child: SvgPicture.asset(
                    "assets/images/bottom_image.svg",
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getGreeting(TimeOfDay time) {
    if (time.hour < 12) {
      return 'Good Morning';
    } else if (time.hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString("name");
    jobInfo = prefs.getString("jobInfo");
    image = prefs.getString("image");
    setState(() {

    });
  }
}
