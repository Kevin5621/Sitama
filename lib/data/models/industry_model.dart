import 'package:equatable/equatable.dart';

class IndustryModel extends Equatable {
  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  const IndustryModel({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  factory IndustryModel.fromJson(Map<String, dynamic> json) {
    return IndustryModel(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [id, name, startDate, endDate];
}