class LogbookItem {
  final String id;
  final int weekNumber;
  final DateTime date;
  final String description;
  final bool isExpanded;

  LogbookItem({
    required this.id,
    required this.weekNumber,
    required this.date,
    required this.description,
    this.isExpanded = false, required String title,
  });

  String get title => 'Logbook Week $weekNumber';

  LogbookItem copyWith({
    String? id,
    int? weekNumber,
    DateTime? date,
    String? description,
    bool? isExpanded,
  }) {
    return LogbookItem(
      id: id ?? this.id,
      weekNumber: weekNumber ?? this.weekNumber,
      date: date ?? this.date,
      description: description ?? this.description,
      isExpanded: isExpanded ?? this.isExpanded, title: '',
    );
  }

  static where(bool Function(dynamic item) param0) {}
}
