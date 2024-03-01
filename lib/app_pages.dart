import 'package:ble_client/screens/all_riwayat_kesehatan/all_riwayat_kesehatan.dart';
import 'package:ble_client/screens/detail_riwayat_kesehatan/detail_riwayat_kesehatan_screen.dart';
import 'package:ble_client/screens/edit_profile/edit_profile_screen.dart';
import 'package:ble_client/screens/hasil_pengecekan/hasil_pengecekan_screen.dart';
import 'package:ble_client/screens/home/home_screen.dart';
import 'package:ble_client/screens/pengaturan_perangkat/pengaturan_perangkat_screen.dart';
import 'package:ble_client/screens/pengecekan_kesehatan/pengecekan_kesehatan_screen.dart';
import 'package:ble_client/screens/profile/profile_screen.dart';
import 'package:ble_client/screens/riwayat_kesehatan/riwayat_kesehatan_screen.dart';
import 'package:ble_client/screens/sign_in/sign_in_screen.dart';
import 'package:get/get.dart';

List<GetPage> appPages = [
  GetPage(name: SignInScreen.routeName, page: () => const SignInScreen()),
  GetPage(name: HomeScreen.routeName, page: () => const HomeScreen()),
  GetPage(
      name: PengecekanKesehatan.routeName,
      page: () => const PengecekanKesehatan()),
  GetPage(
      name: HasilPengecekanScreen.routeName,
      page: () => const HasilPengecekanScreen()),
  GetPage(
      name: RiwayatkesehatanScreen.routeName,
      page: () => const RiwayatkesehatanScreen()),
  GetPage(name: ProfileScreen.routeName, page: () => const ProfileScreen()),
  GetPage(
      name: PengaturanPerangkatScreen.routeName,
      page: () => const PengaturanPerangkatScreen()),
  GetPage(
      name: EditProfileScreen.routeName, page: () => const EditProfileScreen()),
  GetPage(
      name: AllRiwayatKesehatanScreen.routeName,
      page: () => const AllRiwayatKesehatanScreen()),
  GetPage(
      name: DetailRiwayatKesehatanScreen.routeName,
      page: () => const DetailRiwayatKesehatanScreen()),
];
