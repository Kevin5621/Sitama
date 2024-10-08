import '../../../domain/entities/logbook.dart';

abstract class LogbookState {}

class LogbookInitial extends LogbookState {}

class LogbookLoading extends LogbookState {}

class LogbookLoaded extends LogbookState {
  final List<LogbookItem> logbooks;
  LogbookLoaded(this.logbooks);
}

class LogbookError extends LogbookState {
  final String message;
  LogbookError(this.message);
}