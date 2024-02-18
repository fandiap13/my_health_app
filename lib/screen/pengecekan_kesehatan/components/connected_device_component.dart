import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controller/BluetoothController.dart';
import 'package:ble_client/screen/hasil_pengecekan/hasil_pengecekan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectedDeviceComponent extends StatefulWidget {
  const ConnectedDeviceComponent({super.key});

  @override
  State<ConnectedDeviceComponent> createState() =>
      _ConnectedDeviceComponentState();
}

class _ConnectedDeviceComponentState extends State<ConnectedDeviceComponent> {
  final bluetootC = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 100.0,
          ),
          const Text(
            "Pengecekan Kesehatan",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
          const SizedBox(
            height: 25.0,
          ),
          DeviceCard(
            title: "Oksimeter",
            imgUrl: "assets/images/oksimeter.png",
            action: () {
              Get.toNamed(HasilPengecekanScreen.routeName, arguments: {
                "imgUrl": "assets/images/oksimeter.png",
                "title": "Oksimeter",
              });
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          DeviceCard(
            title: "Termometer",
            imgUrl: "assets/images/termometer.png",
            action: () {
              Get.toNamed(HasilPengecekanScreen.routeName, arguments: {
                "imgUrl": "assets/images/termometer.png",
                "title": "Termometer",
              });
            },
          ),
          const SizedBox(
            height: 40.0,
          ),
          SizedBox(
            width: double.infinity,
            child: BtnComponent(
              action: () async => await bluetootC.disconnectDevice(),
              text: "Disconnect device",
              btnColor: Colors.red[700],
            ),
          )
        ],
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.action,
  });

  final String imgUrl;
  final String title;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: kLightBlueColor, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: Image.asset(imgUrl),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 50,
            color: kBlueColor,
          ),
        ),
      ),
    );
  }
}
