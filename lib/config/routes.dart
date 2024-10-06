import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import '../utils/api_helper.dart';
import '../data/repository/auth.dart';
import '../domain/repository/auth.dart';
import '../presentation/pages/common/splash.dart';
import '../presentation/pages/common/welcome.dart';
import '../presentation/pages/common/login.dart';
import '../data/source/auth_api_service.dart';
import '../data/source/auth_local_service.dart';
import '../domain/usecase/is_logged_in.dart';
import '../domain/usecase/signin.dart';
import '../presentation/pages/Mahasiswa/home.dart' as mahasiswa;
import '../presentation/pages/mahasiswa/guidance.dart';
import '../presentation/pages/mahasiswa/logbook.dart';
// import '../presentation/pages/mahasiswa/profile_page.dart' as mahasiswa;
// import '../presentation/pages/dosen/home_page.dart' as dosen;
// import '../presentation/pages/dosen/detail_mahasiswa_page.dart';
// import '../presentation/pages/dosen/input_nilai_page.dart';
// import '../presentation/pages/dosen/profile_page.dart' as dosen;

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //Service
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  // Repostory
  sl.registerSingleton<AuthRepostory>(AuthRepostoryImpl());

  // Usecase
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
}

class AppRoutes {
  static const String splash = '/';
  static const String welcome = '/welcome';
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
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePages());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case mahasiswaHome:
        return MaterialPageRoute(builder: (_) => const mahasiswa.HomePage());
      case mahasiswaBimbingan:
        return MaterialPageRoute(builder: (_) => const GuidancePage());
      case mahasiswaLogbook:
        return MaterialPageRoute(builder: (_) => const LogbookPage());
      // case mahasiswaProfile:
      //   return MaterialPageRoute(builder: (_) => mahasiswa.ProfilePage());
      // case dosenHome:
      //   return MaterialPageRoute(builder: (_) => dosen.HomePage());
      // case dosenDetailMahasiswa:
      //   return MaterialPageRoute(builder: (_) => DetailMahasiswaPage());
      // case dosenInputNilai:
      //   return MaterialPageRoute(builder: (_) => InputNilaiPage());
      // case dosenProfile:
      //   return MaterialPageRoute(builder: (_) => dosen.ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route tidak ditemukan')),
          ),
        );
    }
  }
}