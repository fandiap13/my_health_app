import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingScreenComponent extends StatelessWidget {
  const LoadingScreenComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: kBlueColor, size: 75),
      ),
    );
  }
}
