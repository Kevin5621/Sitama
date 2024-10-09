import 'package:sitama3/core/usecase/usecase.dart';
import 'package:sitama3/domain/repository/auth.dart';
import 'package:sitama3/routes.dart';

class LogoutUseCase implements UseCase<dynamic, dynamic> {
  @override
  Future call({dynamic param}) async {
    return sl<AuthRepostory>().logout();
  }
}
