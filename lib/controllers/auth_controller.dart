import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/sign_in/sign_in_screen.dart';
import 'package:ble_client/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final RxString errorMessage = "".obs;
  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle({required BuildContext context}) async {
    errorMessage.value = "";
    await GoogleSignIn().signOut();
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      isLoading.value = true;
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        QuerySnapshot checkUser = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: user?.email)
            .limit(1)
            .get();

        Map<String, dynamic>? currentUser = {};
        if (checkUser.docs.isEmpty) {
          currentUser.addAll({
            'email': user?.email,
            'nama_lengkap': user?.displayName,
            'nama_panggilan': user?.displayName!.split(" ")[0],
            'tanggal_lahir': null,
            'jenis_kelamin': null,
            'profile_image': null,
          });
          DocumentReference newUser = await FirebaseFirestore.instance
              .collection('users')
              .add(currentUser);
          currentUser['user_id'] = newUser.id;
        } else {
          QueryDocumentSnapshot userDocument = checkUser.docs.first;
          // Konversi dokumen menjadi objek tunggal (jika diperlukan)
          currentUser = userDocument.data() as Map<String, dynamic>?;
          currentUser?['user_id'] = userDocument.id;
        }
        // save to shared preferences
        await UserPreferences.saveCurrentUser(currentUser!);
        isLoading.value = false;
        Get.offNamed(HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        // if (e.code == 'account-exists-with-different-credential') {
        //   errorMessage.value = e.message.toString();
        //   print(e.message);
        // } else if (e.code == 'invalid-credential') {
        //   // handle the error here
        //   errorMessage.value = e.message.toString();
        //   print(e.message);
        // }
        errorMessage.value = e.message.toString();
        print("errornya: ${e.message}");
        isLoading.value = false;
      } catch (e) {
        errorMessage.value = e.toString();
        // handle the error here
        print("errornya: $e");
        isLoading.value = false;
      }
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    if (context.mounted) {
      AppUtils.confirmDialog(
          title: "Log Out",
          message: "Anda ingin keluar dari akun ini?",
          context: context,
          action: () async {
            await GoogleSignIn().signOut();
            await UserPreferences.removeCurrentUser();
            Get.offAllNamed(SignInScreen.routeName);
          });
    }
  }
}
