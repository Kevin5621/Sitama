import 'package:dartz/dartz.dart';
import 'package:sistem_magang/core/usecase/usecase.dart';
import 'package:sistem_magang/data/models/signin_req_params.dart';
import 'package:sistem_magang/domain/repository/student.dart';
import 'package:sistem_magang/service_locator.dart';

class GetHomeStudentUseCase implements UseCase<Either, SigninReqParams> {
  @override
  Future<Either> call({dynamic param}) async {
    return sl<StudentRepository>().getStudentHome();
  }
}