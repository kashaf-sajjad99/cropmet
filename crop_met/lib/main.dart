import 'package:crop_met/screens/ai.dart';
import 'package:crop_met/screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/splash':
            return MaterialPageRoute(builder: (context) => SplashScreen());

          default:
            return MaterialPageRoute(builder: (context) => MyHomePage());
        }
      },
    );
  }
}
