import 'package:sistem_magang/data/models/industry_model.dart';
import 'package:sistem_magang/data/source/industry_api_service.dart';
import 'package:sistem_magang/data/source/industry_local_service.dart';
import 'package:sistem_magang/domain/entities/industry_info.dart';
import 'package:sistem_magang/domain/repository/industry.dart';

class IndustryRepositoryImpl implements IndustryRepository {
  final IndustryLocalService localSource;
  final IndustryApiService industryapiservice;

  IndustryRepositoryImpl({
    required this.localSource,
    required this.industryapiservice,
  });

  Future<IndustryModel?> getIndustryInfo() async {
    // Ambil data lokal terlebih dahulu
    final localData = await localSource.getIndustryInfo();
    
    try {
      // Cek update dari server di background
      final response = await industryapiservice.get('/industry-info');
      final serverData = IndustryModel.fromJson(response.data);
      
      // Jika ada perubahan, update data lokal
      if (localData != serverData) {
        await localSource.saveIndustryInfo(serverData);
        return serverData;
      }
    } catch (e) {
      // Jika gagal mengambil data server, tidak perlu throw error
      print('Failed to fetch server update: $e');
    }

    return localData;
  }

  @override
  Future<IndustryEntity> getIndustryData() {
    // TODO: implement getIndustryData
    throw UnimplementedError();
  }
}