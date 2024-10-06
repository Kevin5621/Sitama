import 'package:flutter_bloc/flutter_bloc.dart';
import '../event/loogbook_event.dart';
import '../../../domain/entities/logbook.dart';
import '../event/logbook_state.dart';

class LogbookBloc extends Bloc<LogbookEvent, LogbookState> {
  final LogbookRepository repository;

  LogbookBloc(this.repository) : super(LogbookInitial()) {
    on<LoadLogbooks>(_onLoadLogbooks);
    on<AddLogbookEvent>(_onAddLogbook);
    on<UpdateLogbookEvent>(_onUpdateLogbook);
    on<DeleteLogbookEvent>(_onDeleteLogbook);
    on<ToggleLogbookExpansion>(_onToggleExpansion);
  }

  Future<void> _onLoadLogbooks(LoadLogbooks event, Emitter<LogbookState> emit) async {
    emit(LogbookLoading());
    try {
      final logbooks = await repository.getLogbooks();
      emit(LogbookLoaded(logbooks));
    } catch (e) {
      emit(LogbookError(e.toString()));
    }
  }

  Future<void> _onAddLogbook(AddLogbookEvent event, Emitter<LogbookState> emit) async {
    try {
      await repository.addLogbook(event.logbook);
      final logbooks = await repository.getLogbooks();
      emit(LogbookLoaded(logbooks));
    } catch (e) {
      emit(LogbookError(e.toString()));
    }
  }

  Future<void> _onUpdateLogbook(UpdateLogbookEvent event, Emitter<LogbookState> emit) async {
    try {
      await repository.updateLogbook(event.logbook);
      final logbooks = await repository.getLogbooks();
      emit(LogbookLoaded(logbooks));
    } catch (e) {
      emit(LogbookError(e.toString()));
    }
  }

  Future<void> _onDeleteLogbook(DeleteLogbookEvent event, Emitter<LogbookState> emit) async {
    try {
      await repository.deleteLogbook(event.id);
      final logbooks = await repository.getLogbooks();
      emit(LogbookLoaded(logbooks));
    } catch (e) {
      emit(LogbookError(e.toString()));
    }
  }

  void _onToggleExpansion(ToggleLogbookExpansion event, Emitter<LogbookState> emit) {
    if (state is LogbookLoaded) {
      final currentState = state as LogbookLoaded;
      final updatedLogbooks = currentState.logbooks.map((logbook) {
        if (logbook.id == event.id) {
          return logbook.copyWith(isExpanded: !logbook.isExpanded);
        }
        return logbook;
      }).toList();
      emit(LogbookLoaded(updatedLogbooks));
    }
  }
}