import 'package:ble_client/components/BackButton.dart';
import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/screens/pengecekan_kesehatan/pengecekan_kesehatan_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PengaturanPerangkatScreen extends StatefulWidget {
  const PengaturanPerangkatScreen({super.key});
  static String routeName = "/pengaturan_perangkat";

  @override
  State<PengaturanPerangkatScreen> createState() =>
      _PengaturanPerangkatScreenState();
}

class _PengaturanPerangkatScreenState extends State<PengaturanPerangkatScreen> {
  final _keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: kBgGray,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40.0,
              ),
              BackButtonComponent(
                  action: () => Get.offNamed(PengecekanKesehatan.routeName)),
              const SizedBox(
                height: 50.0,
              ),
              const Text(
                "Pengaturan Perangkat",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
              ),
              const SizedBox(
                height: 25.0,
              ),
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/device_img.png"),
                      radius: 65,
                    ),
                    Positioned(
                        bottom: 5,
                        right: 5,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: kDarkColor, shape: BoxShape.circle),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Form(
                    key: _keyForm,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: "ID Perangkat",
                              label: Text("ID Perangkat")),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              hintText: "Nama Perangkat",
                              label: Text("Nama Perangkat")),
                        ),
                        const Spacer(),
                        SizedBox(
                            width: double.infinity,
                            child: BtnComponent(
                                action: () {}, text: "Simpan Perubahan")),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
