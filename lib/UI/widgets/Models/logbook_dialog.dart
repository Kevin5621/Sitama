import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitama3/domain/entities/logbook.dart';

class LogbookDialog extends StatefulWidget {
  final LogbookItem? logbook;
  final Function(LogbookItem) onSave;

  const LogbookDialog({
    Key? key,
    this.logbook,
    required this.onSave,
  }) : super(key: key);

  @override
  State<LogbookDialog> createState() => _LogbookDialogState();
}

class _LogbookDialogState extends State<LogbookDialog> {
  late TextEditingController _descriptionController;
  late TextEditingController _weekNumberController;
  late DateTime _selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.logbook?.description ?? '');
    _weekNumberController = TextEditingController(
      text: (widget.logbook?.weekNumber ?? '').toString(),
    );
    _selectedDate = widget.logbook?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _weekNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.logbook == null ? 'Add Logbook' : 'Edit Logbook',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _weekNumberController,
                decoration: const InputDecoration(
                  labelText: 'Week Number',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter week number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2025),
                  );
                  if (picked != null) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                  ),
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(_selectedDate),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final logbook = LogbookItem(
                id: widget.logbook?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                weekNumber: int.parse(_weekNumberController.text),
                date: _selectedDate,
                description: _descriptionController.text,
                isExpanded: false,
              );
              widget.onSave(logbook);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}