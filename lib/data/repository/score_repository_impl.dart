import 'package:sistem_magang/data/source/score_remote_data_source.dart';
import 'package:sistem_magang/domain/entities/industry_score.dart';
import 'package:sistem_magang/domain/repository/score_repository.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  final ScoreRemoteDataSource remoteDataSource;

  ScoreRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> updateScores(List<IndustryScore> scores) async {
    await remoteDataSource.updateScores(scores);
  }
}