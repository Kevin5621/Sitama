import 'package:sitama3/domain/entities/logbook.dart';

abstract class LogbookRepository {
  Future<List<LogbookItem>> getLogbooks();
  Future<void> addLogbook(LogbookItem logbook);
  Future<void> updateLogbook(LogbookItem logbook);
  Future<void> deleteLogbook(String id);
}