import 'package:flutter/material.dart';
import 'package:ble_client/constants.dart';

class BtnRectangleComponent extends StatelessWidget {
  const BtnRectangleComponent({
    super.key,
    required this.action,
    required this.text,
    required this.active,
  });

  final VoidCallback action;
  final String text;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(0),
          backgroundColor:
              MaterialStatePropertyAll(active ? kBlueColor : Colors.white),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(vertical: 5, horizontal: 10)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(0.0), // Mengatur border radius
              side:
                  const BorderSide(color: kBlueColor), // Mengatur warna border
            ),
          ),
        ),
        onPressed: action,
        child: Text(
          text,
          style: TextStyle(color: active ? Colors.white : kBlueColor),
        ));
  }
}
