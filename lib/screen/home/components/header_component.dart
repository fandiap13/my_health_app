import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderComponent extends StatelessWidget {
  const HeaderComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage("assets/images/avatar.png"),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              "Halo, Fandi !",
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 20, color: kTextColor),
            ),
          ],
        ),
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                      color: kLightGrayColor, shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    "assets/icons/notify.svg",
                    width: 25,
                    height: 25,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: kLightRedColor, shape: BoxShape.circle),
                    child: const Text(
                      "1",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: kTextColor),
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
