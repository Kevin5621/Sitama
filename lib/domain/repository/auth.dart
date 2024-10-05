import 'package:dartz/dartz.dart';
import 'package:sistem_magang/data/models/signin_req_params.dart';

abstract class AuthRepostory {

  Future<Either> signin(SigninReqParams request);
  Future<bool> isLoggedIn();
  
} 