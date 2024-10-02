import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/bimbingan_item.dart';

class BimbinganItemWidget extends StatelessWidget {
  final BimbinganItem item;
  final VoidCallback onEdit;

  const BimbinganItemWidget({
    Key? key,
    required this.item,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: _getCardColor(),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: _getStatusIcon(),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(DateFormat('dd/MM/yyyy').format(item.date),
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description, textAlign: TextAlign.left),
                  if (item.fileUrl != null)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.attach_file),
                      title: Text(item.fileUrl!),
                      subtitle: Text(item.fileSize ?? ''),
                    ),
                  const SizedBox(height: 8),
                  if (item.status != BimbinganStatus.approved)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: onEdit,
                          child: Row(
                            children: const [
                              Icon(Icons.edit, size: 16),
                              SizedBox(width: 4),
                              Text('Edit'),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon() {
    switch (item.status) {
      case BimbinganStatus.revisi:
        return const Icon(Icons.warning, color: Colors.orange);
      case BimbinganStatus.pending:
        return const Icon(Icons.remove_circle, color: Colors.grey);
      case BimbinganStatus.approved:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }

  Color _getCardColor() {
    if (item.status == BimbinganStatus.revisi) {
      return Colors.orange.withOpacity(0.1);
    }
    return Colors.white;
  }
}

enum BimbinganStatus { revisi, pending, approved }

class BimbinganItem {
  final String title;
  final DateTime date;
  final String description;
  final String? fileUrl;
  final String? fileSize;
  final BimbinganStatus status;

  BimbinganItem({
    required this.title,
    required this.date,
    required this.description,
    this.fileUrl,
    this.fileSize,
    required this.status,
  });
}