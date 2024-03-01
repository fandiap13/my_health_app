import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<Map?> getCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? currentUser = prefs.getString('currentUser');
    Map<String, dynamic>? currentUserJson;
    if (currentUser != null) {
      currentUserJson = jsonDecode(currentUser);
      // print("curret user: $currentUser");
      // return UserModel.fromJson(currentUserJson);
    }
    return currentUserJson;
  }

  static Future<void> saveCurrentUser(Map user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(user);
    await prefs.setString('currentUser', userString);
  }

  static Future<void> removeCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentUser');
  }
}
