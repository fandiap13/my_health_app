import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/screens/hasil_pengecekan/hasil_pengecekan_screen.dart';
import 'package:ble_client/screens/panduan_pengecekan/components/splash_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanduanPengecekanScreen extends StatefulWidget {
  const PanduanPengecekanScreen({super.key});

  static String routeName = "/panduan_pengecekan";

  @override
  State<PanduanPengecekanScreen> createState() =>
      _PanduanPengecekanScreenState();
}

class _PanduanPengecekanScreenState extends State<PanduanPengecekanScreen> {
  final Map argument = Get.arguments;

  int currentPage = 0;
  List<Map<String, dynamic>> splashData = [];

  @override
  void initState() {
    super.initState();
    late List<Map<String, dynamic>> data;
    if (argument['title'].toLowerCase() == "oksimeter") {
      data = [
        {
          "text": "Hidupkan perangkat pengecekan kesehatan",
          "image": null,
        },
        {
          "text":
              "Hidupkan bluetooth pada smartphone untuk menyambungkan aplikasi ke perangkat pengecekan kesehatan",
          "image": "assets/images/device_img.png"
        },
        {
          "text":
              "Tempatkan pulse oksimeter pada jari telunjuk atau jari tengah Anda dan pastikan jari Anda bersih dan kering",
          "image": "assets/images/device_img.png"
        },
        {
          "text":
              "Tekan tombol “Mulai Pengukuran” untuk mendapatkan hasil pengukuran denyut jantung (bpm) dan oksigen darah (%)",
          "image": "assets/images/device_img.png"
        },
      ];
    }
    if (argument['title'].toLowerCase() == "termometer") {
      data = [
        {
          "text": "Hidupkan perangkat pengecekan kesehatan",
          "image": null,
        },
        {
          "text":
              "Hidupkan bluetooth pada smartphone untuk menyambungkan aplikasi ke perangkat pengecekan kesehatan",
          "image": "assets/images/device_img.png"
        },
        {
          "text":
              "Tekan tombol “Mulai Pengukuran” untuk mendapatkan hasil pengukuran suhu tubuh (C)",
          "image": "assets/images/device_img.png"
        },
        {
          "text":
              "Arahkan termometer di dahi atau telapak tangan pada jarak sekitar 3-5 cm",
          "image": "assets/images/device_img.png"
        },
      ];
    }

    setState(() {
      splashData.addAll(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Panduan ${argument['title']}",
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      itemCount: splashData.length,
                      itemBuilder: (context, index) => SplashContent(
                            image: splashData[index]['image'],
                            text: splashData[index]['text'].toString(),
                          ))),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: <Widget>[
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(splashData.length,
                              (index) => buildDot(index: index)),
                        ),
                        const Spacer(),
                        SizedBox(
                            width: double.infinity,
                            child: BtnComponent(
                                // btnColor: kYellowColor,
                                action: () {
                                  Get.toNamed(HasilPengecekanScreen.routeName,
                                      arguments: {
                                        "imgUrl": argument['imgUrl'],
                                        "title": argument['title'],
                                      });
                                },
                                text: "Mulai Pengukuran")),
                        const SizedBox(
                          height: 60,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentPage == index ? kBlueColor : const Color(0xffd8d8d8),
          borderRadius: BorderRadius.circular(3)),
    );
  }
}
