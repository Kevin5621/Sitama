// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:intl/intl.dart';

import 'package:sistem_magang/domain/entities/guidance_entity.dart';

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
                  id: data.id,
                  title: data.title,
                  activity: data.activity,
                  date: data.date,
                  lecturer_note: data.lecturer_note,
                  name_file: data.name_file,
                  status: data.status,
                ))
            .toList());
  }
}

class GuidanceModel {
  final int id;
  final String title;
  final String activity;
  final DateTime date;
  final String lecturer_note;
  final String name_file;
  final String status;

  GuidanceModel({
    required this.id,
    required this.title,
    required this.activity,
    required this.date,
    required this.lecturer_note,
    required this.name_file,
    required this.status,
  });

  factory GuidanceModel.fromMap(Map<String, dynamic> map) {
    return GuidanceModel(
      id: map['id'] as int,
      title: map['title'] as String,
      activity: map['activity'] as String,
      date: DateFormat('yyyy-MM-dd').parse(map['date'] as String),
      lecturer_note: map['lecturer_note'] != null
          ? map['lecturer_note'] as String
          : 'tidak ada catatan',
      name_file: map['name_file'] != null
          ? map['name_file'] as String
          : 'tidak ada file',
      status: map['status'] as String,
    );
  }
}

class AddGuidanceReqParams {
  final String title;
  final String activity;
  final DateTime date;

  AddGuidanceReqParams({
    required this.title,
    required this.activity,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return <String, dynamic>{
      'title': title,
      'activity': activity,
      'date': formattedDate,
    };
  }
}

class EditGuidanceReqParams {
  final int id;
  final String title;
  final String activity;
  final DateTime date;

  EditGuidanceReqParams({
    required this.id,
    required this.title,
    required this.activity,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return <String, dynamic>{
      'title': title,
      'activity': activity,
      'date': formattedDate,
    };
  }
}
