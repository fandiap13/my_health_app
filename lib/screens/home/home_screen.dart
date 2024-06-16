import 'package:ble_client/components/BottomNavBar.dart';
import 'package:ble_client/components/EmptyComponent.dart';
import 'package:ble_client/components/ErrorMessageComponent.dart';
import 'package:ble_client/components/LoadingScreenComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/home_controller.dart';
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
  final homeC = Get.put(HomeController());

  @override
  void initState() {
    Future.delayed(Duration.zero, () => init());
    super.initState();
  }

  Future<void> init() async {
    await AppService.checkUserAfterLogin();
    await homeC.getLatestHealthData();
  }

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AppUtils.confirmDialog(
            context: context,
            title: "Keluar",
            message: "Apakah anda ingin keluar dari aplikasi ?",
            action: () async {
              // await Get.offNamed(SignInScreen.routeName);
              SystemNavigator.pop();
            });
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              body: Obx(() {
                if (homeC.status.value == Status.LOADING) {
                  return const LoadingScreenComponent();
                }

                if (homeC.status.value == Status.FAILED) {
                  return ErrorMessageComponent(
                      errorMessage: homeC.errorMessage.value,
                      action: () async => await homeC.getLatestHealthData());
                }

                return RefreshIndicator(
                  onRefresh: () async => await homeC.getLatestHealthData(),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Pengecekan Terakhir",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: kTextColor),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          final dynamic tooltip =
                                              _key.currentState;
                                          tooltip.ensureTooltipVisible();
                                        },
                                        icon: Tooltip(
                                          key: _key,
                                          message:
                                              'Menampilkan data pengecekan kesehatan terbaru',
                                          child: const Icon(
                                            Icons.info_rounded,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25.0,
                                  ),
                                  Builder(builder: (context) {
                                    if (homeC.detakJantungTerbaru.isEmpty &&
                                        homeC.oksigenDarahTerbaru.isEmpty &&
                                        homeC.suhuTubuhTerbaru.isEmpty) {
                                      return const Center(
                                        child: EmptyComponent(),
                                      );
                                    }

                                    return Column(
                                      children: [
                                        Row(
                                          children: [
                                            if (homeC.detakJantungTerbaru
                                                .isNotEmpty) ...[
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () => Get.toNamed(
                                                      RiwayatkesehatanScreen
                                                          .routeName,
                                                      arguments: {
                                                        'jenis_perangkat':
                                                            'Oksimeter',
                                                        'jenis_pengecekan':
                                                            'Detak Jantung',
                                                      }),
                                                  child: HealthCard(
                                                    icon: Icons
                                                        .monitor_heart_rounded,
                                                    text: "Detak Jantung",
                                                    nilai: homeC
                                                        .detakJantungTerbaru[
                                                            'nilai']
                                                        .toString(),
                                                    satuan: "bpm",
                                                    bgColor: kLightRedColor,
                                                    iconColor: kRedColor,
                                                    imgUrl:
                                                        "assets/icons/heart_rate.svg",
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 20.0,
                                              ),
                                            ],
                                            if (homeC.oksigenDarahTerbaru
                                                .isNotEmpty) ...[
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () => Get.toNamed(
                                                      RiwayatkesehatanScreen
                                                          .routeName,
                                                      arguments: {
                                                        'jenis_perangkat':
                                                            'Oksimeter',
                                                        'jenis_pengecekan':
                                                            'Saturasi Oksigen',
                                                      }),
                                                  child: HealthCard(
                                                    icon:
                                                        Icons.bloodtype_rounded,
                                                    text: "Saturasi Oksigen",
                                                    nilai: homeC
                                                        .oksigenDarahTerbaru[
                                                            'nilai']
                                                        .toString(),
                                                    satuan: "%",
                                                    bgColor: kLightBlueColor,
                                                    iconColor: kBlueColor,
                                                    imgUrl:
                                                        "assets/icons/blood_oxygen.svg",
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        if (homeC
                                            .suhuTubuhTerbaru.isNotEmpty) ...[
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: GestureDetector(
                                              onTap: () => Get.toNamed(
                                                  RiwayatkesehatanScreen
                                                      .routeName,
                                                  arguments: {
                                                    'jenis_perangkat':
                                                        'Termometer',
                                                    'jenis_pengecekan':
                                                        'Suhu Tubuh',
                                                  }),
                                              child: HealthCard(
                                                icon: Icons.thermostat,
                                                text: "Suhu Tubuh",
                                                nilai: homeC
                                                    .suhuTubuhTerbaru['nilai']
                                                    .toString(),
                                                satuan: "Celcius",
                                                bgColor: kLightGreenColor,
                                                iconColor: kGreenColor,
                                                imgUrl:
                                                    "assets/icons/termometer.svg",
                                              ),
                                            ),
                                          ),
                                        ]
                                      ],
                                    );
                                  }),
                                ]),
                          ],
                        )),
                  ),
                );
              }),
              bottomNavigationBar: Obx(
                () => Visibility(
                  visible: homeC.status.value != Status.LOADING,
                  child: const ButtonNavBar(
                    selectedMenu: MenuState.HOME,
                  ),
                ),
              ))),
    );
  }
}
