class LogbookItem {
  final String id;
  final int weekNumber;
  final DateTime date;
  final String title;  // Tambahkan kembali title
  final String description;
  final bool isExpanded;

  LogbookItem({
    required this.id,
    required this.weekNumber,
    required this.date,
    required this.title,  // Jangan lupa tambahkan ini
    required this.description,
    this.isExpanded = false,
  });

  LogbookItem copyWith({
    String? id,
    int? weekNumber,
    DateTime? date,
    String? title,
    String? description,
    bool? isExpanded,
  }) {
    return LogbookItem(
      id: id ?? this.id,
      weekNumber: weekNumber ?? this.weekNumber,
      date: date ?? this.date,
      title: title ?? this.title,  // Jangan lupa tambahkan ini
      description: description ?? this.description,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
