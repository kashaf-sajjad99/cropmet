import 'package:cropmet/components/check_permission.dart';
import 'package:cropmet/components/dialog.dart';
import 'package:cropmet/components/notification.dart';
import 'package:cropmet/components/open_url.dart';
import 'package:cropmet/screens/landing.dart';
import 'package:cropmet/services/location_check.dart';
import 'package:cropmet/services/shared_prefrence.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StarterScreen extends StatefulWidget {
  const StarterScreen({super.key});

  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 200),
            Image.asset(
              'assets/startscreenpic.png',
              width: 350, // Adjust size as needed
              height: 200,
              fit: BoxFit.cover, // Adjust how the image fits
            ),
            SizedBox(height: 80),
            SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), // Rounded corners
                  ),
                  backgroundColor: primaryColor1,
                ),
                onPressed: () async {
                  bool isPermission;
                  if (kIsWeb) {
                    isPermission = await getLocationFirstTime();
                  } else {
                    isPermission =
                        await LocationService.requestLocationPermission();
                  }
                  if (isPermission) {
                    await PreferencesHelper.setFirstTimeFalse();
                    if (mounted) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Landing(pageIndex: 0),
                        ), // Your homepage widget
                      );
                    }
                  } else {
                    showLocationDialog(context);
                  }
                },
                child: Text(
                  "Allow Location",
                  style: TextStyle(color: secondaryColor, fontSize: 14),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  try {
                    openPrivacyPolicy();
                  } catch (e) {
                    showBottomSnackBar(
                      context,
                      "Failed to open privacy policy.",
                    );
                  }
                },
                child: Text.rich(
                  TextSpan(
                    text: 'By allowing your location, you agree to our ',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                    children: [
                      TextSpan(
                        text: 'Privacy Policy.',
                        style: TextStyle(color: primaryColor1, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
