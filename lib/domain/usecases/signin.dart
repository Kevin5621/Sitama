import 'package:dartz/dartz.dart';
import 'package:sitama3/core/usecase/usecase.dart';
import 'package:sitama3/data/models/signin_req_params.dart';
import 'package:sitama3/domain/repository/auth.dart';
import 'package:sitama3/routes.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams>{

  @override
  Future<Either> call({SigninReqParams ? param}) async {
    return sl<AuthRepostory>().signin(param!);
  }

}