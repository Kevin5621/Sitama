import 'package:flutter/material.dart';

class FilterTahun extends StatefulWidget {
  @override
  _FilterTahunState createState() => _FilterTahunState();
}

class _FilterTahunState extends State<FilterTahun> {
  String _selectedTahun = '2024/2025';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Tahun'),
      ),
      body: Center(
        child: DropdownButton(
          value: _selectedTahun,
          onChanged: (String? newValue) {
            setState(() {
              _selectedTahun = newValue!;
            });
          },
          items: [
            '2024/2025',
            '2023/2024',
            '2022/2023',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
        ),
      ),
    );
  }
}
