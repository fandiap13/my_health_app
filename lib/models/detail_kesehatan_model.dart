class DetailKesehatanModel {
  String? namaLengkap;
  String? namaPanggilan;
  String? jenisKelamin;
  String? email;
  String? tanggalLahir;
  String? userId;

  DetailKesehatanModel(
      {this.namaLengkap,
      this.namaPanggilan,
      this.jenisKelamin,
      this.email,
      this.tanggalLahir,
      this.userId});

  DetailKesehatanModel.fromJson(Map<String, dynamic> json) {
    namaLengkap = json['nama_lengkap'];
    namaPanggilan = json['nama_panggilan'];
    jenisKelamin = json['jenis_kelamin'];
    email = json['email'];
    tanggalLahir = json['tanggal_lahir'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama_lengkap'] = namaLengkap;
    data['nama_panggilan'] = namaPanggilan;
    data['jenis_kelamin'] = jenisKelamin;
    data['email'] = email;
    data['tanggal_lahir'] = tanggalLahir;
    data['user_id'] = userId;
    return data;
  }
}
