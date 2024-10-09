import 'package:sitama3/domain/entities/guidance_entity.dart';

class StudentHomeEntity {
  final String name;
  final List<GuidanceEntity> latest_guidances;
  final List<LogBookEntity> latest_log_books;

  StudentHomeEntity({required this.name, required this.latest_guidances, required this.latest_log_books});

}



class LogBookEntity {
  final String title;
  final String activity;
  final String date;

  LogBookEntity({required this.title, required this.activity, required this.date});
}
