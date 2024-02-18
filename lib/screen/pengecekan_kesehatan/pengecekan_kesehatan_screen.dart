import 'package:ble_client/controller/BluetoothController.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/screen/home/home_screen.dart';
import 'package:ble_client/screen/pengecekan_kesehatan/components/connected_device_component.dart';
import 'package:ble_client/screen/pengecekan_kesehatan/components/connecting_device_component.dart';
import 'package:ble_client/screen/pengecekan_kesehatan/components/disconnected_device_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengecekanKesehatan extends StatefulWidget {
  const PengecekanKesehatan({super.key});
  static String routeName = "/pengecekan_kesehatan";

  @override
  State<PengecekanKesehatan> createState() => _PengecekanKesehatanState();
}

class _PengecekanKesehatanState extends State<PengecekanKesehatan> {
  final bluetoothC = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // jika sedang tidak menyambungkan ke perangkat esp maka fungsi ini akan berjalan
        if (bluetoothC.status.value != Status.LOADING) {
          Get.offNamed(HomeScreen.routeName);
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            if (bluetoothC.status.value == Status.LOADING) {
              return const ConnectingDeviceComponent();
            } else if (bluetoothC.checkConnectionDevice()) {
              return const ConnectedDeviceComponent();
            } else {
              return const DisconnectedDeviceComponent();
            }
          }),
        ),
      ),
    );
  }
}
