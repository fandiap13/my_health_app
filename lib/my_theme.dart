import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';

ThemeData myTheme() {
  return ThemeData(
      useMaterial3: false,
      fontFamily: "Poppins",
      appBarTheme: appBarTheme(),
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity);
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
      centerTitle: true,
      color: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: kDarkColor),
      titleTextStyle:
          TextStyle(color: kTextColor, fontSize: 18, fontFamily: "Poppins"));
}
