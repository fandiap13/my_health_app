import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';

class CardProfileWidget extends StatelessWidget {
  const CardProfileWidget({
    super.key,
    required this.color,
    required this.action,
    required this.title,
    required this.desc,
    required this.icon,
  });

  final Color color;
  final VoidCallback action;
  final String title;
  final String desc;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w500, color: color),
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 14, color: kTextGrayColor),
              )
            ],
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: color,
            size: 30,
          )
        ],
      ),
    );
  }
}
