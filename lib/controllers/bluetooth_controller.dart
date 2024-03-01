import 'dart:async';
import 'dart:convert';

import 'package:ble_client/enums.dart';
import 'package:ble_client/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothController extends GetxController {
  final Rx<Status> status = Status.NONE.obs;
  final Rx<BluetoothDevice?> deviceConnected = Rx<BluetoothDevice?>(null);
  final errorMessage = "".obs;

  // pengukuran kesehatan
  StreamSubscription<List<int>>? subscription;
  BluetoothCharacteristic? targetCharacteristic;
  RxBool isLoading = false.obs;
  RxList<double> hasilPengukuran = <double>[].obs;

  // menyambungkan ke perangkat
  Future<void> checkBluetoothDevice(BuildContext context) async {
    // mengecek perizinan penggunaan lokasi
    var bluetoothPermission = await Permission.location.request();
    if (!bluetoothPermission.isGranted) {
      if (context.mounted) {
        AppUtils.confirmDialog(
            context: context,
            title: "Alert !",
            message: "You must enable location premission",
            action: () {
              openAppSettings();
            });
      }
      return;
    }

    // mengecek bluetooth apakah sudah hidup
    BluetoothAdapterState bluetoothState =
        await FlutterBluePlus.adapterState.first;
    if (bluetoothState != BluetoothAdapterState.on) {
      await FlutterBluePlus.turnOn();
    }

    // cari perangkat
    errorMessage.value = "";
    deviceConnected.value = null;
    status.value = Status.LOADING;
    StreamSubscription<List<ScanResult>>? subscription;
    subscription = FlutterBluePlus.onScanResults.listen(
      (results) async {
        if (results.isNotEmpty) {
          ScanResult r = results.last;
          // pengkondisian perangkat
          if (r.device.remoteId.toString() == "48:E7:29:AC:97:BA" &&
              r.device.advName.toString() == "esp32-server") {
            deviceConnected.value = r.device;
          }
        }
      },
      onError: (e) => print(e),
    );
    // pencarian perangkat selaman 4 detik
    await FlutterBluePlus.startScan();
    await Future.delayed(const Duration(seconds: 4));
    await subscription.cancel();
    await FlutterBluePlus.stopScan();

    // jika perangkat ditemukan maka sambungkan
    if (deviceConnected.value != null) {
      // konekti diberikan timeout selama 5 detik, jika lebih maka gagal
      try {
        await deviceConnected.value
            ?.connect(timeout: const Duration(seconds: 5));
        status.value = Status.SUCCESS;
      } catch (e) {
        await disconnectDevice();
        status.value = Status.FAILED;
        print(e);
        errorMessage.value = "Perangkat gagal tersambung !";
      }
      return;
    } else {
      errorMessage.value = "Perangkat tidak ditemukan !";
      status.value = Status.FAILED;
    }
  }

  // mengecek koneksi perangkat dengan esp
  bool checkConnectionDevice() {
    if (deviceConnected.value != null) {
      // mengambil semua perangkat yang terkoneksi dengan aplikasi
      List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
      // mengecek apakah aplikasi terkoneksi dengan perangkat esp32, jika ya maka return true
      return devs
          .where((BluetoothDevice device) =>
              device.remoteId.toString() ==
              deviceConnected.value?.remoteId.toString())
          .toList()
          .isNotEmpty;
    }
    return false;
  }

  // mengambil data pada perangkat esp32 berdasarkan sensor yang digunakan
  Future<void> getDataPerangkat(String sensorName) async {
    try {
      isLoading.value = true;
      // Reads all characteristics
      String charID;
      if (sensorName.toLowerCase() == "oksimeter") {
        charID = "0e1c52dc-6e6f-462d-89ed-9c30d3564ce3";
      } else {
        charID = "7f7cdd10-883b-4611-aa6a-939078035f7d";
      }

      List<BluetoothService> services =
          await deviceConnected.value!.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() == charID) {
            targetCharacteristic = characteristic;
          }
        }
      }

      // jika characteristik tidak ditemukan
      if (targetCharacteristic == null || targetCharacteristic == "") {
        errorMessage.value = "Perangkat tidak dikenali !";
        status.value = Status.FAILED;
        return;
      }

      isLoading.value = false;
      // membaca data dari notify
      subscription = targetCharacteristic!.onValueReceived.listen((value) {
        // menerjemahkan ke dalam bentuk string yang bisa dibaca
        List<dynamic> dataList = jsonDecode(String.fromCharCodes(value));
        List<double> doubleList =
            dataList.map<double>((dynamic item) => item.toDouble()).toList();
        // masukkan ke variable hasilPengukuran
        hasilPengukuran.assignAll(doubleList);
      }, onError: (err) {
        print(err);
      });
      await targetCharacteristic?.setNotifyValue(true);
    } catch (e) {
      errorMessage.value = "Terdapat kesalahan saat mengambil data perangkat !";
      status.value = Status.FAILED;
      print(e);
    }
  }

  Future<void> stopGetDataDevice() async {
    if (checkConnectionDevice()) {
      await subscription?.cancel();
      await targetCharacteristic?.setNotifyValue(false);
    }
    // print(checkConnectionDevice());
    hasilPengukuran.clear();
  }

  // memutuskan perangkat
  Future<void> disconnectDevice() async {
    await deviceConnected.value?.disconnect();
    deviceConnected.value = null;
  }

  // memutuskan semua perangkat
  Future<void> disconnectAllDevices() async {
    List<BluetoothDevice> devs = FlutterBluePlus.connectedDevices;
    for (BluetoothDevice dev in devs) {
      await dev.disconnect();
    }
    deviceConnected.value = null;
  }
}
