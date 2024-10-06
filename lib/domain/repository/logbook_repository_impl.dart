import 'package:intl/intl.dart';
import 'package:sitama3/domain/entities/logbook.dart';
import 'package:sitama3/domain/repository/logbook_repository.dart';

class LogbookRepositoryImpl implements LogbookRepository {
  final List<LogbookItem> _logbooks = [];
  final DateFormat dateFormat = DateFormat('dd/MM/yyyy');

  LogbookRepositoryImpl() {
    _logbooks.addAll([
      LogbookItem(
        id: '1',
        weekNumber: 3,
        date: dateFormat.parse("21/01/2024"),
        description: "Membuat desain UI/UX aplikasi MY Pertanian. " + 
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " +
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. " +
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        isExpanded: false,
      ),
      LogbookItem(
        id: '2',
        weekNumber: 2,
        date: dateFormat.parse("10/01/2024"),
        description: "Membuat desain UI/UX aplikasi MY Pertanian. " +
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " +
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. " +
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        isExpanded: false,
      ),
      LogbookItem(
        id: '3',
        weekNumber: 1,
        date: dateFormat.parse("1/01/2024"),
        description: "Membuat desain UI/UX aplikasi MY Pertanian. " +
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. " +
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. " +
        "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        isExpanded: false,
      ),
    ]);
  }

  @override
  Future<List<LogbookItem>> getLogbooks() async {
    await Future.delayed(const Duration(milliseconds: 5));
    return _logbooks;
  }

  @override
  Future<void> addLogbook(LogbookItem logbook) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _logbooks.add(logbook);
  }

  @override
  Future<void> updateLogbook(LogbookItem logbook) async {
    await Future.delayed(const Duration(milliseconds: 0));
    final index = _logbooks.indexWhere((item) => item.id == logbook.id);
    if (index != -1) {
      _logbooks[index] = logbook;
    }
  }

  @override
  Future<void> deleteLogbook(String id) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _logbooks.removeWhere((item) => item.id == id);
  }
}