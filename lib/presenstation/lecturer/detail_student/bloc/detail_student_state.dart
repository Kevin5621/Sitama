import 'package:equatable/equatable.dart';
import 'package:sistem_magang/domain/entities/guidance_entity.dart';
import 'package:sistem_magang/domain/entities/logbook.dart';

abstract class DetailStudentState extends Equatable {
  const DetailStudentState();

  @override
  List<Object> get props => [];
}

class DetailStudentInitial extends DetailStudentState {}

class DetailStudentLoading extends DetailStudentState {}

class DetailStudentLoaded extends DetailStudentState {
  final List<GuidanceEntity> guidanceList;
  final List<Logbook> logbooks;

  const DetailStudentLoaded({required this.guidanceList, required this.logbooks});

  @override
  List<Object> get props => [guidanceList, logbooks];
}

class DetailStudentError extends DetailStudentState {
  final String message;

  const DetailStudentError({required this.message});

  @override
  List<Object> get props => [message];
}