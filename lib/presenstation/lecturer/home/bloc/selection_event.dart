import 'package:equatable/equatable.dart';

abstract class SelectionEvent extends Equatable {
  const SelectionEvent();

  @override
  List<Object> get props => [];
}

class ToggleSelectionMode extends SelectionEvent {}

class ToggleItemSelection extends SelectionEvent {
  final int id;

  const ToggleItemSelection(this.id);

  @override
  List<Object> get props => [id];
}

class SelectAll extends SelectionEvent {}

class DeselectAll extends SelectionEvent {}

class SendMessage extends SelectionEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object> get props => [message];
}
