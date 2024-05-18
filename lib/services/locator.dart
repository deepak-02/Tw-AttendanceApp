import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> isNearTargetLocation(Position targetLocation) async {
  if (!await isLocationPermissionGranted()) {
    // Handle the case where the user denied location permissions.
    // For example, show an error message or disable the button.
    Fluttertoast.showToast(
        msg: "Denied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 16.0);

    return false;
  }

  final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  // final targetLocation = Position(
  //   latitude: 9.579191,
  //   longitude: 76.315885,
  //   timestamp: DateTime.now(),
  //   accuracy: 0.0,
  //   altitude: 0.0,
  //   altitudeAccuracy: 0.0,
  //   heading: 0.0,
  //   headingAccuracy: 0.0,
  //   speed: 0.0,
  //   speedAccuracy: 0.0,
  // );

  if (kDebugMode) {
    print("position: $position");
    print("targetLocation: $targetLocation");
  }

  final distance = Geolocator.distanceBetween(position.latitude,
      position.longitude, targetLocation.latitude, targetLocation.longitude);
  // Check if the distance is within a certain threshold, e.g., 100 meters
  if (kDebugMode) {
    print("distance: $distance");
  }

  return distance <= 100;
}

Future<bool> isLocationPermissionGranted() async {
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      Fluttertoast.showToast(
          msg: "Permission Denied",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);

      return false;
    }
  }
  return permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always;
}
