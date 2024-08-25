import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/profile_controller.dart';
import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:ble_client/screens/edit_profile/edit_profile_screen.dart';
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
  final profileC = Get.put(ProfileController());
  String imgUrl = "";
  String namaPanggilan = "Loading...";
  String email = "Loading...";

  Future<void> getCurrentUser() async {
    var getUser = await UserPreferences.getCurrentUser();
    if (getUser != null) {
      var getDataProfile = await profileC.getDataProfile();
      // print(getDataProfile.data());
      final UserModel currentUser =
          UserModel.fromJson(getDataProfile.data() as Map<String, dynamic>);
      // print(currentUser.profileImage);
      setState(() {
        if (currentUser.profileImage != null) {
          imgUrl = currentUser.profileImage.toString();
        }
        namaPanggilan = currentUser.namaPanggilan.toString();
        email = currentUser.email.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => getCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed(EditProfileScreen.routeName),
                child: imgUrl == ""
                    ? const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage("assets/images/avatar.png"),
                      )
                    : CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.network(
                            imgUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  "Halo, $namaPanggilan",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: kTextColor),
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              ),
            ],
          ),
        ),
        // Row(
        //   children: [
        //     GestureDetector(
        //       onTap: () {},
        //       child: Stack(
        //         clipBehavior: Clip.none,
        //         children: [
        //           Container(
        //             padding: const EdgeInsets.all(15),
        //             decoration: const BoxDecoration(
        //                 color: kLightGrayColor, shape: BoxShape.circle),
        //             child: SvgPicture.asset(
        //               "assets/icons/notify.svg",
        //               width: 25,
        //               height: 25,
        //               fit: BoxFit.contain,
        //             ),
        //           ),
        //           Positioned(
        //             top: -5,
        //             right: -5,
        //             child: Container(
        //               padding: const EdgeInsets.all(10),
        //               decoration: const BoxDecoration(
        //                   color: kLightRedColor, shape: BoxShape.circle),
        //               child: const Text(
        //                 "1",
        //                 style: TextStyle(
        //                     fontSize: 10,
        //                     fontWeight: FontWeight.bold,
        //                     color: kTextColor),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     )
        //   ],
        // )
      ],
    );
  }
}
