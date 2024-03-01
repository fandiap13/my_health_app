import 'package:ble_client/screens/all_riwayat_kesehatan/components/ListItemRiwayatKesehatan.dart';
import 'package:ble_client/screens/detail_riwayat_kesehatan/detail_riwayat_kesehatan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllRiwayatKesehatanScreen extends StatelessWidget {
  const AllRiwayatKesehatanScreen({super.key});

  static String routeName = "/all_riwayat_kesehatan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semua Riwayat"),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          ListItemRiwayatKesehatan(
              action: () =>
                  Get.toNamed(DetailRiwayatKesehatanScreen.routeName)),
          ListItemRiwayatKesehatan(
              action: () =>
                  Get.toNamed(DetailRiwayatKesehatanScreen.routeName)),
          ListItemRiwayatKesehatan(
              action: () =>
                  Get.toNamed(DetailRiwayatKesehatanScreen.routeName)),
        ],
      )),
    );
  }
}
