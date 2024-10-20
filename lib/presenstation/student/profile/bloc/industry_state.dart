import 'package:equatable/equatable.dart';
import 'package:sistem_magang/data/models/industry_model.dart';

abstract class IndustryState extends Equatable {
  const IndustryState();

  @override
  List<Object?> get props => [];
}

class IndustryInitial extends IndustryState {
  const IndustryInitial();
}

class IndustryLoading extends IndustryState {
  const IndustryLoading();
}

class IndustryLoaded extends IndustryState {
  final IndustryModel industry;
  
  const IndustryLoaded(this.industry);
  
  @override
  List<Object?> get props => [industry];
}

class IndustryEmpty extends IndustryState {
  const IndustryEmpty();
}

class IndustryError extends IndustryState {
  final String message;
  
  const IndustryError(this.message);
  
  @override
  List<Object?> get props => [message];
}