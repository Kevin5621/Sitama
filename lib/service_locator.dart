import 'package:get_it/get_it.dart';
import 'package:sistem_magang/core/network/dio_client.dart';
import 'package:sistem_magang/data/repository/auth.dart';
import 'package:sistem_magang/data/repository/score_repository_impl.dart';
import 'package:sistem_magang/data/repository/student.dart';
import 'package:sistem_magang/data/source/auth_api_service.dart';
import 'package:sistem_magang/data/source/auth_local_service.dart';
import 'package:sistem_magang/data/source/score_remote_data_source.dart';
import 'package:sistem_magang/data/source/score_remote_data_source_impl.dart';
import 'package:sistem_magang/data/source/student_api_service.dart';
import 'package:sistem_magang/domain/repository/auth.dart';
import 'package:sistem_magang/domain/repository/score_repository.dart';
import 'package:sistem_magang/domain/repository/student.dart';
import 'package:sistem_magang/domain/usecases/get_guidances_student.dart';
import 'package:sistem_magang/domain/usecases/get_home_student.dart';
import 'package:sistem_magang/domain/usecases/is_logged_in.dart';
import 'package:sistem_magang/domain/usecases/log_out.dart';
import 'package:sistem_magang/domain/usecases/signin.dart';
import 'package:sistem_magang/domain/usecases/update_scores_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Service
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<StudentApiService>(StudentApiServiceImpl());

  // Repostory
  sl.registerSingleton<AuthRepostory>(AuthRepostoryImpl());
  sl.registerSingleton<StudentRepository>(StudentRepositoryImpl());
  sl.registerLazySingleton<ScoreRepository>(() => ScoreRepositoryImpl(sl()));
  
  // Usecase
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetHomeStudentUseCase>(GetHomeStudentUseCase());
  sl.registerSingleton<GetGuidancesStudentUseCase>(GetGuidancesStudentUseCase());
  sl.registerLazySingleton(() => UpdateScoresUseCase(sl()));

  // Data sources
  sl.registerLazySingleton<ScoreRemoteDataSource>(() => ScoreRemoteDataSourceImpl());
  
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
}