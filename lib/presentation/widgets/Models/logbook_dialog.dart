import 'package:flutter/material.dart';
import 'package:sitama3/utils/date_formatter.dart';
import '../guidance/logbook_item.dart';

class LogbookDialog extends StatefulWidget {
  final dynamic logbook;

  const LogbookDialog({Key? key, this.logbook, required onSave}) : super(key: key);

  @override
  _LogbookDialogState createState() => _LogbookDialogState();
}

class _LogbookDialogState extends State<LogbookDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.logbook?.title ?? '');
    _descriptionController = TextEditingController(text: widget.logbook?.description ?? '');
    _selectedDate = widget.logbook?.date ?? DateTime.now();
    _dateController = TextEditingController(text: DateFormatter.toDisplayDate(_selectedDate!));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormatter.toDisplayDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.logbook == null ? 'Add Logbook' : 'Edit Logbook'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final logbook = LogbookItem(
                id: widget.logbook?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                title: _titleController.text,
                description: _descriptionController.text,
                date: _selectedDate!,
                weekNumber: _selectedDate!.weekOfYear, 
              );
              Navigator.of(context).pop(logbook);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

extension DateTimeExtension on DateTime {
  int get weekOfYear {
    final startOfYear = DateTime(year, 1, 1);
    final firstMonday = startOfYear.weekday;
    final daysInFirstWeek = 8 - firstMonday;
    final diff = difference(startOfYear);
    var weeks = ((diff.inDays - daysInFirstWeek) / 7).ceil();
    if (daysInFirstWeek > 3) {
      weeks += 1;
    }
    return weeks;
  }
}