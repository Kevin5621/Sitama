import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sistem_magang/data/models/signin_req_params.dart';
import 'package:sistem_magang/data/source/auth_api_service.dart';
import 'package:sistem_magang/data/source/auth_local_service.dart';
import 'package:sistem_magang/domain/repository/auth.dart';
import 'package:sistem_magang/service_locator.dart';

class AuthRepostoryImpl extends AuthRepostory{

  @override
  Future<Either> signin(SigninReqParams request) async {
    Either result = await sl<AuthApiService>().signin(request);
    return result.fold(
      (error) {
        return Left(error);
      }, 
      (data) async {
        Response response = data;
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString('token', response.data['data']['token']);
        sharedPreferences.setString('role', response.data['data']['role']);
        return Right(response);
      }
    );
  }
  
  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }
  
}