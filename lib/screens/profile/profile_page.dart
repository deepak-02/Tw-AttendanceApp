import 'package:flutter/material.dart';

import '../../widgets/profile_tile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
                        Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                  const Text(
                    'User Name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  const Text(
                    'Senior Creative Designer',
                    style: TextStyle(
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
          const ProfileTile(
            title: "Phone Number",
            content: "9078908990",
          ),
          const ProfileTile(
            title: "Mail",
            content: "abcd@techwyseintl.com",
          ),
          const ProfileTile(
            title: "Manager",
            content: "Frinley Paul",
          ),
          const ProfileTile(
            title: "Team",
            content: "Twintl - Team Oasis",
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 8),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF8DC63F), // Text color
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                      width: 0.86, color: Color(0xFF8DC63F)), // Border
                  borderRadius: BorderRadius.circular(6), // Border radius
                ),
                // minimumSize: Size(57.43, 36), // Width and height
              ),
              child: const Text(
                "Edit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.43,
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
