
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitama3/core/constants/api_urls.dart';
import 'package:sitama3/core/network/dio_client.dart';
import 'package:sitama3/routes.dart';

abstract class StudentApiService {
  Future<Either> getStudentHome();
  Future<Either> getGuidances();
}

class StudentApiServiceImpl extends StudentApiService {
  @override
  Future<Either> getStudentHome() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.get('token');

      var response = await sl<DioClient>().get(ApiUrls.studentHome,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['errors']['message']);
    }
  }
  
  @override
  Future<Either> getGuidances() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.get('token');

      var response = await sl<DioClient>().get(ApiUrls.studentGuidance,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['errors']['message']);
    }
  }
}
