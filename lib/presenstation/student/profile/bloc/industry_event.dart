import 'package:equatable/equatable.dart';

abstract class IndustryEvent extends Equatable {
  const IndustryEvent();

  @override
  List<Object?> get props => [];
}

class FetchIndustryData extends IndustryEvent {
  const FetchIndustryData();
}