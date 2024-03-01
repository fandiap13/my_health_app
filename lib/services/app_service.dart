import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/sign_in/sign_in_screen.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppService {
  // untuk mengecek apakah user sudah login (halaman setelah login)
  static Future<void> checkUserAfterLogin() async {
    var currentUser = await UserPreferences.getCurrentUser();
    if (currentUser == null) {
      await UserPreferences.removeCurrentUser();
      await GoogleSignIn().signOut();
      Get.offAllNamed(SignInScreen.routeName);
    }
  }

  // untuk mengecek apakah user sudah login pada halaman sebelum login (login page, splash)
  static Future<void> checkUserBeforeLogin() async {
    var currentUser = await UserPreferences.getCurrentUser();
    if (currentUser != null) {
      Get.offAllNamed(HomeScreen.routeName);
    }
  }
}
