import 'package:ble_client/constants.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/pengecekan_kesehatan/pengecekan_kesehatan_screen.dart';
import 'package:ble_client/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({
    super.key,
    required this.selectedMenu,
    this.bgColor,
  });

  final MenuState selectedMenu;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor ?? Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
            color: kBlueColor, borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NavButton(
              icon: Icons.home_rounded,
              active: selectedMenu == MenuState.HOME,
              action: () {
                // AppUtils.scaffoldMessage(message: "cek aja", context: context);
                // AppUtils.toastMessage(message: "cek aja");
                Get.toNamed(HomeScreen.routeName);
              },
            ),
            NavButton(
              icon: Icons.medical_services_rounded,
              active: selectedMenu == MenuState.PENGECEKAN_KESEHATAN,
              action: () => Get.toNamed(PengecekanKesehatan.routeName),
            ),
            NavButton(
              icon: Icons.person_rounded,
              active: selectedMenu == MenuState.PROFILE,
              action: () => Get.toNamed(ProfileScreen.routeName),
            ),
          ],
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  const NavButton({
    super.key,
    required this.active,
    required this.icon,
    required this.action,
  });

  final bool active;
  final IconData icon;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Icon(
              icon,
              color: !active ? Colors.white.withOpacity(0.5) : Colors.white,
              size: 30,
            ),
            if (active) ...[
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
              )
            ]
          ],
        ),
      ),
    );
  }
}
