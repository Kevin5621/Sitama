
import 'package:sitama3/core/usecase/usecase.dart';
import 'package:sitama3/domain/repository/auth.dart';
import 'package:sitama3/routes.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepostory>().isLoggedIn();
  }
}
