import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sitama3/data/models/signin_req_params.dart';
import 'package:sitama3/data/source/auth_api_service.dart';
import 'package:sitama3/data/source/auth_local_service.dart';
import 'package:sitama3/domain/repository/auth.dart';
import 'package:sitama3/routes.dart';

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
  
  @override
  Future<Either> logout() async {
    Either resullt = await sl<AuthLocalService>().logout();
    return resullt;
  }
  
}