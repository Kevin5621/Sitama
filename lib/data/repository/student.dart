import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sistem_magang/data/models/guidance.dart';
import 'package:sistem_magang/data/models/student_home.dart';
import 'package:sistem_magang/data/source/student_api_service.dart';
import 'package:sistem_magang/domain/repository/student.dart';
import 'package:sistem_magang/service_locator.dart';

class StudentRepositoryImpl extends StudentRepository {
  @override
  Future<Either> getStudentHome() async {
    Either result = await sl<StudentApiService>().getStudentHome();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;

        // Check if 'data' is not null and is a Map
        if (response.data['data'] == null ||
            response.data['data'] is! Map<String, dynamic>) {
          return const Left("Invalid data format");
        }

        try {
          var dataModel = StudentHomeModel.fromMap(response.data['data']);
          var dataEntity = dataModel.toEntity();
          return Right(dataEntity);
        } catch (e) {
          return Left("Parsing error: $e");
        }
      },
    );
  }

  @override
  Future<Either> getGuidances() async {
    Either result = await sl<StudentApiService>().getGuidances();
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        Response response = data;

        // Check if 'data' is not null and is a Map
        if (response.data['data'] == null ||
            response.data['data'] is! Map<String, dynamic>) {
          return const Left("Invalid data format");
        }

        try {
          var dataModel = ListGuidanceModel.fromMap(response.data['data']);
          var dataEntity = dataModel.toEntity();
          return Right(dataEntity);
        } catch (e) {
          return Left("Parsing error: $e");
        }
      },
    );
  }

  @override
  Future<Either> addGuidances(AddGuidanceReqParams request) async {
    Either result = await sl<StudentApiService>().addGuidances(request);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> editGuidances(EditGuidanceReqParams request) async {
    Either result = await sl<StudentApiService>().editGuidances(request);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }

  @override
  Future<Either> deleteGuidances(int id) async {
    Either result = await sl<StudentApiService>().deleteGuidances(id);
    return result.fold(
      (error) {
        return Left(error);
      },
      (data) {
        return Right(data);
      },
    );
  }
}
