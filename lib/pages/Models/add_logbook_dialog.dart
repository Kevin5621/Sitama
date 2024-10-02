import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'logbook_item.dart';

class AddLogBookDialog extends StatefulWidget {
  final Function(LogBookItem) onSave;

  const AddLogBookDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddLogBookDialogState createState() => _AddLogBookDialogState();
}

class _AddLogBookDialogState extends State<AddLogBookDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _week;
  late DateTime _date = DateTime.now();
  late String _description;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Log Book Entry'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null && picked != _date) {
                    setState(() {
                      _date = picked;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat('dd/MM/yyyy').format(_date)),
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Save'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSave(LogBookItem(
                title: _title,
                week: _week,
                date: _date,
                description: _description,
              ));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}