import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';

ThemeData myTheme() {
  return ThemeData(
      useMaterial3: false,
      fontFamily: "Poppins",
      appBarTheme: appBarTheme(),
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: inputDecorationTheme());
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

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    gapPadding: 10,
    borderSide: BorderSide.none,
  );

  return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: const TextStyle(
        color: kDarkColor,
        fontWeight: FontWeight.w500,
      ),
      focusedBorder: outlineInputBorder,
      enabledBorder: outlineInputBorder,
      border: outlineInputBorder,
      filled: true,
      fillColor: kLightGrayColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20));
}
