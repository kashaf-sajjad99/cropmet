import 'package:cropmet/theme/colors.dart';
import 'package:flutter/material.dart';

Widget weatherInfoBox(IconData icon, String value, String label) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(10),
        child: Icon(icon, size: 30, color: primaryColor1),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      Text(label, style: TextStyle(fontSize: 12, color: primaryColor)),
    ],
  );
}
