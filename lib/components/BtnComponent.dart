import 'package:flutter/material.dart';
import 'package:ble_client/constants.dart';

class BtnComponent extends StatelessWidget {
  const BtnComponent({
    super.key,
    required this.action,
    required this.text,
    this.btnColor,
    this.textColor,
  });

  final VoidCallback action;
  final String text;
  final Color? btnColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(btnColor ?? kBlueColor),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 18)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)))),
        onPressed: action,
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: textColor ?? Colors.white),
        ));
  }
}
