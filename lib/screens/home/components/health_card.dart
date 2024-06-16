import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HealthCard extends StatelessWidget {
  const HealthCard({
    super.key,
    required this.icon,
    required this.text,
    required this.nilai,
    required this.satuan,
    required this.iconColor,
    required this.bgColor,
    required this.imgUrl,
  });

  final IconData icon;
  final String text;
  final String nilai;
  final String satuan;
  final Color iconColor;
  final Color bgColor;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kTextColor),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          SvgPicture.asset(
            imgUrl,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  nilai,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: kTextColor),
                  overflow:
                      TextOverflow.ellipsis, // Menambahkan properti overflow
                  maxLines: 1, // Menambahkan properti maxLines
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(satuan,
                  style: const TextStyle(fontSize: 20, color: kTextColor)),
            ],
          )
        ],
      ),
    );
  }
}
