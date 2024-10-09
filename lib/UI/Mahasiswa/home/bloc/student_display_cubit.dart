import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitama3/domain/usecases/get_home_student.dart';
import 'package:sitama3/routes.dart';
import 'package:sitama3/ui/Mahasiswa/home/bloc/student_display_state.dart';

class StudentDisplayCubit extends Cubit<StudentDisplayState> {
  StudentDisplayCubit() : super(StudentLoading());

  void displayStudent() async {
    var result = await sl<GetHomeStudentUseCase>().call();
    result.fold(
      (error) {
        emit(LoadStudentFailure(errorMessage: error));
      },
      (data) {
        emit(StudentLoaded(studentHomeEntity: data));
      },
    );
  }
}
