import 'package:ble_client/models/detail_kesehatan_model.dart';
import 'package:ble_client/screens/riwayat_kesehatan/components/CardDataKesehatanTerbaru.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailRiwayatKesehatanScreen extends StatefulWidget {
  const DetailRiwayatKesehatanScreen({super.key});

  static String routeName = "/detail_riwayat_kesehatan";

  @override
  State<DetailRiwayatKesehatanScreen> createState() =>
      _DetailRiwayatKesehatanScreenState();
}

class _DetailRiwayatKesehatanScreenState
    extends State<DetailRiwayatKesehatanScreen> {
  final _arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    DetailKesehatanModel dataKesehatan =
        DetailKesehatanModel.fromJson(_arguments['data']);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Riwayat"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 50,
            ),
            Text("Tanggal: ${dataKesehatan.tanggalPengecekan}"),
            Text("Jam: ${dataKesehatan.waktu}"),
            const SizedBox(
              height: 30,
            ),
            if (dataKesehatan.jenisPengecekan!.toLowerCase() ==
                "detak jantung") ...[
              CardDataKesehatanTerbaru(
                  imgUrl: "assets/icons/heart_rate.svg",
                  title: "Detak Jantung",
                  satuanPengukuran: "bpm",
                  nilai: dataKesehatan.nilai!),
            ] else if (dataKesehatan.jenisPengecekan!.toLowerCase() ==
                "saturasi oksigen") ...[
              CardDataKesehatanTerbaru(
                  imgUrl: "assets/icons/blood_oxygen.svg",
                  title: "Saturasi Oksigen",
                  satuanPengukuran: "%",
                  nilai: dataKesehatan.nilai!),
            ] else if (dataKesehatan.jenisPengecekan!.toLowerCase() ==
                "suhu tubuh") ...[
              CardDataKesehatanTerbaru(
                  imgUrl: "assets/icons/termometer.svg",
                  title: "Suhu Tubuh",
                  satuanPengukuran: "⁰C",
                  nilai: dataKesehatan.nilai!),
            ],
          ]),
        ),
      ),
    );
  }
}
