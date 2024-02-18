import 'package:ble_client/constants.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/screen/home/home_screen.dart';
import 'package:ble_client/screen/pengecekan_kesehatan/pengecekan_kesehatan_screen.dart';
import 'package:ble_client/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ButtonNavBar extends StatelessWidget {
  const ButtonNavBar({
    super.key,
    required this.selectedMenu,
  });

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kBlueColor, borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavButton(
            icon: Icons.home_rounded,
            active: selectedMenu == MenuState.HOME,
            action: () => Get.toNamed(HomeScreen.routeName),
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
              size: 35,
            ),
            if (active) ...[
              const SizedBox(
                height: 10,
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
