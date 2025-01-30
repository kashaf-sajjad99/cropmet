import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  // Request location permission
  static Future<bool> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isPermanentlyDenied) {
      openAppSettings();
    }

    return status.isGranted;
  }

  // Check if location services are enabled
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Get user location (Returns latitude & longitude)
  static Future<Position?> getUserLocation() async {
    bool permissionGranted = await requestLocationPermission();
    if (!permissionGranted) {
      print("Location permission not granted");
      return null;
    }

    bool serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled. Prompting user to enable...");
      await Geolocator.openLocationSettings();
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return position; // Returning Position (latitude & longitude)
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }
}
