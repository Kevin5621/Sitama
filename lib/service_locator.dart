import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:sistem_magang/core/network/dio_client.dart';
import 'package:sistem_magang/data/models/industry_model.dart';
import 'package:sistem_magang/data/repository/auth.dart';
import 'package:sistem_magang/data/repository/industry.dart';
import 'package:sistem_magang/data/repository/lecturer.dart';
import 'package:sistem_magang/data/repository/student.dart';
import 'package:sistem_magang/data/source/auth_api_service.dart';
import 'package:sistem_magang/data/source/auth_local_service.dart';
import 'package:sistem_magang/data/source/industry_api_service.dart';
import 'package:sistem_magang/data/source/industry_local_service.dart';
import 'package:sistem_magang/data/source/lecturer_api_service.dart';
import 'package:sistem_magang/data/source/student_api_service.dart';
import 'package:sistem_magang/domain/repository/auth.dart';
import 'package:sistem_magang/domain/repository/industry.dart';
import 'package:sistem_magang/domain/repository/lecturer.dart';
import 'package:sistem_magang/domain/repository/student.dart';
import 'package:sistem_magang/domain/usecases/add_guidance_student.dart';
import 'package:sistem_magang/domain/usecases/delete_guidance_student.dart';
import 'package:sistem_magang/domain/usecases/edit_guidance_student.dart';
import 'package:sistem_magang/domain/usecases/get_detail_student.dart';
import 'package:sistem_magang/domain/usecases/get_guidances_student.dart';
import 'package:sistem_magang/domain/usecases/get_home_lecturer.dart';
import 'package:sistem_magang/domain/usecases/get_home_student.dart';
import 'package:sistem_magang/domain/usecases/get_indusrty.dart';
import 'package:sistem_magang/domain/usecases/is_logged_in.dart';
import 'package:sistem_magang/domain/usecases/log_out.dart';
import 'package:sistem_magang/domain/usecases/signin.dart';
import 'package:sistem_magang/domain/usecases/update_status_guidance.dart';
import 'package:sistem_magang/presenstation/student/profile/bloc/industry_bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  // Core
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerLazySingleton(() => Dio());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<StudentApiService>(StudentApiServiceImpl());
  sl.registerSingleton<LecturerApiService>(LecturerApiServiceImpl());
  sl.registerLazySingleton<IndustryApiService>(
    () => IndustryApiService(sl<Dio>()),
  );
  sl.registerLazySingleton<IndustryLocalService>(
    () => IndustryLocalService(
      sl<Box<IndustryModel>>(), 
    ),
  );

  // Repositories
  sl.registerSingleton<AuthRepostory>(AuthRepostoryImpl());
  sl.registerSingleton<StudentRepository>(StudentRepositoryImpl());
  sl.registerSingleton<LecturerRepository>(LecturerRepositoryImpl());
  sl.registerLazySingleton<IndustryRepository>(
    () => IndustryRepositoryImpl(
      localSource: sl<IndustryLocalService>(),
      industryapiservice: sl<IndustryApiService>(),
    ),
  );

  // Use Cases
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetHomeStudentUseCase>(GetHomeStudentUseCase());
  sl.registerSingleton<GetGuidancesStudentUseCase>(GetGuidancesStudentUseCase());
  sl.registerSingleton<AddGuidanceUseCase>(AddGuidanceUseCase());
  sl.registerSingleton<EditGuidanceUseCase>(EditGuidanceUseCase());
  sl.registerSingleton<DeleteGuidanceUseCase>(DeleteGuidanceUseCase());
  sl.registerLazySingleton<GetIndustryInfo>(
    () => GetIndustryInfo(sl<IndustryRepository>()),
  );
  sl.registerSingleton<GetHomeLecturerUseCase>(GetHomeLecturerUseCase());
  sl.registerSingleton<GetDetailStudentUseCase>(GetDetailStudentUseCase());
  sl.registerSingleton<UpdateStatusGuidanceUseCase>(UpdateStatusGuidanceUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());

  // Blocs
  sl.registerFactory<IndustryBloc>(() => IndustryBloc(sl()));
  sl.registerLazySingleton<Box<IndustryModel>>(() => Hive.box<IndustryModel>('industryBox'));
}

