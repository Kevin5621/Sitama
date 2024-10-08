import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/config/themes/app_color.dart';

class LogBookItem {
  final String title;
  final DateTime date;
  String description;

  LogBookItem({
    required this.title,
    required this.date,
    required this.description,
  });
}

class LogBookCard extends StatelessWidget {
  final LogBookItem item;
  final Function(LogBookItem) onEdit;

  const LogBookCard({
    Key? key,
    required this.item,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: AppColors.white,
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
                  Text(item.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
