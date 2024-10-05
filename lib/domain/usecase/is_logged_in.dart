import '../../core/usecase.dart';
import '../../domain/repository/auth.dart';
import '../../config/routes.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepostory>().isLoggedIn();
  }
}
