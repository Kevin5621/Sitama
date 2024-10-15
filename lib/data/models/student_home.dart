// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:sistem_magang/data/models/guidance.dart';
import 'package:sistem_magang/domain/entities/guidance_entity.dart';
import 'package:sistem_magang/domain/entities/student_home_entity.dart';

class StudentHomeModel {
  final String name;
  final List<GuidanceModel> latest_guidances;
  final List<LogBookModel> latest_log_books;

  StudentHomeModel({
    required this.name,
    required this.latest_guidances,
    required this.latest_log_books,
  });

  factory StudentHomeModel.fromMap(Map<String, dynamic> map) {
    return StudentHomeModel(
      name: map['name'] as String,
      latest_guidances: List<GuidanceModel>.from(
        (map['latest_guidances'] as List<dynamic>).map<GuidanceModel>(
          (x) => GuidanceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      latest_log_books: List<LogBookModel>.from(
        (map['latest_log_books'] as List<dynamic>).map<LogBookModel>(
          (x) => LogBookModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

extension StudentHomeXModel on StudentHomeModel {
  StudentHomeEntity toEntity() {
    return StudentHomeEntity(
      name: name,
      latest_guidances: latest_guidances
          .map<GuidanceEntity>((data) => GuidanceEntity(
                id: data.id,
                title: data.title,
                activity: data.activity,
                date: data.date,
                lecturer_note: data.lecturer_note,
                name_file: data.name_file,
                status: data.status,
              ))
          .toList(),
      latest_log_books: latest_log_books
          .map<LogBookEntity>((data) => LogBookEntity(
              title: data.title, activity: data.activity, date: data.date))
          .toList(),
    );
  }
}

class LogBookModel {
  final String title;
  final String activity;
  final String date;

  LogBookModel(
      {required this.title, required this.activity, required this.date});

  factory LogBookModel.fromMap(Map<String, dynamic> map) {
    return LogBookModel(
      title: map['title'] as String,
      activity: map['activity'] as String,
      date: map['date'] as String,
    );
  }
}
