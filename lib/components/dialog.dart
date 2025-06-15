import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showLocationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.zero,
        content: Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/sad.png',
                    width: 80, // Adjust size as needed
                    height: 80,
                    fit: BoxFit.cover, // Adjust how the image fits
                  ),
                  SizedBox(height: 10),
                  Text(
                    "We need access to your location to provide accurate weather.",
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      openAppSettings();
                    },
                    child: Text("Got it!"),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.close, color: Colors.grey, size: 24),
              ),
            ),
          ],
        ),
      );
    },
  );
}
