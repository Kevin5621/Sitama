import 'package:dartz/dartz.dart';
import 'package:sitama3/core/usecase/usecase.dart';
import 'package:sitama3/data/models/signin_req_params.dart';
import 'package:sitama3/domain/repository/student.dart';
import 'package:sitama3/routes.dart';

class GetHomeStudentUseCase implements UseCase<Either, SigninReqParams> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<StudentRepository>().getStudentHome();
  }
}
