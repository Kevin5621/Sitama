import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/auth_state.dart';
import '../../../domain/usecase/is_logged_in.dart';
import '../../../config/routes.dart';

class AuthStateCubit extends Cubit<AuthState>{
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async{
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();

    if (isLoggedIn){
      emit(Authenticated());
    } else{
      emit(UnAuthenticated());
    }
  }

}