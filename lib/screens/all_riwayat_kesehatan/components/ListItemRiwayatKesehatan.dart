import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class ListItemRiwayatKesehatan extends StatelessWidget {
  const ListItemRiwayatKesehatan({
    super.key,
    required this.action,
  });

  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1.0, color: kTextGrayColor))),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleItem(
                      title: "Saturasi Oksigen Darah",
                      imgUrl: "assets/icons/blood_oxygen.svg",
                      satuanPengukuran: "%",
                      value: 90.0,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TitleItem(
                      title: "Detak Jantung",
                      imgUrl: "assets/icons/heart_rate.svg",
                      satuanPengukuran: "bpm",
                      value: 61.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "22/10/2024",
                      style: TextStyle(color: kTextGrayColor),
                    ),
                    Text(
                      "15:42",
                      style: TextStyle(color: kTextGrayColor),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
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
