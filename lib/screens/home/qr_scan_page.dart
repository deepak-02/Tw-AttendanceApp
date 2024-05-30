import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/locator.dart';
import '../../widgets/background.dart';
import 'dashboard/dashboard.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  late QRViewController controller;

  Position? currentPosition;

  String? name;
  String? jobInfo;
  String? image;

  // dynamic isNear;
  // final targetLocation = [
  //   //home
  //   Position(
  //     latitude: 9.579191,
  //     longitude: 76.315885,
  //     timestamp: DateTime.now(),
  //     accuracy: 0.0,
  //     altitude: 0.0,
  //     altitudeAccuracy: 0.0,
  //     heading: 0.0,
  //     headingAccuracy: 0.0,
  //     speed: 0.0,
  //     speedAccuracy: 0.0,
  //   ),
  //   //office
  //   Position(
  //     latitude: 9.966287037167914,
  //     longitude: 76.29507080515788,
  //     timestamp: DateTime.now(),
  //     accuracy: 0.0,
  //     altitude: 0.0,
  //     altitudeAccuracy: 0.0,
  //     heading: 0.0,
  //     headingAccuracy: 0.0,
  //     speed: 0.0,
  //     speedAccuracy: 0.0,
  //   ),
  //   // valparai
  //   Position(
  //     latitude: 10.325789171013938,
  //     longitude: 76.95583307172461,
  //     timestamp: DateTime.now(),
  //     accuracy: 0.0,
  //     altitude: 0.0,
  //     altitudeAccuracy: 0.0,
  //     heading: 0.0,
  //     headingAccuracy: 0.0,
  //     speed: 0.0,
  //     speedAccuracy: 0.0,
  //   ),
  // ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    loadProfile();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    if (await isLocationPermissionGranted()) {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {});
    }

    // for (int i = 0; i <= targetLocation.length; i++) {
    //   if (await isNearTargetLocation(targetLocation[i])) {
    //     isNear = true;
    //     setState(() {});
    //     break;
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                              // Get.to(
                              //   const ProfilePage(),
                              //   transition: Transition.leftToRightWithFade,
                              //   duration: const Duration(milliseconds: 500),
                              // );
                            },
                            child: image == "" || image == null
                                ? Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.black,
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage("$image")),
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name ?? "User Name",
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
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                          width: 32,
                          child: SvgPicture.asset(
                            "assets/icons/splash_logo1.svg",
                          )
                          // Image.asset(
                          //   "assets/icons/splash_logo.png",
                          //   fit: BoxFit.fitWidth,
                          // )
                          ),
                    ),
                  ],
                ),

                // const SizedBox(height: 50,),
                const Spacer(),

                const Text(
                  'Scan QR code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                const Text(
                  'Place QR code inside the frame to scan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 50),
                  child:
                      // isNear == null
                      //     ? Container(
                      //         alignment: Alignment.center,
                      //         color: Colors.grey,
                      //         height: 196,
                      //         width: 196,
                      //         child: const CircularProgressIndicator(),
                      //       ) :
                      Stack(
                    children: [
                      //replace it with a qr scan viewfinder
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 196,
                      //   width: 196,
                      //   color: const Color(0xffd9d9d9),
                      // ),

                      Container(
                        alignment: Alignment.center,
                        height: 196,
                        width: 196,
                        color: Colors.grey,
                        child: QRView(
                          key: GlobalKey(),
                          onQRViewCreated: (QRViewController newController) {
                            controller = newController;
                            controller.scannedDataStream.listen((scanData) {
                              int index = 0;
                              index++;
                              if (kDebugMode) {
                                print('QR Code Scanned: ${scanData.code}');
                                print('Scanned: $index');
                                print('latitude: ${currentPosition!.latitude}');
                                print(
                                    'longitude: ${currentPosition!.longitude}');
                              }

                              // Handle the scanned data here
                              setCheckInData();

                              // Fluttertoast.showToast(
                              //     msg: "${scanData.code}",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     fontSize: 16.0
                              // );

                              controller.pauseCamera();
                              newController.pauseCamera();

                              controller.dispose();
                              newController.dispose();

                              Get.off(
                                const Dashboard(
                                  index: 0,
                                ),
                                transition: Transition.zoom,
                                duration: const Duration(milliseconds: 500),
                              );
                            });
                          },
                        ),
                      ),

                      Container(
                        alignment: Alignment.center,
                        height: 196,
                        width: 196,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset("assets/images/qr_cross_img.png"),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 266,
                  height: 42,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 59, vertical: 10),
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFF8DC63F),
                    shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFF8DC63F)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child:
                      // isNear == null || isNear == false
                      //     ? const Text(
                      //         "Not allowed",
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontSize: 18,
                      //           fontFamily: 'Inter',
                      //           fontWeight: FontWeight.w600,
                      //           height: 0,
                      //         ),
                      //       ) :
                      const Text(
                    'Scanning Code...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
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

  void setCheckInData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("checkIn", true);
  }

  void loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    name = prefs.getString("name");
    jobInfo = prefs.getString("jobInfo");
    image = prefs.getString("image");
    setState(() {});
  }
}
