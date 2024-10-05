import 'package:dartz/dartz.dart';
import '../../core/usecase.dart';
import '../../data/models/signin_req_params.dart';
import '../repository/auth.dart';
import '../../config/routes.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams>{

  @override
  Future<Either> call({SigninReqParams ? param}) async {
    return sl<AuthRepostory>().signin(param!);
  }

}