import 'package:flutter/material.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

class LecturerLogBookTab extends StatelessWidget {
  const LecturerLogBookTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8),
          color: AppColors.white,
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: Text('Log Book Entry ${index + 1}'),
              subtitle: Text(
                  'Date: ${DateTime.now().subtract(Duration(days: index)).toString().split(' ')[0]}'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'),
                      const SizedBox(height: 16),
                      const Text('Komentar Dosen:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Tambahkan komentar di sini...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Implementasi logika untuk menyimpan komentar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Komentar berhasil disimpan')),
                          );
                        },
                        child: const Text('Simpan Komentar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
