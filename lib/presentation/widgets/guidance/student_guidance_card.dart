import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../config/theme/theme.dart';

enum GuidanceStatus { revisi, pending, approved }

class GuidanceCard extends StatelessWidget {
  final String title;
  final DateTime date;
  final GuidanceStatus status;
  final String description;

  const GuidanceCard({
    Key? key,
    required this.title,
    required this.date,
    required this.status,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      color: status == GuidanceStatus.revisi
          ? AppTheme.danger500
          : AppTheme.white,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: _getStatusIcon(),
          title: Text(title),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(date)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(description, textAlign: TextAlign.left),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon() {
    switch (status) {
      case GuidanceStatus.revisi:
        return const Icon(Icons.warning, color: AppTheme.danger);
      case GuidanceStatus.pending:
        return const Icon(Icons.remove_circle, color: Colors.grey);
      case GuidanceStatus.approved:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }
}
