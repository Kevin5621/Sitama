import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';

class InputScorePage extends StatefulWidget {
  const InputScorePage({Key? key}) : super(key: key);

  @override
  _InputScorePageState createState() => _InputScorePageState();
}

class _InputScorePageState extends State<InputScorePage> {
  final List<Map<String, dynamic>> _industryScores = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nilai Dosen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExpandableSection('Proposal', [
                'Tujuan Sasaran',
                'Kelengkapan Proposal',
                'Rata - rata',
              ]),
              const SizedBox(height: 16),
              _buildExpandableSection('Laporan', [
                'Sistematika Penulisan',
                'Bahasa',
                'Isi',
              ]),
              const SizedBox(height: 16),
              ..._industryScores.map((score) => _buildIndustryScoreCard(score)),
              const SizedBox(height: 16),
              _buildAddIndustryButton(),
              const SizedBox(height: 32.0),
              SizedBox(
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
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableSection(String title, List<String> fields) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      child: ExpansionTile(
        title: Text(title),
        leading: Icon(_getIconForTitle(title)),
        children: [
          Divider(thickness: 1, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: fields.map((field) => _buildInputField(field)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(label, style: TextStyle(fontSize: 16)),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndustryScoreCard(Map<String, dynamic> score) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: score['titleController'],
                    decoration: InputDecoration(
                      hintText: 'Judul Nilai Industri',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _removeIndustryScore(score),
                ),
              ],
            ),
            Divider(thickness: 1, height: 1),
            const SizedBox(height: 16),
            _buildInputField('Tanggal Mulai'),
            _buildInputField('Tanggal Selesai'),
            _buildInputField('Nilai'),
          ],
        ),
      ),
    );
  }

  Widget _buildAddIndustryButton() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]!, width: 1),
      ),
      child: InkWell(
        onTap: _addIndustryScore,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Tambah Nilai Industri', style: TextStyle(color: AppColors.primary)),
            ],
          ),
        ),
      ),
    );
  }

  void _addIndustryScore() {
    setState(() {
      _industryScores.add({
        'titleController': TextEditingController(text: 'Nilai Industri ${_industryScores.length + 1}'),
        'startDate': TextEditingController(),
        'endDate': TextEditingController(),
        'score': TextEditingController(),
      });
    });
  }

  void _removeIndustryScore(Map<String, dynamic> score) {
    setState(() {
      _industryScores.remove(score);
    });
  }

  IconData _getIconForTitle(String title) {
    switch (title) {
      case 'Proposal':
        return Icons.description;
      case 'Laporan':
        return Icons.insert_drive_file;
      default:
        return Icons.article;
    }
  }

  void _onSubmitNilai() {
    // Implement submit logic 
    print('Submitting nilai');
  }

  @override
  void dispose() {
    for (var score in _industryScores) {
      score['titleController'].dispose();
      score['startDate'].dispose();
      score['endDate'].dispose();
      score['score'].dispose();
    }
    super.dispose();
  }
}