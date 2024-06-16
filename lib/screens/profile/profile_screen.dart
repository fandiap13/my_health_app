import 'package:ble_client/components/BottomNavBar.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/auth_controller.dart';
import 'package:ble_client/controllers/profile_controller.dart';
import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:ble_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:ble_client/screens/profile/widget/CekProfileWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static String routeName = "/profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authC = AuthController();
  final profileC = Get.put(ProfileController());
  String imgUrl = "";
  String namaLengkap = "Loading...";
  String email = "Loading...";

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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
        namaLengkap = currentUser.namaLengkap.toString();
        email = currentUser.email.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pengaturan"),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () => Get.toNamed(EditProfileScreen.routeName),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                  decoration: BoxDecoration(
                      color: kLightGrayColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      if (imgUrl == "") ...[
                        const CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/avatar.png"),
                        ),
                      ] else ...[
                        CircleAvatar(
                          radius: 30,
                          child: ClipOval(
                            child: Image.network(
                              imgUrl,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namaLengkap,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: kDarkColor),
                          ),
                          Text(
                            email,
                            style: const TextStyle(
                                fontSize: 14, color: kTextGrayColor),
                          ),
                        ],
                      ),
                      // const Spacer(),
                      // const Icon(
                      //   Icons.arrow_forward_ios_rounded,
                      //   color: kDarkColor,
                      //   size: 30,
                      // )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                decoration: BoxDecoration(
                    color: kLightGrayColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    CardProfileWidget(
                        title: "Edit Profile",
                        desc: "Ubah foto profile dan email",
                        action: () => Get.toNamed(EditProfileScreen.routeName),
                        color: kBlueColor,
                        icon: Icons.person_rounded),
                    const SizedBox(
                      height: 25,
                    ),
                    // CardProfileWidget(
                    //     title: "Setting Notifikasi",
                    //     desc: "Atur notifikasi anda",
                    //     action: () {},
                    //     color: kBlueColor,
                    //     icon: Icons.notifications_rounded),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    CardProfileWidget(
                        title: "Log Out",
                        desc: "Keluar dari akun",
                        action: () async =>
                            await authC.signOut(context: context),
                        color: kRedColor,
                        icon: Icons.logout_rounded),
                  ],
                ),
              )
            ])),
        bottomNavigationBar: const ButtonNavBar(
          selectedMenu: MenuState.PROFILE,
        ),
      ),
    );
  }
}
