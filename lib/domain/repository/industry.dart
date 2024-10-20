import 'package:sistem_magang/domain/entities/industry_info.dart';

abstract class IndustryRepository {
  Future<IndustryEntity> getIndustryData();
}