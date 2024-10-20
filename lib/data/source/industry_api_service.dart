import 'package:dio/dio.dart';

class IndustryApiService {
  final Dio dio;

  IndustryApiService(this.dio) {
    dio.options = BaseOptions(
      baseUrl: 'http://192.168.36.1:8000/api/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    );
  }

  Future<Response> get(String path) async {
    try {
      final response = await dio.get(path);
      return response;
    } on DioException catch (e) {
      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        error: e.error,
        message: e.message,
      );
    }
  }
}