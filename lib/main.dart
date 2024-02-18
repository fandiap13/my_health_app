import 'package:ble_client/firebase_options.dart';
import 'package:ble_client/my_theme.dart';
import 'package:ble_client/screen/hasil_pengecekan/hasil_pengecekan_screen.dart';
import 'package:ble_client/screen/home/home_screen.dart';
import 'package:ble_client/screen/pengecekan_kesehatan/pengecekan_kesehatan_screen.dart';
import 'package:ble_client/screen/profile/profile_screen.dart';
import 'package:ble_client/screen/riwayat_kesehatan/riwayat_kesehatan_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';

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
      title: 'Flutter BLE Client',
      debugShowCheckedModeBanner: false,
      theme: myTheme(),
      getPages: [
        GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
        GetPage(
            name: PengecekanKesehatan.routeName,
            page: () => const PengecekanKesehatan()),
        GetPage(
            name: HasilPengecekanScreen.routeName,
            page: () => const HasilPengecekanScreen()),
        GetPage(
            name: RiwayatkesehatanScreen.routeName,
            page: () => const RiwayatkesehatanScreen()),
        GetPage(
            name: ProfileScreen.routeName, page: () => const ProfileScreen()),
      ],
    );
  }
}
