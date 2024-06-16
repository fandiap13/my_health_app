import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ListItemRiwayatKesehatan extends StatelessWidget {
  const ListItemRiwayatKesehatan({
    super.key,
    required this.action,
    required this.jenisPengecekan,
    required this.value,
    required this.tanggal,
    required this.waktu,
  });

  final VoidCallback action;
  final String jenisPengecekan;
  final String tanggal;
  final String waktu;
  final double value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.0, color: kTextGrayColor))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (jenisPengecekan.toLowerCase() == "detak jantung") ...[
                      TitleItem(
                        title: "Detak Jantung",
                        imgUrl: "assets/icons/heart_rate.svg",
                        satuanPengukuran: "bpm",
                        value: value,
                      ),
                    ] else if (jenisPengecekan.toLowerCase() ==
                        "saturasi oksigen") ...[
                      TitleItem(
                        title: "Saturasi Oksigen Darah",
                        imgUrl: "assets/icons/blood_oxygen.svg",
                        satuanPengukuran: "%",
                        value: value,
                      ),
                    ] else if (jenisPengecekan.toLowerCase() ==
                        "suhu tubuh") ...[
                      TitleItem(
                        title: "Suhu Tubuh",
                        imgUrl: "assets/icons/termometer.svg",
                        satuanPengukuran: "°C",
                        value: value,
                      ),
                    ]
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      tanggal,
                      style: const TextStyle(color: kTextGrayColor),
                    ),
                    Text(
                      waktu,
                      style: const TextStyle(color: kTextGrayColor),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class TitleItem extends StatelessWidget {
  const TitleItem({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.satuanPengukuran,
    required this.value,
  });

  final String imgUrl, title, satuanPengukuran;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: SvgPicture.asset(
            imgUrl,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: kTextColor),
            ),
            Text(
              "${value.toString()} $satuanPengukuran",
              style: const TextStyle(
                color: kGreenColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
