import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/bluetooth_controller.dart';
import 'package:ble_client/screens/pengecekan_kesehatan/pengecekan_kesehatan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HasilPengecekanScreen extends StatefulWidget {
  const HasilPengecekanScreen({
    super.key,
  });
  static String routeName = "/hasil_pengecekan_screen";

  @override
  State<HasilPengecekanScreen> createState() => _HasilPengecekanScreenState();
}

class _HasilPengecekanScreenState extends State<HasilPengecekanScreen> {
  final bluetoothC = Get.put(BluetoothController());
  final Map argument = Get.arguments;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      bluetoothC.getDataPerangkat(argument['title']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await bluetoothC.stopGetDataDevice();
        Get.offNamed(PengecekanKesehatan.routeName);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              argument['title'],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.asset(
                        argument['imgUrl'],
                        fit: BoxFit.contain,
                      )),
                ),
                const SizedBox(
                  height: 40,
                ),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (argument['title'].toLowerCase() == "oksimeter") ...[
                        Expanded(
                          child: CardHasilPengecekan(
                              title: "Saturasi Oksigen",
                              satuanNilai: "%",
                              value: bluetoothC.hasilPengukuran.isEmpty
                                  ? 0.0
                                  : bluetoothC.hasilPengukuran[0],
                              isLoading: bluetoothC.isLoading.value),
                        ),
                        Expanded(
                          child: CardHasilPengecekan(
                              title: "Detak Jantung",
                              satuanNilai: "bpm",
                              value: bluetoothC.hasilPengukuran.isEmpty
                                  ? 0.0
                                  : bluetoothC.hasilPengukuran[1],
                              isLoading: bluetoothC.isLoading.value),
                        ),
                      ] else ...[
                        Expanded(
                          child: CardHasilPengecekan(
                              title: "Suhu tubuh",
                              satuanNilai: "°C",
                              value: bluetoothC.hasilPengukuran.isEmpty
                                  ? 0.0
                                  : bluetoothC.hasilPengukuran[0],
                              isLoading: bluetoothC.isLoading.value),
                        ),
                      ]
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                    width: double.infinity,
                    child: BtnComponent(
                        action: () async {
                          await bluetoothC.stopGetDataDevice();
                          Get.offNamed(PengecekanKesehatan.routeName);
                        },
                        text: "Selesai")),
                const SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardHasilPengecekan extends StatelessWidget {
  const CardHasilPengecekan({
    super.key,
    required this.isLoading,
    required this.value,
    required this.title,
    required this.satuanNilai,
  });

  final bool isLoading;
  final double value;
  final String title;
  final String satuanNilai;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            if (isLoading) ...[
              const CircularProgressIndicator(
                color: kBlueColor,
              )
            ] else ...[
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kTextColor),
              ),
              const SizedBox(
                height: 10,
              ),
              IntrinsicWidth(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "${value.toString()} ",
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: kBlueColor),
                    ),
                    Expanded(
                      child: Text(
                        satuanNilai,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 18,
                            color: kBlueColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
