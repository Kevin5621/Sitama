import 'package:dartz/dartz.dart';
import 'package:sistem_magang/data/models/guidance.dart';
abstract class StudentRepository {
  Future<Either> getStudentHome();
  Future<Either> getGuidances();
  Future<Either> addGuidances(AddGuidanceReqParams request);
  Future<Either> editGuidances(EditGuidanceReqParams request);
  Future<Either> deleteGuidances(int id);
}