import 'package:ble_client/controllers/bluetooth_controller.dart';
import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengecekanController {
  final bluetoothC = Get.put(BluetoothController());
  Rx<Status> statusSaveData = Status.NONE.obs;
  RxString successMessage = "".obs;
  RxString errorMessage = "".obs;

  void clearData() {
    statusSaveData.value = Status.NONE;
    successMessage.value = "";
    errorMessage.value = "";
  }

  Future<void> selesai(
      {required String jenisPerangkat, required BuildContext context}) async {
    await simpanPengecekan(jenisPerangkat: jenisPerangkat, context: context);
    await bluetoothC.stopGetDataDevice();
  }

  Future<void> simpanPengecekan(
      {required String jenisPerangkat, required BuildContext context}) async {
    clearData();
    try {
      statusSaveData.value = Status.LOADING;
      // int durasi = 10;
      var tanggalPengecekan = DateTime.now();
      // var durasiAwal = bluetoothC.durasiAwal.value;
      // // Mendapatkan selisih waktu antara tanggalPengecekan dan durasiAwal
      // Duration difference = tanggalPengecekan.difference(durasiAwal!);
      // durasi = difference.inSeconds;

      var getUser = await UserPreferences.getCurrentUser();
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);
      var dataPengecekan = {
        'tanggal_pengecekan': tanggalPengecekan,
        'jenis_perangkat': jenisPerangkat,
        // 'durasi': durasi,
        'user_id': currentUser.userId,
      };

      // jika oksimeter maka input 2 kali
      if (jenisPerangkat.toLowerCase() == 'oksimeter') {
        if (bluetoothC.hasilPengukuran.length > 1) {
          dataPengecekan['jenis_pengecekan'] = 'Detak Jantung';
          dataPengecekan['nilai'] = bluetoothC.hasilPengukuran[0];
          dataPengecekan['satuan'] = "bpm";
          await FirebaseFirestore.instance
              .collection('pengecekan_kesehatan')
              .add(dataPengecekan)
              .timeout(const Duration(seconds: 10));
          dataPengecekan['jenis_pengecekan'] = 'Saturasi Oksigen';
          dataPengecekan['nilai'] = bluetoothC.hasilPengukuran[1];
          dataPengecekan['satuan'] = "%";
          await FirebaseFirestore.instance
              .collection('pengecekan_kesehatan')
              .add(dataPengecekan)
              .timeout(const Duration(seconds: 10));
        } else {
          bluetoothC.errorMessage.value = "Gagal menyimpan data ke database !";
          bluetoothC.status.value = Status.FAILED;
          return;
        }
        // jika oksimeter maka input saja 1 kali
      } else {
        dataPengecekan['jenis_pengecekan'] = 'Suhu Tubuh';
        dataPengecekan['nilai'] = bluetoothC.hasilPengukuran[0];
        dataPengecekan['satuan'] = "°C";
        await FirebaseFirestore.instance
            .collection('pengecekan_kesehatan')
            .add(dataPengecekan)
            .timeout(const Duration(seconds: 10));
      }
      dataPengecekan.clear();
      // pesan keberhasilan
      successMessage.value = "Data pengukuran berhasil ditambahkan";
      statusSaveData.value = Status.SUCCESS;
      // Get.offNamed(PengecekanKesehatan.routeName);
    } catch (e) {
      statusSaveData.value = Status.FAILED;
      errorMessage.value =
          "Gagal menyimpan data pengecekan, silahkan periksa koneksi internet anda";
      // print(e);
      // print(errorMessage.value);
    }
  }
}
