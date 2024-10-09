import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:sitama3/core/constants/api_urls.dart';
import 'package:sitama3/core/network/dio_client.dart';
import 'package:sitama3/data/models/signin_req_params.dart';
import 'package:sitama3/routes.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams request);
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signin(SigninReqParams request) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.login, data: request.toMap());

      return Right(response);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['errors']['message'].toString());
      } else {
        return Left(e.message);
      }
    }
  }
}
