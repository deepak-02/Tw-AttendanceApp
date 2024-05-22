import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../widgets/attendcard.dart';
import '../../../../widgets/shifttiles.dart';
import '../../../../widgets/timeindicator.dart';
import '../../../profile/profile_page.dart';
import '../../home.dart';
import '../../qr_scan_page.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  bool checkIn = true;

  @override
  void initState() {
    super.initState();
    checkCheckIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffededee),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        backgroundColor: const Color(0xff21206a),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      const ProfilePage(),
                      transition: Transition.leftToRightWithFade,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100)),
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "User Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Text(
                    'Senior Creative Designer',
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      Image.asset(
                        "assets/icons/check-mark.png",
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "You're logged in \nfor the day",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          height: 0.0,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/location-pin.svg",
                      ),
                      // Space between the avatar and the name
                      const Text(
                        'From Office',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TimeRangeProgressIndicator(
                    startTime: '08:00 AM', // Replace with your start time
                    endTime: '05:30 PM',
                    // Replace with your end time
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                children: [
                  const AttendanceWidget(
                    date: 'Monday 1 May 2024',
                    presentText: 'Present',
                    checkInTime: '08:30',
                    checkOutTime: '00:00',
                    totalHours: '4.5 hours',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (checkIn)
                        ElevatedButton(
                          onPressed: () {
                            setCheckOutData();
                            Get.off(const Home());
                            // Implement check-in button functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffee6f6e),
                            minimumSize: const Size(
                                164, 58), // Adjust the button size here
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                // Adjust the border radius for one side
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(
                                    10.0), // Adjust the border radius for one side
                              ),
                            ),
                          ),
                          child: const Text(
                            'CHECK OUT',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      else
                        ElevatedButton(
                          onPressed: () {
                            Get.to(
                              // const Dashboard(index: 0,),
                              const QrScanPage(),
                              transition: Transition.zoom,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffee6f6e),
                            minimumSize: const Size(
                                164, 58), // Adjust the button size here
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                // Adjust the border radius for one side
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(
                                    10.0), // Adjust the border radius for one side
                              ),
                            ),
                          ),
                          child: const Text(
                            'CHECK IN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: () {
                          // Implement check-out button functionality
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffe3a400),
                          minimumSize: const Size(
                              164, 58), // Adjust the button size here
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              // Adjust the border radius for one side
                              bottomRight: Radius.circular(10.0),
                              bottomLeft: Radius.circular(
                                  10.0), // Adjust the border radius for one side
                            ),
                          ),
                        ),
                        child: const Text(
                          'TAKE A BREAK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.30,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            const Center(
              child: Text(
                'Recent Activity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),

            // TODO: need to add a listview builder when the backend is connected
            const Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    ShiftInfoTile(
                      color: Color(0xfffff5da), // Specify your desired color
                      breakText: 'Break', // Specify your break text
                      startShift: '10:00', // Specify your start shift time
                      endShift: '10:15', // Specify your end shift time
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShiftInfoTile(
                      color: Color(0xfffff5da), // Specify your desired color
                      breakText: 'Break', // Specify your break text
                      startShift: '05:00', // Specify your start shift time
                      endShift: '05:15', // Specify your end shift time
                    ),
                    Spacer(), // Adjust spacing between tiles as needed
                    // Add more ShiftInfoTile widgets or other content as needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setCheckOutData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("checkIn", false);
  }

  void checkCheckIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    checkIn = prefs.getBool("checkIn")!;
    setState(() {});
  }
}
