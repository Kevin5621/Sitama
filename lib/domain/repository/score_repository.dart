import 'package:sistem_magang/domain/entities/industry_score.dart';

abstract class ScoreRepository {
  Future<void> updateScores(List<IndustryScore> scores);
}