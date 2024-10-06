class LogbookItem {
  final String id;
  final int weekNumber;
  final DateTime date;  // Ubah String menjadi DateTime
  final String description;
  final bool isExpanded;

  LogbookItem({
    required this.id,
    required this.weekNumber,
    required this.date,  // Ubah di sini juga
    required this.description,
    this.isExpanded = false,
  });

  LogbookItem copyWith({
    String? id,
    int? weekNumber,
    DateTime? date,  // Ubah tipe di sini juga
    String? description,
    bool? isExpanded,
  }) {
    return LogbookItem(
      id: id ?? this.id,
      weekNumber: weekNumber ?? this.weekNumber,
      date: date ?? this.date,  // Pastikan tipe sesuai
      description: description ?? this.description,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}
