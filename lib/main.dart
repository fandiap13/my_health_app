import 'package:ble_client/app_pages.dart';
import 'package:ble_client/firebase_options.dart';
import 'package:ble_client/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Mencegah rotasi ke atas (potret)
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Set your desired status bar color
      statusBarIconBrightness: Brightness.light,
    ));

    return GetMaterialApp(
      title: 'Peduliin',
      debugShowCheckedModeBanner: false,
      theme: myTheme(),
      getPages: appPages,
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
    );
  }
}
