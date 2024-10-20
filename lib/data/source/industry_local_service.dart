import 'package:hive/hive.dart';
import 'package:sistem_magang/data/models/industry_model.dart';

class IndustryLocalService {
  final Box<IndustryModel> industryBox;

  IndustryLocalService(this.industryBox);

  Future<IndustryModel?> getIndustryInfo() async {
    return industryBox.get('industry_info');
  }

  Future<void> saveIndustryInfo(IndustryModel industry) async {
    await industryBox.put('industry_info', industry);
  }
}