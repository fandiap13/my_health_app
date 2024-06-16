import 'package:ble_client/components/BottomNavBar.dart';
import 'package:ble_client/components/ErrorMessageComponent.dart';
import 'package:ble_client/components/SuccessMessageComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/bluetooth_controller.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/pengecekan_kesehatan/components/connected_device_component.dart';
import 'package:ble_client/screens/pengecekan_kesehatan/components/connecting_device_component.dart';
import 'package:ble_client/screens/pengecekan_kesehatan/components/disconnected_device_component.dart';
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
          Get.toNamed(HomeScreen.routeName);
        }
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            if (bluetoothC.status.value == Status.LOADING) {
              return const ConnectingDeviceComponent();
            } else if (bluetoothC.status.value == Status.FAILED) {
              return ErrorMessageComponent(
                errorMessage: bluetoothC.errorMessage.value,
                action: () => bluetoothC.clearAllData(),
              );
            } else if (bluetoothC.status.value == Status.SUCCESS) {
              return SuccessMessageComponent(
                message: "Perangkat berhasil terhubung",
                action: () => bluetoothC.clearAllData(),
              );
            } else if (bluetoothC.checkConnectionDevice()) {
              return const ConnectedDeviceComponent();
            } else {
              return const DisconnectedDeviceComponent();
            }
          }),
          bottomNavigationBar: Obx(
            () => Visibility(
                visible: (bluetoothC.status.value == Status.NONE &&
                    // bluetoothC.status.value != Status.FAILED &&
                    bluetoothC.checkConnectionDevice()),
                child: const ButtonNavBar(
                    bgColor: kBgGray,
                    selectedMenu: MenuState.PENGECEKAN_KESEHATAN)),
          ),
        ),
      ),
    );
  }
}
