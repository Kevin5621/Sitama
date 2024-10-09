import 'package:dartz/dartz.dart';
import 'package:sitama3/data/models/signin_req_params.dart';

abstract class AuthRepostory {

  Future<Either> signin(SigninReqParams request);
  Future<bool> isLoggedIn();
  Future<Either> logout();
  
} 