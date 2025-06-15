import 'package:cropmet/screens/splashscreen.dart';
import 'package:cropmet/services/db_hive.dart';
import 'package:cropmet/services/internet_check.dart';
import 'package:cropmet/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Future.delayed(Duration(seconds: 5));
  monitorInternetConnection();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: primaryColorNav,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

Future<void> initHive() async {
  print("Initilizing Hive..");
  if (kIsWeb) {
    await Hive.initFlutter(); // For Web
  } else {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path); // For Android, iOS, macOS
  }
  await HiveService.initializeHive();
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
        }
      },
    );
  }
}
