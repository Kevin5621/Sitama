import 'package:dartz/dartz.dart';
import 'package:sistem_magang/core/error/failure.dart';
import 'package:sistem_magang/core/usecase/usecase.dart';
import 'package:sistem_magang/domain/entities/guidance_entity.dart';
import 'package:sistem_magang/domain/repository/lecturer.dart';

class GetStudentDetails implements UseCase<Either<Failure, List<GuidanceEntity>>, GetStudentDetailsParams> {
  final LecturerRepository repository;

  GetStudentDetails(this.repository);

  @override
  Future<Either<Failure, List<GuidanceEntity>>> call({GetStudentDetailsParams? param}) async {
    if (param == null) {
      throw ArgumentError('GetStudentDetailsParams cannot be null');
    }
    return await repository.getStudentDetails(param.studentId);
  }
}

class GetStudentDetailsParams {
  final String studentId;

  GetStudentDetailsParams({required this.studentId});
}


