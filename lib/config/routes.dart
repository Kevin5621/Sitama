import 'package:flutter/material.dart';
import '../presentation/pages/common/splash_page.dart';
import '../presentation/pages/common/start_page.dart';
import '../presentation/pages/common/login_page.dart';
import '../presentation/pages/mahasiswa/home_page.dart' as mahasiswa;
import '../presentation/pages/mahasiswa/bimbingan_page.dart';
import '../presentation/pages/mahasiswa/logbook_page.dart';
import '../presentation/pages/mahasiswa/profile_page.dart' as mahasiswa;
import '../presentation/pages/dosen/home_page.dart' as dosen;
import '../presentation/pages/dosen/detail_mahasiswa_page.dart';
import '../presentation/pages/dosen/input_nilai_page.dart';
import '../presentation/pages/dosen/profile_page.dart' as dosen;

class AppRoutes {
  static const String splash = '/';
  static const String start = '/start';
  static const String login = '/login';
  static const String mahasiswaHome = '/mahasiswa/home';
  static const String mahasiswaBimbingan = '/mahasiswa/bimbingan';
  static const String mahasiswaLogbook = '/mahasiswa/logbook';
  static const String mahasiswaProfile = '/mahasiswa/profile';
  static const String dosenHome = '/dosen/home';
  static const String dosenDetailMahasiswa = '/dosen/detail-mahasiswa';
  static const String dosenInputNilai = '/dosen/input-nilai';
  static const String dosenProfile = '/dosen/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => SplashPage());
      case start:
        return MaterialPageRoute(builder: (_) => StartPage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case mahasiswaHome:
        return MaterialPageRoute(builder: (_) => mahasiswa.HomePage());
      case mahasiswaBimbingan:
        return MaterialPageRoute(builder: (_) => BimbinganPage());
      case mahasiswaLogbook:
        return MaterialPageRoute(builder: (_) => LogbookPage());
      case mahasiswaProfile:
        return MaterialPageRoute(builder: (_) => mahasiswa.ProfilePage());
      case dosenHome:
        return MaterialPageRoute(builder: (_) => dosen.HomePage());
      case dosenDetailMahasiswa:
        return MaterialPageRoute(builder: (_) => DetailMahasiswaPage());
      case dosenInputNilai:
        return MaterialPageRoute(builder: (_) => InputNilaiPage());
      case dosenProfile:
        return MaterialPageRoute(builder: (_) => dosen.ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Route tidak ditemukan')),
          ),
        );
    }
  }
}