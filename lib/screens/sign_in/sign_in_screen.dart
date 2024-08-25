import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/auth_controller.dart';
import 'package:ble_client/services/app_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static String routeName = "/";

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final authC = AuthController();

  @override
  void initState() {
    AppService.checkUserBeforeLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 80,
                  height: 80,
                  child: SvgPicture.asset(
                    "assets/images/logo.svg",
                    fit: BoxFit.contain,
                  )),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Selamat Datang Kembali",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: kTextColor),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Ayo, mulai hari ini dengan langkah sehat! Login sekarang untuk akses penuh ke aplikasi kesehatan.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: kTextGrayColor),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                    style: ButtonStyle(
                        padding: const MaterialStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 20, horizontal: 25)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                        backgroundColor:
                            const MaterialStatePropertyAll(kLightBlueColor),
                        elevation: const MaterialStatePropertyAll(0)),
                    onPressed: () async {
                      // Get.offNamed(HomeScreen.routeName)
                      if (authC.isLoading.isFalse) {
                        await authC.signInWithGoogle(context: context);
                      }
                    },
                    icon: SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                          "assets/icons/google.png",
                          fit: BoxFit.contain,
                        )),
                    label: const Text(
                      "Login with google",
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
              ),
              Obx(() => Visibility(
                    visible: authC.errorMessage.value != "",
                    child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 30),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: kLightRedColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.warning_amber_rounded),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                authC.errorMessage.value,
                                style: const TextStyle(color: kTextColor),
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            GestureDetector(
                              onTap: () => authC.errorMessage.value = "",
                              child: const Icon(Icons.close_rounded),
                            )
                          ],
                        )),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
