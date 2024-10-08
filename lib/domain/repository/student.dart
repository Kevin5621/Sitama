import 'package:dartz/dartz.dart';
abstract class StudentRepository {
  Future<Either> getStudentHome();
  Future<Either> getGuidances();
}