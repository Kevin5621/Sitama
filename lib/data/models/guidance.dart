import 'package:sitama3/domain/entities/guidance_entity.dart';

class ListGuidanceModel {
  final List<GuidanceModel> guidances;

  ListGuidanceModel({required this.guidances});

  factory ListGuidanceModel.fromMap(Map<String, dynamic> map) {
    return ListGuidanceModel(
      guidances: List<GuidanceModel>.from(
        (map['guidances'] as List<dynamic>).map<GuidanceModel>(
          (x) => GuidanceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

extension ListGuidanceXModel on ListGuidanceModel {
  ListGuidanceEntity toEntity() {
    return ListGuidanceEntity(
        guidances: guidances
            .map<GuidanceEntity>((data) => GuidanceEntity(
                title: data.title,
                activity: data.activity,
                date: data.date,
                lecturer_note: data.lecturer_note,
                name_file: data.name_file,
                status: data.status))
            .toList());
  }
}

class GuidanceModel {
  final String title;
  final String activity;
  final String date;
  final String lecturer_note;
  final String name_file;
  final String status;

  GuidanceModel({
    required this.title,
    required this.activity,
    required this.date,
    required this.lecturer_note,
    required this.name_file,
    required this.status,
  });

  factory GuidanceModel.fromMap(Map<String, dynamic> map) {
    return GuidanceModel(
      title: map['title'] as String,
      activity: map['activity'] as String,
      date: map['date'] as String,
      lecturer_note: map['lecturer_note'] as String,
      name_file: map['name_file'] as String,
      status: map['status'] as String,
    );
  }
}
