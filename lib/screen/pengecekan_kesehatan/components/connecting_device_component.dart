import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ConnectingDeviceComponent extends StatelessWidget {
  const ConnectingDeviceComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: kBlueColor, size: 150),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoadingAnimationWidget.beat(color: kBlueColor, size: 20),
              const SizedBox(
                width: 15,
              ),
              const Text(
                "Memindai Perangkat",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: kTextColor),
              ),
            ],
          ),
          const SizedBox(
            height: 85,
          ),
        ],
      ),
    );
  }
}
