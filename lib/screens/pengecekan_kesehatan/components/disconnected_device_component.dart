import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisconnectedDeviceComponent extends StatefulWidget {
  const DisconnectedDeviceComponent({super.key});

  @override
  State<DisconnectedDeviceComponent> createState() =>
      _DisconnectedDeviceComponentState();
}

class _DisconnectedDeviceComponentState
    extends State<DisconnectedDeviceComponent> {
  final bluetoothC = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          const CheckCard(
            bgColor: kLightBlueColor,
            iconColor: kBlueColor,
            icon: Icons.bluetooth,
            title: "Pastikan bluetooth pada smartphone anda sudah hidup",
          ),
          const SizedBox(
            height: 20.0,
          ),
          const CheckCard(
            bgColor: kLightRedColor,
            iconColor: kRedColor,
            icon: Icons.devices_other_rounded,
            title: "Pastikan alat pengecekan kesehatan sudah dihidupkan",
          ),
          const Spacer(),
          const Text(
            "Tekan hubungkan untuk menyambungkan aplikasi ke perangkat sensor",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500, color: kTextColor, fontSize: 18),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: BtnComponent(
                text: "Hubungkan Perangkat",
                action: () async {
                  await bluetoothC.checkBluetoothDevice(context);
                }),
          ),
          const SizedBox(
            height: 60.0,
          ),
        ],
      ),
    );
  }
}

class CheckCard extends StatelessWidget {
  const CheckCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.title,
  });

  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              decoration:
                  BoxDecoration(color: iconColor, shape: BoxShape.circle),
              child: Icon(
                icon,
                size: 40,
                color: Colors.white,
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18, color: kTextColor, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
