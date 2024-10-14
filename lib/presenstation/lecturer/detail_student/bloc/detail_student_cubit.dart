import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_magang/core/error/failure.dart';
import 'package:sistem_magang/domain/usecases/get_student_bimbingan.dart';
import 'package:sistem_magang/domain/usecases/get_student_logbook.dart';
import 'package:sistem_magang/presenstation/lecturer/detail_student/bloc/detail_student_state.dart';

class DetailStudentCubit extends Cubit<DetailStudentState> {
  final GetStudentDetails getStudentDetails;
  final GetStudentLogbooks getStudentLogbooks;

  DetailStudentCubit({
    required this.getStudentDetails,
    required this.getStudentLogbooks,
  }) : super(DetailStudentInitial());

  Future<void> loadStudentDetails(String studentId) async {
    emit(DetailStudentLoading());

  final detailsParams = GetStudentDetailsParams(studentId: studentId);
  final logbooksParams = GetStudentLogbooksParams(studentId: studentId);
  

  final detailsResult = await getStudentDetails(param: detailsParams);
  final logbooksResult = await getStudentLogbooks(param: logbooksParams);

    detailsResult.fold(
      (failure) => emit(DetailStudentError(message: _mapFailureToMessage(failure))),
      (guidanceList) {
        logbooksResult.fold(
          (failure) => emit(DetailStudentError(message: _mapFailureToMessage(failure))),
          (logbooks) => emit(DetailStudentLoaded(guidanceList: guidanceList, logbooks: logbooks)),
        );
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      case NetworkFailure:
        return 'Network error occurred';
      default:
        return 'Unexpected error occurred';
    }
  }
}