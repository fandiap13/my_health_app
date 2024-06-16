import 'package:ble_client/components/EmptyComponent.dart';
import 'package:ble_client/components/ErrorMessageComponent.dart';
import 'package:ble_client/components/LoadingScreenComponent.dart';
import 'package:ble_client/controllers/riwayat_kesehatan_controller.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/models/detail_kesehatan_model.dart';
import 'package:ble_client/screens/all_riwayat_kesehatan/components/ListItemRiwayatKesehatan.dart';
import 'package:ble_client/screens/detail_riwayat_kesehatan/detail_riwayat_kesehatan_screen.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/riwayat_kesehatan/riwayat_kesehatan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllRiwayatKesehatanScreen extends StatefulWidget {
  const AllRiwayatKesehatanScreen({super.key});

  static String routeName = "/all_riwayat_kesehatan";

  @override
  State<AllRiwayatKesehatanScreen> createState() =>
      _AllRiwayatKesehatanScreenState();
}

class _AllRiwayatKesehatanScreenState extends State<AllRiwayatKesehatanScreen> {
  var arguments = Get.arguments;
  final _riwayatKesehatanC = Get.put(RiwayatKesehatanController());

  @override
  void initState() {
    super.initState();
    _screenInit();
  }

  Future<void> _screenInit() async {
    await _riwayatKesehatanC.getAllHistoryKesehatan(
        jenisPerangkat: arguments['jenis_perangkat'],
        jenisPengecekan: arguments['jenis_pengecekan']);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(RiwayatkesehatanScreen.routeName, arguments: arguments);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Semua Riwayat (${arguments['jenis_pengecekan']})"),
          ),
          body: Obx(() {
            if (_riwayatKesehatanC.status.value == Status.LOADING) {
              return const LoadingScreenComponent();
            }

            if (_riwayatKesehatanC.status.value == Status.FAILED) {
              return ErrorMessageComponent(
                  errorMessage: "Terdapat Kesalahan Pada Sistem!",
                  action: () {
                    _riwayatKesehatanC.status.value = Status.NONE;
                    Get.toNamed(HomeScreen.routeName);
                  });
            }

            if (_riwayatKesehatanC.dataHistoryKesehatan.isEmpty) {
              return const Center(
                child: EmptyComponent(
                  title: "Riwayat kesehatan kosong...",
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async => await _screenInit(),
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      ..._riwayatKesehatanC.dataHistoryKesehatan.map((riwayat) {
                        DetailKesehatanModel dataKesehatan =
                            DetailKesehatanModel.fromJson(riwayat.data());

                        return ListItemRiwayatKesehatan(
                          jenisPengecekan: arguments['jenis_pengecekan'],
                          value: dataKesehatan.nilai as double,
                          tanggal: dataKesehatan.tanggalPengecekan.toString(),
                          waktu: dataKesehatan.waktu.toString(),
                          action: () => Get.toNamed(
                              DetailRiwayatKesehatanScreen.routeName,
                              arguments: {
                                ...arguments,
                                'data': riwayat.data(),
                              }),
                          key: UniqueKey(),
                        );
                      }).toList(),
                    ],
                  )),
            );
          }),
        ),
      ),
    );
  }
}
