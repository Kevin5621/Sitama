import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';
import 'package:sistem_magang/domain/entities/guidance_entity.dart';

class LecturerGuidanceTab extends StatelessWidget {
  final List<GuidanceEntity> guidances;

  const LecturerGuidanceTab({super.key, required this.guidances});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: guidances.length,
      itemBuilder: (context, index) {
        return LecturerGuidanceCard(
          guidance: guidances[index],
        );
      },
    );
  }
}

enum LecturerGuidanceStatus { approved, rejected, inProgress, updated }

class LecturerGuidanceCard extends StatefulWidget {
  final GuidanceEntity guidance; // Use GuidanceEntity directly

  const LecturerGuidanceCard({
    super.key,
    required this.guidance,
  });

  @override
  _LecturerGuidanceCardState createState() => _LecturerGuidanceCardState();
}

class _LecturerGuidanceCardState extends State<LecturerGuidanceCard> {
  late LecturerGuidanceStatus currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.guidance.status == 'approved'
        ? LecturerGuidanceStatus.approved
        : widget.guidance.status == 'in-progress'
            ? LecturerGuidanceStatus.inProgress
            : widget.guidance.status == 'rejected'
                ? LecturerGuidanceStatus.rejected
                : LecturerGuidanceStatus
                    .updated; // Set status from GuidanceEntity
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: currentStatus == LecturerGuidanceStatus.rejected
          ? AppColors.danger500
          : AppColors.white,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: _buildLeadingIcon(), // Show the status icon
          title: Text(widget.guidance.title), // Use title from GuidanceEntity
          subtitle: Text(DateFormat('dd/MM/yyyy')
              .format(widget.guidance.date)), // Use date from GuidanceEntity
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.guidance
                      .activity), // Use description from GuidanceEntity
                  const SizedBox(height: 16),
                  _buildRevisionField(),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the leading icon based on the status
  Widget _buildLeadingIcon() {
    switch (currentStatus) {
      case LecturerGuidanceStatus.approved:
        return const Icon(Icons.check_circle, color: AppColors.success);
      case LecturerGuidanceStatus.inProgress:
        return const Icon(Icons.remove_circle, color: AppColors.gray);
      case LecturerGuidanceStatus.rejected:
        return const Icon(Icons.error, color: AppColors.danger);
      case LecturerGuidanceStatus.updated:
        return const Icon(Icons.help, color: AppColors.warning);
      default:
        return const Icon(Icons.circle, color: AppColors.gray);
    }
  }

  // TextField for entering revision comments
  Widget _buildRevisionField() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Masukkan revisi...',
        border: OutlineInputBorder(),
      ),
      maxLines: 3,
      onChanged: (value) {
        // Update revision text if necessary
      },
    );
  }

  // Action buttons to approve or reject the guidance
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.check_circle_outline, color: AppColors.white),
          label:
              const Text('Confirm', style: TextStyle(color: AppColors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: () =>
              _showConfirmationDialog(LecturerGuidanceStatus.approved),
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.cancel_outlined, color: AppColors.white),
          label: const Text('Cancel', style: TextStyle(color: AppColors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          onPressed: () =>
              _showConfirmationDialog(LecturerGuidanceStatus.rejected),
        ),
      ],
    );
  }

  // Confirmation dialog to change the status
  void _showConfirmationDialog(LecturerGuidanceStatus newStatus) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text(
              'Apakah Anda yakin ingin ${newStatus == LecturerGuidanceStatus.approved ? 'menyetujui' : 'merevisi'} bimbingan ini?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
