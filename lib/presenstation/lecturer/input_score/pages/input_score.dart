import 'package:flutter/material.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

class InputScorePage extends StatefulWidget {
  const InputScorePage({Key? key}) : super(key: key);

  @override
  _InputScorePageState createState() => _InputScorePageState();
}

class _InputScorePageState extends State<InputScorePage> {
  final TextEditingController _proposalController = TextEditingController();
  final TextEditingController _laporanController = TextEditingController();
  final TextEditingController _nilaiIndustriController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai Dosen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input untuk Proposal
            _buildInputField(
              context,
              label: 'Proposal',
              controller: _proposalController,
              icon: Icons.description,
            ),
            const SizedBox(height: 16.0),

            // Input untuk Laporan
            _buildInputField(
              context,
              label: 'Laporan',
              controller: _laporanController,
              icon: Icons.insert_drive_file,
            ),
            const SizedBox(height: 16.0),

            // Input untuk Nilai Industri
            _buildInputField(
              context,
              label: 'Nilai Industri',
              controller: _nilaiIndustriController,
              icon: Icons.work,
            ),
            const SizedBox(height: 32.0),

            // Card untuk menampilkan Nilai Akhir
            _buildNilaiAkhirCard(),

            const SizedBox(height: 32.0),

            // Tombol Update
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _onSubmitNilai,
                  child: const Text('Update'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk Input Field
  Widget _buildInputField(BuildContext context,
      {required String label,
      required TextEditingController controller,
      required IconData icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
    );
  }

  // Card untuk menampilkan Nilai Akhir
  Widget _buildNilaiAkhirCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Nilai Akhir',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary500,
              child: Text(
                'XX',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                    ),
              ),
            ),
            const SizedBox(height: 16),

            // Menampilkan nilai dosen dan industri
            _buildNilaiRow('Nilai Dosen', 'XX'),
            const SizedBox(height: 8),
            _buildNilaiRow('Nilai Industri', 'XX'),
          ],
        ),
      ),
    );
  }

  // Widget untuk Row Nilai
  Widget _buildNilaiRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  // Fungsi untuk mengirim nilai
  void _onSubmitNilai() {
    // Implementasi submit nilai
    print('Submit nilai');
  }

  @override
  void dispose() {
    _proposalController.dispose();
    _laporanController.dispose();
    _nilaiIndustriController.dispose();
    super.dispose();
  }
}
