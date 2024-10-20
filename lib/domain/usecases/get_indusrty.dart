import 'package:sistem_magang/domain/entities/industry_info.dart';
import 'package:sistem_magang/domain/repository/industry.dart';

class GetIndustryInfo {
  final IndustryRepository _repository;

  GetIndustryInfo(this._repository);

  Future<IndustryEntity> execute() {
    return _repository.getIndustryData();
  }
}