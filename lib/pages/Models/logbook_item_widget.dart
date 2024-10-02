import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'logbook_item.dart';

class LogBookItemWidget extends StatelessWidget {
  final LogBookItem item;
  final VoidCallback onEdit;

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
          title: Text(item.title),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(item.date)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description, textAlign: TextAlign.left),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onEdit,
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
}