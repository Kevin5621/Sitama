import 'package:flutter/material.dart';

class FilterProdi extends StatefulWidget {
  @override
  _FilterProdiState createState() => _FilterProdiState();
}

class _FilterProdiState extends State<FilterProdi> {
  String _selectedProdi = 'D3 - Informatika';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Prodi'),
      ),
      body: Center(
        child: DropdownButton(
          value: _selectedProdi,
          onChanged: (String? newValue) {
            setState(() {
              _selectedProdi = newValue!;
            });
          },
          items: [
            'D3 - Informatika',
            'D3 - Elektronika',
            'DE - Telekomunikasi',
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
