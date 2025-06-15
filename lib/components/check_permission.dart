import 'package:cropmet/components/dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<bool> checkPermission(BuildContext context) async {
  try {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    // If there's an error, consider permission not granted
    showLocationDialog(context);

    return false;
  }
}

Future<bool> getLocationFirstTime() async {
  try {
    await Geolocator.getCurrentPosition();
    print("✅ Location granted.");
    return true;
  } catch (e) {
    print("❌ Location denied or error: $e");
    return false;
  }
}
