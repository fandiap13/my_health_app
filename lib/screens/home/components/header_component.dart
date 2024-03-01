import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:ble_client/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HeaderComponent extends StatefulWidget {
  const HeaderComponent({
    super.key,
  });

  @override
  State<HeaderComponent> createState() => _HeaderComponentState();
}

class _HeaderComponentState extends State<HeaderComponent> {
  String namaPanggilan = "User";
  Future<void> fetchData() async {
    var getUser = await UserPreferences.getCurrentUser();
    if (getUser != null) {
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);
      setState(() {
        namaPanggilan = currentUser.namaPanggilan.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => fetchData());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(ProfileScreen.routeName),
              child: const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Halo, $namaPanggilan !",
              style: const TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 20, color: kTextColor),
            ),
          ],
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: Stack(
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
              ),
            )
          ],
        )
      ],
    );
  }
}
