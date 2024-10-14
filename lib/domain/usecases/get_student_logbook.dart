import 'package:dartz/dartz.dart';
import 'package:sistem_magang/core/error/failure.dart';
import 'package:sistem_magang/core/usecase/usecase.dart';
import 'package:sistem_magang/domain/entities/logbook.dart';
import 'package:sistem_magang/domain/repository/lecturer.dart';

class GetStudentLogbooks implements UseCase<Either<Failure, List<Logbook>>, GetStudentLogbooksParams> {
  final LecturerRepository repository;

  GetStudentLogbooks(this.repository);

  @override
  Future<Either<Failure, List<Logbook>>> call({GetStudentLogbooksParams? param}) async {
    if (param == null) {
      throw ArgumentError('GetStudentLogbooksParams cannot be null');
    }
    return await repository.getStudentLogbooks(param.studentId);
  }
}

class GetStudentLogbooksParams {
  final String studentId;

  GetStudentLogbooksParams({required this.studentId});
}