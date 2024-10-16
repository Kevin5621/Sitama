import 'package:flutter/material.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

class LecturerGuidanceTab extends StatelessWidget {
  const LecturerGuidanceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return LecturerGuidanceCard(type: index % 4);
      },
    );
  }
}

class LecturerGuidanceCard extends StatefulWidget {
  final int type;

  const LecturerGuidanceCard({super.key, required this.type});

  @override
  _LecturerGuidanceCardState createState() => _LecturerGuidanceCardState();
}

class _LecturerGuidanceCardState extends State<LecturerGuidanceCard> {
  late int currentType;
  String revisionText = '';

  @override
  void initState() {
    super.initState();
    currentType = widget.type;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: currentType == 3 ? AppColors.danger500 : AppColors.white,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: _buildLeadingIcon(),
          title: Text('Bimbingan ${widget.type + 1}'),
          subtitle: const Text('28/01/2024'),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Kegiatan Anda:'),
                  const Text('1. Bab 1 - Pendahuluan: Latar belakang magang'),
                  const Text('2. Pembahasan Kegiatan Magang'),
                  const Text('3. Analisis dan Evaluasi'),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Masukkan revisi...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      revisionText = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.done),
                        label: const Text(
                          'Confitm',
                          style: TextStyle(color: AppColors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () => _showConfirmationDialog(0),
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.cancel),
                        label: const Text(
                          'Cancel',
                          style: TextStyle(color: AppColors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () => _showConfirmationDialog(3),
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

  Widget _buildLeadingIcon() {
    switch (currentType) {
      case 0:
        return const Icon(Icons.check_circle, color: AppColors.success);
      case 1:
        return const Icon(Icons.remove_circle, color: AppColors.gray);
      case 2:
        return const Icon(Icons.add_circle, color: AppColors.gray);
      case 3:
        return const Icon(Icons.error, color: AppColors.danger);
      default:
        return const Icon(Icons.circle, color: AppColors.gray);
    }
  }

  void _showConfirmationDialog(int newType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: Text(
              'Apakah Anda yakin ingin ${newType == 0 ? 'menyetujui' : 'merevisi'} bimbingan ini?'),
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
                setState(() {
                  currentType = newType;
                });
                Navigator.of(context).pop();
                // Tambahkan logika untuk menyimpan revisi jika diperlukan
              },
              child: const Text('Ya'),
            ),
          ],
        );
      },
    );
  }
}
