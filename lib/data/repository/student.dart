import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sitama3/data/models/guidance.dart';
import 'package:sitama3/data/models/student_home.dart';
import 'package:sitama3/data/source/student_api_service.dart';
import 'package:sitama3/domain/repository/student.dart';
import 'package:sitama3/routes.dart';

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
          return Left("Invalid data format");
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
          return Left("Invalid data format");
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
}
