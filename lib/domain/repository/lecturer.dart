import 'package:dartz/dartz.dart';
import 'package:sistem_magang/core/error/failure.dart';
import 'package:sistem_magang/domain/entities/guidance_entity.dart';
import '../entities/logbook.dart';

abstract class LecturerRepository {
  Future<Either<Failure, List<GuidanceEntity>>> getStudentDetails(String studentId);
  Future<Either<Failure, List<Logbook>>> getStudentLogbooks(String studentId);
}
