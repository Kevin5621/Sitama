import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitama3/config/theme/theme.dart';
import 'package:sitama3/domain/entities/logbook.dart';

class LogbookCard extends StatelessWidget {
  final Logbook logbook;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const LogbookCard({
    Key? key,
    required this.logbook,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                'Minggu ${logbook.weekNumber}',
                style: theme.textTheme.headlineSmall,
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy').format(logbook.date),
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppTheme.primary),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppTheme.danger),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
            if (logbook.isExpanded)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  logbook.description,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
          ],
        ),
      ),
    );
  }
}