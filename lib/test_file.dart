// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// class TestFile extends StatefulWidget {
//   const TestFile({Key? key}) : super(key: key);
//
//   @override
//   _TestFileState createState() => _TestFileState();
// }
//
// class _TestFileState extends State<TestFile> {
//   Position? _currentPosition;
//   String? _currentAddress;
//
//   late List<Placemark> placemarks1;
//
//   late Placemark place1;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     print("is enabled");
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     // if (!serviceEnabled) {
//     //   return;
//     // }
//
//     print("checking permission");
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       print("permission denied");
//
//       if (permission == LocationPermission.denied) {
//         print("permission denied for ever");
//         return;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return;
//     }
//
//     try {
//       _currentPosition = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       _convertToAddress();
//     } catch (e) {
//       print("Error getting location: $e");
//     }
//   }
//
//   Future<void> _convertToAddress() async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//           _currentPosition!.latitude, _currentPosition!.longitude
//           // 9.579191,
//           // 76.315885
//           );
//       placemarks1 = placemarks;
//       Placemark place = placemarks[0];
//       place1 = place;
//       print(place);
//       setState(() {
//         _currentAddress =
//             "${place.street}, ${place.locality}, ${place.postalCode}";
//       });
//     } catch (e) {
//       print("Error converting to address: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Location Details')),
//       body: Center(
//           child: _currentAddress == null ||
//                   _currentPosition == null ||
//                   _currentAddress!.isEmpty
//               ? CircularProgressIndicator()
//               : SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Text('${placemarks1.length}\n'),
//                       Text(
//                         'Your location is :\n $_currentAddress\n',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       // Text('complete location is:    ${_currentPosition!.toJson()}\n'),
//                       // Text('place marks list:   ${placemarks1}\n'),
//                       Text('Street: ${place1.street}\n'
//                           'Locality: ${place1.locality}'),
//                     ],
//                   ),
//                 )),
//     );
//   }
// }
