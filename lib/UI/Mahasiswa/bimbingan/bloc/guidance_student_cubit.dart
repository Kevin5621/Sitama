import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitama3/domain/usecases/get_guidances_student.dart';
import 'package:sitama3/routes.dart';
import 'package:sitama3/ui/Mahasiswa/bimbingan/bloc/guidance_student_state.dart';

class GuidanceStudentCubit extends Cubit<GuidanceStudentState> {
  GuidanceStudentCubit() : super(GuidanceLoading());

  void displayGuidance() async {
    var resullt = await sl<GetGuidancesStudentUseCase>().call();
    resullt.fold(
      (error) {
        emit(LoadGuidanceFailure(errorMessage: error));
      },
      (data) {
        emit(GuidanceLoaded(guidanceEntity: data)); 
      },
    );
  }
}
