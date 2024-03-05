import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorMessageComponent extends StatelessWidget {
  const ErrorMessageComponent(
      {super.key, required this.errorMessage, required this.action});

  final String errorMessage;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Center(
              child: Icon(
                CupertinoIcons.multiply_circle_fill,
                color: kRedColor,
                size: 140,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Error !",
              style: TextStyle(
                  fontSize: 26, color: kTextColor, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 18, color: kTextColor),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: BtnComponent(
                action: action,
                text: "Selesai",
                btnColor: kRedColor,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    ));
  }
}
