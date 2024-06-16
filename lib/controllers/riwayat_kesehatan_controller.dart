import 'package:ble_client/controllers/user_preferences.dart';
import 'package:ble_client/enums.dart';
import 'package:ble_client/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RiwayatKesehatanController extends GetxController {
  final List<double> values = <double>[].obs;
  final List<String> dates = <String>[].obs;
  RxString jenisPengecekanKesehatan = "".obs;
  final detailKesehatan1 = {}.obs;
  final detailKesehatan2 = {}.obs;
  final dataHistoryKesehatan = [].obs;
  Rx<Status> status = Status.LOADING.obs;

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

  Future<void> getRiwayatKesehatan(
      {required String jenisPerangkat, required String jenisPengecekan}) async {
    try {
      status.value = Status.LOADING;
      jenisPengecekanKesehatan.value = jenisPengecekan;

      var getUser = await UserPreferences.getCurrentUser();
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);

      // get data riwayat by user
      var dataKesehatan = await FirebaseFirestore.instance
          .collection('pengecekan_kesehatan')
          .where('jenis_perangkat', isEqualTo: jenisPerangkat.toLowerCase())
          .where('user_id', isEqualTo: currentUser.userId)
          .orderBy('tanggal_pengecekan', descending: true)
          .get()
          .timeout(const Duration(seconds: 10));

      // Mengakses data dari setiap dokumen
      values.clear();
      dates.clear();

      for (var doc in dataKesehatan.docs) {
        // Mendapatkan data dari dokumen
        var data = doc.data();
        // print(data);
        // print(jenisPengecekan);
        if (data['jenis_pengecekan'].toLowerCase() ==
            jenisPengecekan.toLowerCase()) {
          // Dapatkan data timestamp dari snapshot
          Timestamp timestamp = data['tanggal_pengecekan'];
          DateTime dateTime = timestamp.toDate();

          values.add(data['nilai']);
          dates.add(DateFormat('MM/dd/yy').format(dateTime).toString());
          // dates.add(dateTime.toString());
        }
      }
      // print(values);
      // print(dates);
      if (jenisPerangkat.toLowerCase() == "oksimeter") {
        var detakJantung = await getDataKesehatanMaster(
            jenisPengecekan: "Detak Jantung", userId: currentUser.userId);
        var saturasiOksigen = await getDataKesehatanMaster(
            jenisPengecekan: "Saturasi Oksigen", userId: currentUser.userId);
        detailKesehatan1.addAll(detakJantung as Map<String, dynamic>);
        detailKesehatan2.addAll(saturasiOksigen as Map<String, dynamic>);
      } else {
        var suhuTubuh = await getDataKesehatanMaster(
            jenisPengecekan: "Suhu Tubuh", userId: currentUser.userId);
        detailKesehatan1.addAll(suhuTubuh as Map<String, dynamic>);
      }

      status.value = Status.SUCCESS;
    } catch (e) {
      print("========================================");
      print(e);
      print("========================================");
      status.value = Status.FAILED;
    }
  }

  Future<void> getAllHistoryKesehatan(
      {required String jenisPerangkat, required String jenisPengecekan}) async {
    try {
      status.value = Status.LOADING;
      dataHistoryKesehatan.clear();
      jenisPengecekanKesehatan.value = jenisPengecekan;

      var getUser = await UserPreferences.getCurrentUser();
      final UserModel currentUser =
          UserModel.fromJson(getUser as Map<String, dynamic>);

      // get data riwayat by user
      var dataKesehatan = await FirebaseFirestore.instance
          .collection('pengecekan_kesehatan')
          .where('jenis_perangkat', isEqualTo: jenisPerangkat.toLowerCase())
          .where('jenis_pengecekan', isEqualTo: jenisPengecekan)
          .where('user_id', isEqualTo: currentUser.userId)
          .orderBy('tanggal_pengecekan', descending: true)
          .get()
          .timeout(const Duration(seconds: 10));

      dataHistoryKesehatan.addAll(dataKesehatan.docs);
      status.value = Status.SUCCESS;
    } catch (e) {
      print("========================================");
      print(e);
      print("========================================");
      status.value = Status.FAILED;
    }
  }
}
