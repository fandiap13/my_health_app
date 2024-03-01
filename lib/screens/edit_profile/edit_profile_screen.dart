import 'package:ble_client/components/BtnComponent.dart';
import 'package:ble_client/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static String routeName = "/edit_profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  var selectedValue = "Laki - laki";
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "Laki - laki", child: Text("Laki - laki")),
      const DropdownMenuItem(value: "Perempuan", child: Text("Perempuan")),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: SingleChildScrollView(
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
                        decoration: const InputDecoration(
                            labelText: "Nama Panggilan",
                            hintText: "Nama Panggilan"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: "Nama Lengkap",
                            hintText: "Nama Lengkap"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelText: "Email", hintText: "Email"),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
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
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
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
      ),
    ));
  }
}
