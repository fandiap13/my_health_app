import 'package:ble_client/components/BackButton.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/bluetooth_controller.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/panduan_pengecekan/panduan_pengecekan_screen.dart';
import 'package:ble_client/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectedDeviceComponent extends StatefulWidget {
  const ConnectedDeviceComponent({super.key});

  @override
  State<ConnectedDeviceComponent> createState() =>
      _ConnectedDeviceComponentState();
}

class _ConnectedDeviceComponentState extends State<ConnectedDeviceComponent> {
  final bluetootC = Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBgGray,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40.0,
          ),
          BackButtonComponent(action: () => Get.offNamed(HomeScreen.routeName)),
          const SizedBox(
            height: 50.0,
          ),
          const Text(
            "Pengecekan Kesehatan",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
          ),
          const SizedBox(
            height: 25.0,
          ),
          Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: 80,
                                  height: 80,
                                  clipBehavior: Clip.none,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    "assets/images/device_img.png",
                                  )),
                              const SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Perangkat Kesehatan",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: kDarkColor),
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      bluetootC.myDeviceName,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: kBlueColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Row(
                                      children: [
                                        Text(
                                          "Terhubung",
                                          style: TextStyle(
                                              fontSize: 14, color: kDarkColor),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.link_rounded,
                                          color: kGreenColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () async {
                            return AppUtils.confirmDialog(
                                context: context,
                                title: "Disconnect device",
                                message:
                                    "Apakah anda yakin ingin memutuskan perangkat ?",
                                action: () async =>
                                    await bluetootC.disconnectDevice());
                          },
                          child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                  color: kGreenColor, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.link_off_rounded,
                                size: 25,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    DeviceCard(
                      title: "Oksimeter",
                      imgUrl: "assets/images/oksimeter.png",
                      action: () {
                        Get.toNamed(PanduanPengecekanScreen.routeName,
                            arguments: {
                              "imgUrl": "assets/images/oksimeter.png",
                              "title": "Oksimeter",
                            });
                      },
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    DeviceCard(
                      title: "Termometer",
                      imgUrl: "assets/images/termometer.png",
                      action: () {
                        Get.toNamed(PanduanPengecekanScreen.routeName,
                            arguments: {
                              "imgUrl": "assets/images/termometer.png",
                              "title": "Termometer",
                            });
                      },
                    ),
                    // const SizedBox(
                    //   height: 80.0,
                    // ),
                  ],
                ),
              ),
              // Positioned(
              //     bottom: 0,
              //     right: 0,
              //     left: 0,
              //     child: GestureDetector(
              //       onTap: () =>
              //           Get.toNamed(PengaturanPerangkatScreen.routeName),
              //       child: Container(
              //         padding: const EdgeInsets.symmetric(vertical: 20),
              //         decoration: const BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //                 bottomLeft: Radius.circular(40),
              //                 bottomRight: Radius.circular(40)),
              //             color: kBlueColor),
              //         child: const Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 Icons.settings,
              //                 color: Colors.white,
              //               ),
              //               SizedBox(
              //                 width: 5.0,
              //               ),
              //               Text(
              //                 "Pengaturan Perangkat",
              //                 style: TextStyle(
              //                     fontWeight: FontWeight.w500,
              //                     fontSize: 18,
              //                     color: Colors.white),
              //               )
              //             ]),
              //       ),
              //     ))
            ],
          ),
        ],
      ),
    );
  }
}

class DeviceCard extends StatelessWidget {
  const DeviceCard({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.action,
  });

  final String imgUrl;
  final String title;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            color: kLightBlueColor, borderRadius: BorderRadius.circular(20)),
        child: ListTile(
          leading: Image.asset(imgUrl),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 50,
            color: kBlueColor,
          ),
        ),
      ),
    );
  }
}
