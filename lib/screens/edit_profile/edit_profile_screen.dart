import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/components/LoadingScreenComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:ble_client/controllers/profile_controller.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/services/app_service.dart';
import 'package:ble_client/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static String routeName = "/edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final profileC = Get.put(ProfileController());

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Laki-laki", child: Text("Laki-laki")),
      const DropdownMenuItem(value: "Perempuan", child: Text("Perempuan")),
    ];
    return menuItems;
  }

  @override
  void initState() {
    super.initState();
    editProfileState();
  }

  Future<void> editProfileState() async {
    AppService.checkUserAfterLogin();
    await profileC.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: Obx(() {
        if (profileC.status.value == Status.LOADING) {
          return const LoadingScreenComponent();
        }
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Stack(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage("assets/images/avatar.png"),
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
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: profileC.namaPanggilanController.value,
                          focusNode: profileC.namaPanggilanFocusedNode.value,
                          onFieldSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                profileC.namaPanggilanFocusedNode.value,
                                profileC.namaLengkapFocusedNode.value);
                          },
                          decoration: const InputDecoration(
                              labelText: "Nama Panggilan",
                              hintText: "Nama Panggilan"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: profileC.namaLengkapController.value,
                          focusNode: profileC.namaLengkapFocusedNode.value,
                          onFieldSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                profileC.namaLengkapFocusedNode.value,
                                profileC.emailFocusedNode.value);
                          },
                          decoration: const InputDecoration(
                              labelText: "Nama Lengkap",
                              hintText: "Nama Lengkap"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: profileC.emailController.value,
                          focusNode: profileC.emailFocusedNode.value,
                          onFieldSubmitted: (value) {
                            AppUtils.fieldFocusChange(
                                context,
                                profileC.emailFocusedNode.value,
                                profileC.tanggalLahirFocusedNode.value);
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: "Email", hintText: "Email"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          focusNode: profileC.tanggalLahirFocusedNode.value,
                          // controller: profileC.tanggalLahirController.value,
                          decoration: const InputDecoration(
                              labelText: "Tanggal Lahir",
                              hintText: "Tanggal Lahir"),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context),
                                    child: Container(child: child),
                                  );
                                },
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                                locale: const Locale('id'),
                                context: context,
                                initialDate: DateTime.now(), //get today's date
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              profileC.tanggalLahirController.value.text =
                                  formattedDate;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: "Jenis Kelamin",
                            ),
                            value: profileC.jenisKelaminController.value,
                            onChanged: (String? newValue) {
                              profileC.jenisKelaminController.value = newValue!;
                            },
                            items: dropdownItems),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: BtnComponent(
                                action: () {}, text: "Simpan Perubahan")),
                      ],
                    ))
              ],
            ),
          ),
        );
      }),
    ));
  }
}
