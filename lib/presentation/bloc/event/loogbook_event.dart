import '../../../domain/entities/logbook.dart';

abstract class LogbookEvent {}

class LoadLogbooks extends LogbookEvent {}

class AddLogbookEvent extends LogbookEvent {
  final Logbook logbook;
  AddLogbookEvent(this.logbook);
}

class UpdateLogbookEvent extends LogbookEvent {
  final Logbook logbook;
  UpdateLogbookEvent(this.logbook);
}

class DeleteLogbookEvent extends LogbookEvent {
  final String id;
  DeleteLogbookEvent(this.id);
}

class ToggleLogbookExpansion extends LogbookEvent {
  final String id;
  ToggleLogbookExpansion(this.id);
}


