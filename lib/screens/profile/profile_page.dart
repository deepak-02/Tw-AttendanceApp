import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/login/login_page.dart';

import '../../widgets/profile_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {


  String ? phone;
  String ? name;
  String ? address;
  String ? email;
  String ? jobInfo;
  String ? manager;
  String ? team;
  String ? image;
  String ? userId;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: const Color(0xff21206a),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: 32,
                            child: Image.asset(
                              "assets/icons/splash_logo.png",
                              fit: BoxFit.fitWidth,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (image == "" || image == null)
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        )
                        else
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: NetworkImage("$image")),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xff8dc63f),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                // Handle button press
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                   Text(
                    name ?? 'User Name',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                   Text(
                    jobInfo ?? 'Senior Creative Designer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      height: 0,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, bottom: 8.0, left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Last Activity: 14 Nov 2023',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        ),
                        Text(
                          'Last Active Time: 18:37',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            height: 0,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
           ProfileTile(
            title: "Phone Number",
            content: phone ?? "90908908990",
          ),
           ProfileTile(
            title: "Mail",
            content: email ?? "abcd@techwyseintl.com",
          ),
           ProfileTile(
            title: "Manager",
            content: manager ?? "Some Manager",
          ),
           ProfileTile(
            title: "Team",
            content: team ?? "Twintl - Team WyseGuys",
          ),


          // Padding(
          //   padding: const EdgeInsets.only(left: 20, top: 8),
          //   child: ElevatedButton(
          //     onPressed: () {},
          //     style: ElevatedButton.styleFrom(
          //       foregroundColor: Colors.white,
          //       backgroundColor: const Color(0xFF8DC63F), // Text color
          //       shape: RoundedRectangleBorder(
          //         side: const BorderSide(
          //             width: 0.86, color: Color(0xFF8DC63F)), // Border
          //         borderRadius: BorderRadius.circular(6), // Border radius
          //       ),
          //       // minimumSize: Size(57.43, 36), // Width and height
          //     ),
          //     child: const Text(
          //       "Edit",
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 15.43,
          //         fontWeight: FontWeight.w600,
          //         height: 0,
          //       ),
          //     ),
          //   ),
          // ),

          // // LOG OUT
          // Padding(
          //   padding: const EdgeInsets.all(8),
          //   child: SizedBox(
          //     width: 400,
          //     height: 50,
          //     child: ElevatedButton(
          //       style: ElevatedButton.styleFrom(
          //         elevation: 3,
          //         backgroundColor: const Color(0xff21206a),
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(8.0)),
          //         minimumSize: const Size(100, 40),
          //       ),
          //       onPressed: () async {
          //         SharedPreferences prefs =
          //             await SharedPreferences.getInstance();
          //         prefs.clear();
          //
          //         Get.offAll(
          //           const LoginPage(),
          //           transition: Transition.circularReveal,
          //           duration: const Duration(milliseconds: 800),
          //         );
          //       },
          //       child: const Text(
          //         'Log Out',
          //         style: TextStyle(color: Colors.white, fontSize: 20),
          //       ),
          //     ),
          //   ),
          // ),



        ],
      ),
    );
  }

  void loadProfile() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();

   phone = prefs.getString("phone");
   name = prefs.getString("name");
   address = prefs.getString("address");
   email = prefs.getString("email");
   jobInfo = prefs.getString("jobInfo");
   manager = prefs.getString("manager");
   team = prefs.getString("team");
   image = prefs.getString("image");
   userId = prefs.getString("userId");
   print(image);
   setState(() {

   });
  }
}
