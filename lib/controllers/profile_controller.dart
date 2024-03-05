import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  Rx<Status> status = Status.NONE.obs;
  final RxString errorMessage = "".obs;

  // input
  final emailController = TextEditingController().obs;
  final namaPanggilanController = TextEditingController().obs;
  final namaLengkapController = TextEditingController().obs;
  final jenisKelaminController = "Laki-laki".obs;
  final tanggalLahirController = TextEditingController().obs;

  final emailFocusedNode = FocusNode().obs;
  final namaPanggilanFocusedNode = FocusNode().obs;
  final namaLengkapFocusedNode = FocusNode().obs;
  final jenisKelaminFocusedNode = FocusNode().obs;
  final tanggalLahirFocusedNode = FocusNode().obs;

  @override
  void onClose() {
    emailController.close();
    namaPanggilanController.close();
    namaLengkapController.close();
    jenisKelaminController.close();
    tanggalLahirController.close();
    super.onClose();
  }

  void startPage() {
    status.value = Status.NONE;
    errorMessage.value = "";

    emailController.value.text = "";
    namaPanggilanController.value.text = "";
    namaLengkapController.value.text = "";
    tanggalLahirController.value.text = "";
    jenisKelaminController.value = "Laki-laki";
  }

  Future<void> getProfile() async {
    try {
      status.value = Status.LOADING;
      startPage();
      var getUser = await UserPreferences.getCurrentUser();
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);
      var userProfile = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.userId) // Menggunakan documentId yang Anda berikan
          .get()
          .timeout(const Duration(seconds: 5));

      final UserModel userProfileJson =
          UserModel.fromJson(userProfile.data() as Map<String, dynamic>);
      emailController.value.text = userProfileJson.email.toString();
      namaPanggilanController.value.text =
          userProfileJson.namaPanggilan.toString();
      namaLengkapController.value.text = userProfileJson.namaLengkap.toString();
      tanggalLahirController.value.text =
          userProfileJson.tanggalLahir.toString();
      if (userProfileJson.jenisKelamin != "" &&
          userProfileJson.jenisKelamin != null) {
        jenisKelaminController.value = userProfileJson.jenisKelamin.toString();
      }
      status.value = Status.SUCCESS;
    } catch (e) {
      errorMessage.value = "Gagal mengambil data profile !";
      // handle the error here
      print("errornya: $e");
      status.value = Status.FAILED;
    }
  }

  Future<void> saveProfile() async {
    try {
      status.value = Status.LOADING;
      startPage();
      var getUser = await UserPreferences.getCurrentUser();
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);
      var userProfile = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.userId) // Menggunakan documentId yang Anda berikan
          .get()
          .timeout(const Duration(seconds: 5));

      final UserModel userProfileJson =
          UserModel.fromJson(userProfile.data() as Map<String, dynamic>);
      emailController.value.text = userProfileJson.email.toString();
      namaPanggilanController.value.text =
          userProfileJson.namaPanggilan.toString();
      namaLengkapController.value.text = userProfileJson.namaLengkap.toString();
      tanggalLahirController.value.text =
          userProfileJson.tanggalLahir.toString();
      if (userProfileJson.jenisKelamin != "" &&
          userProfileJson.jenisKelamin != null) {
        jenisKelaminController.value = userProfileJson.jenisKelamin.toString();
      }
      status.value = Status.SUCCESS;
    } catch (e) {
      errorMessage.value = "Gagal mengambil data profile !";
      // handle the error here
      print("errornya: $e");
      status.value = Status.FAILED;
    }
  }
}
