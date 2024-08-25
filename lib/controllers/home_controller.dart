import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<Status> status = Status.NONE.obs;
  RxString errorMessage = "".obs;
  final suhuTubuhTerbaru = {}.obs;
  final oksigenDarahTerbaru = {}.obs;
  final detakJantungTerbaru = {}.obs;

  void clearAllData() {
    suhuTubuhTerbaru.clear();
    oksigenDarahTerbaru.clear();
    detakJantungTerbaru.clear();
  }

  Future<Map<String, dynamic>?> getDataKesehatanMaster(
      {required jenisPengecekan, required userId}) async {
    var snapshoot = await FirebaseFirestore.instance
        .collection('pengecekan_kesehatan')
        .where('jenis_pengecekan', isEqualTo: jenisPengecekan)
        .where('user_id', isEqualTo: userId)
        .orderBy('tanggal_pengecekan', descending: true)
        .limit(1)
        .get()
        .timeout(const Duration(seconds: 10));

    if (snapshoot.docs.isNotEmpty) {
      return snapshoot.docs.first.data();
    } else {
      return {};
    }
  }

  Future<void> getLatestHealthData() async {
    try {
      status.value = Status.LOADING;
      clearAllData();

      var getUser = await UserPreferences.getCurrentUser();
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);

      var detakJantung = await getDataKesehatanMaster(
          jenisPengecekan: "Detak Jantung", userId: currentUser.userId);
      var saturasiOksigen = await getDataKesehatanMaster(
          jenisPengecekan: "Saturasi Oksigen", userId: currentUser.userId);
      var suhuTubuh = await getDataKesehatanMaster(
          jenisPengecekan: "Suhu Tubuh", userId: currentUser.userId);

      // print({
      //   'detak_jantung': detakJantung,
      //   'saturasi_oksigen': saturasiOksigen,
      //   'suhu_tubuh': suhuTubuh,
      // });
      // status.value = Status.SUCCESS;
      // return;

      detakJantungTerbaru.addAll(detakJantung as Map<String, dynamic>);
      oksigenDarahTerbaru.addAll(saturasiOksigen as Map<String, dynamic>);
      suhuTubuhTerbaru.addAll(suhuTubuh as Map<String, dynamic>);

      // mengambil data berdasarkan tanggal upload terbaru
      status.value = Status.SUCCESS;
    } catch (e) {
      print("========================================");
      print(e);
      print("========================================");
      status.value = Status.FAILED;
      clearAllData();
    }
  }
}
