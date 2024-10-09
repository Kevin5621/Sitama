import 'package:get_it/get_it.dart';
import 'package:sitama3/core/network/dio_client.dart';
import 'package:sitama3/data/repository/auth.dart';
import 'package:sitama3/data/repository/student.dart';
import 'package:sitama3/data/source/auth_api_service.dart';
import 'package:sitama3/data/source/auth_local_service.dart';
import 'package:sitama3/data/source/student_api_service.dart';
import 'package:sitama3/domain/repository/auth.dart';
import 'package:sitama3/domain/repository/student.dart';
import 'package:sitama3/domain/usecases/get_guidances_student.dart';
import 'package:sitama3/domain/usecases/get_home_student.dart';
import 'package:sitama3/domain/usecases/is_logged_in.dart';
import 'package:sitama3/domain/usecases/log_out.dart';
import 'package:sitama3/domain/usecases/signin.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  //Service
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<StudentApiService>(StudentApiServiceImpl());

  // Repostory
  sl.registerSingleton<AuthRepostory>(AuthRepostoryImpl());
  sl.registerSingleton<StudentRepository>(StudentRepositoryImpl());

  // Usecase
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetHomeStudentUseCase>(GetHomeStudentUseCase());
  sl.registerSingleton<GetGuidancesStudentUseCase>(GetGuidancesStudentUseCase());
  
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
}