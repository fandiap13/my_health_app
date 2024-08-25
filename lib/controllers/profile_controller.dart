import 'dart:io';

import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  Rx<Status> status = Status.NONE.obs;
  final RxString errorMessage = "".obs;
  final RxString successMessage = "".obs;
  final Rx<XFile?> imageFile = Rx<XFile?>(null);
  final RxString fotoProfileLink = "".obs;
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

  void clearField() {
    emailController.value.text = "";
    namaPanggilanController.value.text = "";
    namaLengkapController.value.text = "";
    tanggalLahirController.value.text = "";
    jenisKelaminController.value = "Laki-laki";
  }

  void startPage() {
    status.value = Status.NONE;
    errorMessage.value = "";
    clearField();
  }

  Future<dynamic> getDataProfile() async {
    var getUser = await UserPreferences.getCurrentUser();
    final UserModel currentUser =
        UserModel.fromJson(getUser as Map<String, dynamic>);
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.userId) // Menggunakan documentId yang Anda berikan
        .get()
        .timeout(const Duration(seconds: 10));
    // profile_image
  }

  Future<void> getProfile() async {
    startPage();
    try {
      status.value = Status.LOADING;
      var userProfile = await getDataProfile();
      final UserModel userProfileJson =
          UserModel.fromJson(userProfile.data() as Map<String, dynamic>);

      // print(userProfileJson.profileImage);

      fotoProfileLink.value = userProfileJson.profileImage.toString();
      emailController.value.text = userProfileJson.email.toString();
      namaPanggilanController.value.text =
          userProfileJson.namaPanggilan.toString();
      namaLengkapController.value.text = userProfileJson.namaLengkap.toString();
      // tanggalLahirController.value.text =
      //     userProfileJson.tanggalLahir ?? DateTime.now().toString();
      if (userProfileJson.jenisKelamin != "" &&
          userProfileJson.jenisKelamin != null) {
        jenisKelaminController.value = userProfileJson.jenisKelamin.toString();
      }
      // print(userProfileJson.tanggalLahir);
      tanggalLahirController.value.text = userProfileJson.tanggalLahir ??
          DateFormat('yyyy-MM-dd').format(DateTime.now());

      status.value = Status.NONE;
    } catch (e) {
      errorMessage.value = "Gagal mengambil data profile !";
      status.value = Status.FAILED;
    }
  }

  Future<void> saveProfile() async {
    try {
      status.value = Status.LOADING;
      Map<String, dynamic> updatedData = {
        'email': emailController.value.text,
        'nama_lengkap': namaLengkapController.value.text,
        'nama_panggilan': namaPanggilanController.value.text,
        'tanggal_lahir': tanggalLahirController.value.text,
        'jenis_kelamin': jenisKelaminController.value,
      };

      // get id
      var getUser = await UserPreferences.getCurrentUser();
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);
      // update profile
      DocumentReference userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.userId);
      await userRef.update(updatedData).timeout(const Duration(seconds: 10));
      // update userPreference
      updatedData['user_id'] = currentUser.userId;
      updatedData['profile_image'] = currentUser.profileImage;
      await UserPreferences.saveCurrentUser(updatedData);

      successMessage.value = "Profile berhasil diubah";
      status.value = Status.SUCCESS;
    } catch (e) {
      errorMessage.value = "Gagal menyimpan data profile !";
      // handle the error here
      // print("errornya: $e");
      status.value = Status.FAILED;
    }
  }

  Future<void> uploadImage(ImageSource media) async {
    final ImagePicker picker = ImagePicker();
    var img = await picker.pickImage(source: media);

    if (img != null) {
      imageFile.value = img;
      // save to firebase
      try {
        status.value = Status.LOADING;
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        // Mendapatkan ekstensi file dari path gambar
        List<String> filePathSegments = imageFile.value!.path.split('.');
        String fileExtension = filePathSegments.last;

        // Menyertakan ekstensi dalam nama file
        String fileNameWithExtension = '$fileName.$fileExtension';

        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/$fileNameWithExtension');

        UploadTask uploadTask =
            storageReference.putFile(File(imageFile.value!.path));
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        String imageUrl = await taskSnapshot.ref.getDownloadURL();

        // get id
        var getUser = await UserPreferences.getCurrentUser();
        final UserModel currentUser =
            UserModel.fromJson(getUser as Map<String, dynamic>);
        var userId = currentUser.userId;

        // get data user
        var profileUser = await getDataProfile();
        final UserModel profileUserJson =
            UserModel.fromJson(profileUser.data() as Map<String, dynamic>);

        // remove gambar lama jika ada
        if (profileUserJson.profileImage != null) {
          // print(
          //     "================================================================");
          // print(profileUserJson.profileImage.toString());
          // print(
          //     "================================================================");
          Reference imageRef = FirebaseStorage.instance
              .refFromURL(profileUserJson.profileImage.toString());
          await imageRef.delete();
        }

        // update profile
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(userId);
        await userRef.update({'profile_image': imageUrl}).timeout(
            const Duration(seconds: 10));

        status.value = Status.NONE;
      } catch (e) {
        errorMessage.value = "Gagal mengubah gambar profile !";
        // handle the error here
        print("errornya: $e");
        status.value = Status.FAILED;
      }
    }
  }
}
