import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_magang/core/constansts/api_urls.dart';
import 'package:sistem_magang/core/network/dio_client.dart';
import 'package:sistem_magang/data/models/guidance.dart';
import 'package:sistem_magang/service_locator.dart';

abstract class StudentApiService {
  Future<Either> getStudentHome();
  Future<Either> getGuidances();
  Future<Either> addGuidances(AddGuidanceReqParams request);
  Future<Either> editGuidances(EditGuidanceReqParams request);
  Future<Either> deleteGuidances(int id);
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

  @override
  Future<Either> addGuidances(AddGuidanceReqParams request) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.get('token');

      var response = await sl<DioClient>().post(
        ApiUrls.studentGuidance,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: request.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['errors'].toString());
      } else {
        return Left(e.message);
      }
    }
  }

  @override
  Future<Either> editGuidances(EditGuidanceReqParams request) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.get('token');

      var response = await sl<DioClient>().put(
        "${ApiUrls.studentGuidance}/${request.id}",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: request.toMap(),
      );

      return Right(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['errors'].toString());
      } else {
        return Left(e.message);
      }
    }
  }

  @override
  Future<Either> deleteGuidances(int id) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var token = sharedPreferences.get('token');

      var response = await sl<DioClient>().delete(
        "${ApiUrls.studentGuidance}/$id",
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      return Right(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['errors'].toString());
      } else {
        return Left(e.message);
      }
    }
  }
}
