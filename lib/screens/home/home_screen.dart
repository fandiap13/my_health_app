import 'package:ble_client/components/BottomNavBar.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/screens/home/components/header_component.dart';
import 'package:ble_client/screens/home/components/health_card.dart';
import 'package:ble_client/screens/riwayat_kesehatan/riwayat_kesehatan_screen.dart';
import 'package:ble_client/screens/sign_in/sign_in_screen.dart';
import 'package:ble_client/services/app_service.dart';
import 'package:ble_client/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "/home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    AppService.checkUserAfterLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cek = false;

    return WillPopScope(
      onWillPop: () async {
        AppUtils.confirmDialog(
            context: context,
            title: "Keluar",
            message: "Apakah anda ingin keluar dari aplikasi ?",
            action: () async {
              // SystemNavigator.pop();
              // print("kontrol");
              await Get.offNamed(SignInScreen.routeName);
            });
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40.0,
                        ),
                        const HeaderComponent(),
                        const SizedBox(
                          height: 70.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Pengecekan Terakhir",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: kTextColor),
                            ),
                            const SizedBox(
                              height: 25.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => Get.toNamed(
                                        RiwayatkesehatanScreen.routeName),
                                    child: const HealthCard(
                                      icon: Icons.monitor_heart_rounded,
                                      text: "Detak Jantung",
                                      nilai: "130",
                                      satuan: "bpm",
                                      bgColor: kLightRedColor,
                                      iconColor: kRedColor,
                                      imgUrl: "assets/icons/heart_rate.svg",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => Get.toNamed(
                                        RiwayatkesehatanScreen.routeName),
                                    child: const HealthCard(
                                      icon: Icons.bloodtype_rounded,
                                      text: "Saturasi Oksigen",
                                      nilai: "90",
                                      satuan: "%",
                                      bgColor: kLightBlueColor,
                                      iconColor: kBlueColor,
                                      imgUrl: "assets/icons/blood_oxygen.svg",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () => Get.toNamed(
                                    RiwayatkesehatanScreen.routeName),
                                child: const HealthCard(
                                  icon: Icons.thermostat,
                                  text: "Suhu Tubuh",
                                  nilai: "34",
                                  satuan: "Celcius",
                                  bgColor: kLightGreenColor,
                                  iconColor: kGreenColor,
                                  imgUrl: "assets/icons/termometer.svg",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              bottomNavigationBar: Visibility(
                visible: !cek,
                child: const ButtonNavBar(
                  selectedMenu: MenuState.HOME,
                ),
              ))),
    );
  }
}
