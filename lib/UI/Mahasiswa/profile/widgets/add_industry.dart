import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class MAddIndustryPage extends StatefulWidget {
  const MAddIndustryPage({Key? key}) : super(key: key);

  @override
  _MAddIndustryPageState createState() => _MAddIndustryPageState();
}

class _MAddIndustryPageState extends State<MAddIndustryPage> {
  final TextEditingController _industryController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Industri'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _industryController,
              decoration: const InputDecoration(
                labelText: 'Industri',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            
            InkWell(
              onTap: () => _selectStartDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Mulai',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _startDate == null
                      ? ''
                      : DateFormat.yMMMd().format(_startDate!),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            
            InkWell(
              onTap: () => _selectEndDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Tanggal Selesai',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _endDate == null
                      ? ''
                      : DateFormat.yMMMd().format(_endDate!),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            
            ElevatedButton(
              onPressed: () {
                String industry = _industryController.text;
                if (industry.isNotEmpty && _startDate != null && _endDate != null) {
                  ('Industry: $industry');
                  ('Start Date: ${DateFormat.yMMMd().format(_startDate!)}');
                  ('End Date: ${DateFormat.yMMMd().format(_endDate!)}');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please complete the form')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white
              ),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}