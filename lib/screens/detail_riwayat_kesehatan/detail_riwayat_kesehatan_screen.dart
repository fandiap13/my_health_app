import 'package:ble_client/screens/riwayat_kesehatan/components/CardDataKesehatanTerbaru.dart';
import 'package:flutter/material.dart';

class DetailRiwayatKesehatanScreen extends StatelessWidget {
  const DetailRiwayatKesehatanScreen({super.key});

  static String routeName = "/detail_riwayat_kesehatan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Riwayat"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text("Tanggal: Senin, 22/10/2024"),
              Text("Jam: 12:20"),
              SizedBox(
                height: 30,
              ),
              CardDataKesehatanTerbaru(
                  imgUrl: "assets/icons/blood_oxygen.svg",
                  title: "Saturasi Oksigen",
                  satuanPengukuran: "%",
                  nilai: 90.5),
              SizedBox(
                height: 30,
              ),
              CardDataKesehatanTerbaru(
                  imgUrl: "assets/icons/heart_rate.svg",
                  title: "Detak Jantung",
                  satuanPengukuran: "bpm",
                  nilai: 60),
            ]),
      ),
    );
  }
}
