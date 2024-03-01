class UserModel {
  String? userId;
  String? namaLengkap;
  String? namaPanggilan;
  String? jenisKelamin;
  String? email;
  String? tanggalLahir;
  String? profileImage;

  UserModel(
      {this.userId,
      this.namaLengkap,
      this.namaPanggilan,
      this.jenisKelamin,
      this.email,
      this.tanggalLahir,
      this.profileImage});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    namaLengkap = json['nama_lengkap'];
    namaPanggilan = json['nama_panggilan'];
    jenisKelamin = json['jenis_kelamin'];
    email = json['email'];
    tanggalLahir = json['tanggal_lahir'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['nama_lengkap'] = namaLengkap;
    data['nama_panggilan'] = namaPanggilan;
    data['jenis_kelamin'] = jenisKelamin;
    data['email'] = email;
    data['tanggal_lahir'] = tanggalLahir;
    data['profile_image'] = profileImage;
    return data;
  }
}
