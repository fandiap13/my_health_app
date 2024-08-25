import 'package:ble_client/components/PersentaseKesehatanTubuh.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardDataKesehatanTerbaru extends StatelessWidget {
  const CardDataKesehatanTerbaru({
    super.key,
    required this.imgUrl,
    required this.title,
    this.tanggal,
    this.jam,
    required this.satuanPengukuran,
    required this.nilai,
  });

  final String imgUrl, title, satuanPengukuran;
  final String? tanggal, jam;
  final double nilai;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: kTextGrayColor, width: 1.0))),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: kTextGrayColor, width: 1.0))),
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  children: [
                    SvgPicture.asset(
                      imgUrl,
                      height: 40,
                      width: 40,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: kTextColor,
                          fontSize: 12),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (tanggal != null)
                    Text(
                      tanggal.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: kTextColor),
                    ),
                  if (jam != null)
                    Text(
                      jam.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: kTextGrayColor),
                    ),
                  Row(
                    children: [
                      Text(
                        nilai.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 32,
                            color: AppUtils.presentaseKesehatanValue(
                                        value: nilai,
                                        pengecekanKesehatan: title) ==
                                    PresentaseValueState.NORMAL
                                ? kGreenColor
                                : AppUtils.presentaseKesehatanValue(
                                            value: nilai,
                                            pengecekanKesehatan: title) ==
                                        PresentaseValueState.HIGH
                                    ? kRedColor
                                    : kYellowColor),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        satuanPengukuran,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppUtils.presentaseKesehatanValue(
                                        value: nilai,
                                        pengecekanKesehatan: title) ==
                                    PresentaseValueState.NORMAL
                                ? kGreenColor
                                : AppUtils.presentaseKesehatanValue(
                                            value: nilai,
                                            pengecekanKesehatan: title) ==
                                        PresentaseValueState.HIGH
                                    ? kRedColor
                                    : kYellowColor),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        // persentase bar chart (horizontal)
        const SizedBox(
          height: 10,
        ),
        PersentaseKesehatanTubuh(
          namaParameterKesehatan: title,
        )
      ],
    );
  }
}

class BarWidget extends StatelessWidget {
  const BarWidget({
    super.key,
    required this.title,
    required this.bgColor,
    this.maxValue,
  });

  final String title;
  final Color bgColor;
  final double? maxValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 10, color: kTextColor),
        ),
        const SizedBox(
          height: 5,
        ),
        if (maxValue != null) ...[
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: bgColor,
                  ),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 2,
                    height: 15,
                    decoration: const BoxDecoration(color: kDarkColor),
                  ),
                  Positioned(bottom: -20, child: Text(maxValue.toString()))
                ],
              ),
            ],
          ),
        ] else ...[
          Container(
            height: 10,
            decoration: BoxDecoration(
              color: bgColor,
            ),
          ),
        ]
      ],
    );
  }
}
