import 'package:flutter/foundation.dart';

enum BimbinganStatus { revisi, pending, approved }

@immutable
class BimbinganItem {
  final String title;
  final DateTime date;
  final BimbinganStatus status;
  final String description;
  final String? fileUrl;
  final String? fileSize;

  const BimbinganItem({
    required this.title,
    required this.date,
    required this.status,
    required this.description,
    this.fileUrl,
    this.fileSize,
  });
}