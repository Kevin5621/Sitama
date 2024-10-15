import 'package:sistem_magang/domain/entities/industry_score.dart';
import 'package:dartz/dartz.dart';


abstract class ScoreRepository {
  Future<void> updateScores(List<IndustryScore> scores);
}

abstract class LecturerRepository {
  Future<Either> getLecturerHome();
}
