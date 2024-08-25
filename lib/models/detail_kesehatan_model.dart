import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DetailKesehatanModel {
  String? userId;
  String? satuan;
  double? nilai;
  String? tanggalPengecekan;
  String? waktu;
  String? jenisPerangkat;
  String? jenisPengecekan;

  DetailKesehatanModel(
      {this.userId,
      this.satuan,
      this.nilai,
      this.tanggalPengecekan,
      this.waktu,
      this.jenisPerangkat,
      this.jenisPengecekan});

  DetailKesehatanModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    satuan = json['satuan'];
    nilai = json['nilai'];
    if (json['tanggal_pengecekan'] != null) {
      Timestamp timestamp = json['tanggal_pengecekan'];
      DateTime dateTime = timestamp.toDate();
      String tanggal = DateFormat('dd/MM/yy').format(dateTime).toString();
      String formatWaktu = DateFormat('HH:mm:ss').format(dateTime).toString();
      tanggalPengecekan = tanggal;
      waktu = formatWaktu;
    } else {
      tanggalPengecekan = null;
      waktu = null;
    }
    jenisPerangkat = json['jenis_perangkat'];
    jenisPengecekan = json['jenis_pengecekan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['satuan'] = satuan;
    data['nilai'] = nilai;
    data['tanggal_pengecekan'] = tanggalPengecekan;
    data['waktu'] = waktu;
    data['jenis_perangkat'] = jenisPerangkat;
    data['jenis_pengecekan'] = jenisPengecekan;
    return data;
  }
}
