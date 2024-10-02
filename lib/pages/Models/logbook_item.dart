import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogBookItem {
  final String title;
  final String week;
  final DateTime date;
  final String description;

  LogBookItem({
    required this.title,
    required this.week,
    required this.date,
    required this.description,
  });
}

class LogBookItemWidget extends StatelessWidget {
  final LogBookItem item;
  final Function(LogBookItem) onEdit;

  const LogBookItemWidget({
    Key? key,
    required this.item,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(item.week),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(item.date)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _showEditDialog(context),
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newDescription = item.description;
        return AlertDialog(
          title: const Text('Edit Log Book'),
          content: TextField(
            maxLines: 5,
            decoration: const InputDecoration(hintText: 'Enter new description'),
            onChanged: (value) {
              newDescription = value;
            },
            controller: TextEditingController(text: item.description),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                onEdit(LogBookItem(
                  title: item.title,
                  week: item.week,
                  date: item.date,
                  description: newDescription,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}