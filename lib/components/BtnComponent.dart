import 'package:flutter/material.dart';
import 'package:ble_client/constants.dart';

class BtnComponent extends StatelessWidget {
  const BtnComponent({
    super.key,
    required this.action,
    required this.text,
    this.btnColor = kBlueColor,
    this.textColor,
    this.isLoading = false,
  });

  final VoidCallback action;
  final String text;
  final Color? btnColor;
  final Color? textColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                isLoading != null && isLoading == true
                    ? btnColor!.withOpacity(0.8)
                    : btnColor),
            padding: const MaterialStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)))),
        onPressed: action,
        child: isLoading != null && isLoading == true
            ? const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(color: Colors.white))
            : Text(
                text,
                style:
                    TextStyle(fontSize: 20, color: textColor ?? Colors.white),
              ));
  }
}
