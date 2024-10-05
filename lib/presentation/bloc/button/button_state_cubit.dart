import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/button/button_state.dart';
import '../../../core/usecase.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  void excute({dynamic params, required UseCase usecase}) async {

    emit(ButtonLoadingState());
    
    try{
      Either result = await usecase.call(param: params);

      result.fold((error){
        emit(
          ButtonFailurState(errorMessage: error)
        );
      }, 
      (data) {
        emit(
          ButtonSuccessState()
        );
      });
    } catch (e){
      emit(
        ButtonFailurState(errorMessage: e.toString())
      );
    }
  }
}