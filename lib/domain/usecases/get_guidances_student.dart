import 'package:dartz/dartz.dart';
import 'package:sitama3/core/usecase/usecase.dart';
import 'package:sitama3/domain/repository/student.dart';
import 'package:sitama3/routes.dart';

class GetGuidancesStudentUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<StudentRepository>().getGuidances();
  }
}
