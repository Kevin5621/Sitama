import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/logbook_item.dart';
import '../Models/search_field.dart';

class LogBookPage extends StatefulWidget {
  const LogBookPage({Key? key}) : super(key: key);

  @override
  _LogBookPageState createState() => _LogBookPageState();
}

class _LogBookPageState extends State<LogBookPage> {
  List<LogBookItem> logBookItems = [
    LogBookItem(
      week: "Minggu 3",
      date: DateTime(2024, 1, 21),
      description: "Membuat desain UI/UX aplikasi aplikasi MY Pertanim...", title: '',
    ),
    LogBookItem(
      week: "Minggu 2",
      date: DateTime(2024, 1, 14),
      description: "Membuat desain UI/UX aplikasi aplikasi MY Pertanim...", title: '',
    ),
    LogBookItem(
      week: "Minggu 1",
      date: DateTime(2024, 1, 7),
      description: "Membuat desain UI/UX aplikasi aplikasi MY Pertanim...", title: '',
    ),
  ];

  String _searchQuery = '';

  List<LogBookItem> get filteredItems {
    return logBookItems.where((item) {
      return item.week.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddLogBookDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            onFilterPressed: () {
              // Implement filter functionality if needed
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return LogBookItemWidget(
                  item: filteredItems[index],
                  onEdit: (updatedItem) {
                    setState(() {
                      int originalIndex = logBookItems.indexWhere((item) => 
                        item.week == updatedItem.week && item.date == updatedItem.date
                      );
                      if (originalIndex != -1) {
                        logBookItems[originalIndex] = updatedItem;
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddLogBookDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String week = '';
        DateTime date = DateTime.now();
        String description = '';

        return AlertDialog(
          title: const Text('Add Log Book Entry'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Week'),
                onChanged: (value) => week = value,
              ),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != date) {
                    setState(() {
                      date = picked;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat('dd/MM/yyyy').format(date)),
                ),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onChanged: (value) => description = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  logBookItems.add(LogBookItem(
                    week: week,
                    date: date,
                    description: description, title: '',
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}