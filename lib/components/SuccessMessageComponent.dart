import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessMessageComponent extends StatelessWidget {
  const SuccessMessageComponent(
      {super.key, required this.message, required this.action});

  final String message;
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
                CupertinoIcons.check_mark_circled_solid,
                color: kBlueColor,
                size: 140,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 26,
                    color: kTextColor,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: BtnComponent(
                action: action,
                text: "Selesai",
                btnColor: kBlueColor,
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
