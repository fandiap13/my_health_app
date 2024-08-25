import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';

class BackButtonComponent extends StatelessWidget {
  const BackButtonComponent({
    super.key,
    required this.action,
  });

  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration:
            const BoxDecoration(color: kLightGrayColor, shape: BoxShape.circle),
        child: const Icon(Icons.arrow_back_ios_new_rounded),
      ),
    );
  }
}
