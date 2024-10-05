import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../config/constants.dart';
import '../../config/network/dio_client.dart';
import '../models/signin_req_params.dart';
import '../../config/routes.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams request);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signin(SigninReqParams request) async {
    // ignore: avoid_print
    print('request: ${request.toMap()}');
    try {
      var response =
          await sl<DioClient>().post(AppConstants.login, data: request.toMap());

      return Right(response);
    } on DioException catch (e) {
      if (e.response != null) {
        // ignore: avoid_print
        print('Error response: ${e.response!.data['errors']['message']}');
        return Left(e.response!.data['errors']['message'].toString());
      } else {
        // ignore: avoid_print
        print('Error message: ${e.message}');
        return Left(e.message);
      }
    }
  }
}
