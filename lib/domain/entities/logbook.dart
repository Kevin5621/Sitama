class Logbook {
  final String id;
  final int weekNumber;
  final DateTime date;
  final String description;
  final bool isExpanded;

  Logbook({
    required this.id,
    required this.weekNumber,
    required this.date,
    required this.description,
    this.isExpanded = false,
  });

  Logbook copyWith({
    String? id,
    int? weekNumber,
    DateTime? date,
    String? description,
    bool? isExpanded,
  }) {
    return Logbook(
      id: id ?? this.id,
      weekNumber: weekNumber ?? this.weekNumber,
      date: date ?? this.date,
      description: description ?? this.description,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}

abstract class LogbookRepository {
  Future<List<Logbook>> getLogbooks();
  Future<void> addLogbook(Logbook logbook);
  Future<void> updateLogbook(Logbook logbook);
  Future<void> deleteLogbook(String id);
}