import 'package:get_it/get_it.dart';
import 'package:sistem_magang/core/network/dio_client.dart';
import 'package:sistem_magang/data/repository/auth.dart';
import 'package:sistem_magang/data/source/auth_api_service.dart';
import 'package:sistem_magang/data/source/auth_local_service.dart';
import 'package:sistem_magang/domain/repository/auth.dart';
import 'package:sistem_magang/domain/usecases/is_logged_in.dart';
import 'package:sistem_magang/domain/usecases/signin.dart';

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