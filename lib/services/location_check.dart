import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // Request location permission
  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  // Get user location (Returns latitude & longitude)
  static Future<Position?> getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return position; // Returning Position (latitude & longitude)
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }
}
