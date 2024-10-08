import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'guidance_item.dart';

class EditBimbinganDialog extends StatefulWidget {
  final BimbinganItem item;
  final Function(BimbinganItem) onSave;

  const EditBimbinganDialog({
    Key? key,
    required this.item,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditBimbinganDialogState createState() => _EditBimbinganDialogState();
}

class _EditBimbinganDialogState extends State<EditBimbinganDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _date;
  late String _description;
  String? _fileUrl;
  String? _fileSize;

  @override
  void initState() {
    super.initState();
    _title = widget.item.title;
    _date = widget.item.date;
    _description = widget.item.description;
    _fileUrl = widget.item.fileUrl;
    _fileSize = widget.item.fileSize;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Bimbingan'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Judul'),
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
                    labelText: 'Tanggal',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(DateFormat('dd/MM/yyyy').format(_date)),
                ),
              ),
              TextFormField(
                initialValue: _description,
                decoration:
                    const InputDecoration(labelText: 'Kegiatan bimbingan anda'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              if (_fileUrl != null)
                ListTile(
                  leading: const Icon(Icons.file_present),
                  title: Text(_fileUrl!),
                  subtitle: Text(_fileSize ?? ''),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _fileUrl = null;
                        _fileSize = null;
                      });
                    },
                  ),
                ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload File'),
                onPressed: () {
                  // TODO: Implement file upload
                  // For now, we'll just set dummy values
                  setState(() {
                    _fileUrl = 'dummy_file.pdf';
                    _fileSize = '1 MB';
                  });
                },
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
          child: const Text('Simpan'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSave(BimbinganItem(
                title: _title,
                date: _date,
                status: widget.item.status,
                description: _description,
                fileUrl: _fileUrl,
                fileSize: _fileSize,
              ));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
