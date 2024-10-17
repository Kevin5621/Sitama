import 'package:sistem_magang/domain/entities/guidance_entity.dart';
import 'package:sistem_magang/domain/entities/student_home_entity.dart';

class DetailStudentEntity {
  final InfoStudentEntity student;
  final List<InternshipStudentEntity> internships;
  final List<GuidanceEntity> guidances;
  final List<LogBookEntity> log_book;

  DetailStudentEntity(
      {required this.student,
      required this.internships,
      required this.guidances,
      required this.log_book});
}

class InfoStudentEntity {
  final String name;
  final String username;
  final String email;

  InfoStudentEntity(
      {required this.name, required this.username, required this.email});
}

class InternshipStudentEntity {
  final String name;
  final DateTime start_date;
  final DateTime ? end_date;

  InternshipStudentEntity(
      {required this.name,
      required this.start_date,
      required this.end_date});
}
