import 'dart:io';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

////monitor connection
bool isConnection = true;
void monitorInternetConnection() {
  InternetConnection().onStatusChange.listen((InternetStatus status) async {
    if (status == InternetStatus.connected) {
      print('You are connected to the internet.');
      isConnection = true;

      // _showTopSnackBar('Back online!', Colors.green);
    } else if (status == InternetStatus.disconnected) {
      print('No internet connection.');
      isConnection = false;
      _showTopSnackBar('No internet connection!', Colors.red);
    }
  });
}

Future<bool> hasInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } catch (e) {
    return false;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// / Function to display a top Snackbar-like widget
void _showTopSnackBar(String message, Color backgroundColor) {
  final overlay = navigatorKey.currentState?.overlay;
  if (overlay == null) return;

  final overlayEntry = OverlayEntry(
    builder:
        (context) => Positioned(
          top:
              MediaQueryData.fromWindow(
                WidgetsBinding.instance.window,
              ).padding.top +
              30,
          left: 10,
          right: 10,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(Duration(seconds: 3), () {
    overlayEntry.remove();
  });
}
