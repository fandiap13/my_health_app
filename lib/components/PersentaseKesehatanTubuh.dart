import 'package:ble_client/constants.dart';
import 'package:ble_client/screens/riwayat_kesehatan/components/CardDataKesehatanTerbaru.dart';
import 'package:flutter/material.dart';

class PersentaseKesehatanTubuh extends StatelessWidget {
  const PersentaseKesehatanTubuh({
    super.key,
    required this.namaParameterKesehatan,
  });

  final String namaParameterKesehatan;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (namaParameterKesehatan.toLowerCase() == "saturasi oksigen") ...[
            const Expanded(
              child: BarWidget(
                  title: "Bahaya - hypoxemia",
                  bgColor: kRedColor,
                  maxValue: 90.0),
            ),
            const Expanded(
              child: BarWidget(
                  title: "Rendah", bgColor: kYellowColor, maxValue: 95.0),
            ),
            const Expanded(
              child: BarWidget(
                title: "Normal",
                bgColor: kGreenColor,
              ),
            ),
          ] else if (namaParameterKesehatan.toLowerCase() ==
              "detak jantung") ...[
            const Expanded(
              child: BarWidget(
                  title: "Rendah", bgColor: kYellowColor, maxValue: 60.0),
            ),
            const Expanded(
              child: BarWidget(
                  title: "Normal", bgColor: kGreenColor, maxValue: 100.0),
            ),
            const Expanded(
              child: BarWidget(
                title: "Tinggi",
                bgColor: kRedColor,
              ),
            ),
          ] else if (namaParameterKesehatan.toLowerCase() == "suhu tubuh") ...[
            const Expanded(
              child: BarWidget(
                  title: "Rendah (Hipotermia)",
                  bgColor: kYellowColor,
                  maxValue: 36.5),
            ),
            const Expanded(
              child: BarWidget(
                  title: "Normal", bgColor: kGreenColor, maxValue: 37.5),
            ),
            const Expanded(
              child: BarWidget(
                title: "Tinggi (Demam)",
                bgColor: kRedColor,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
