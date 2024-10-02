import 'package:flutter/material.dart';
import 'bimbingan_item.dart';


class StatusIconHelper {
  static Widget getStatusIcon(BimbinganStatus status) {
    switch (status) {
      case BimbinganStatus.revisi:
        return const Icon(Icons.warning, color: Colors.orange);
      case BimbinganStatus.pending:
        return const Icon(Icons.remove_circle, color: Colors.grey);
      case BimbinganStatus.approved:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }
}