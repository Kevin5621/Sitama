import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitama3/domain/entities/logbook.dart';

import '../../../../core/config/theme/app_color.dart';

class LogbookCard extends StatelessWidget {
  final LogbookItem logbook;
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
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                logbook.title,  
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
                    icon: const Icon(Icons.edit, color: AppColors.primary),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.danger),
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