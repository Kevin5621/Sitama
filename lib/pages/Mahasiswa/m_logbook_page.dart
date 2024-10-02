import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogBookPage extends StatefulWidget {
  const LogBookPage({Key? key}) : super(key: key);

  @override
  _LogBookPageState createState() => _LogBookPageState();
}

class _LogBookPageState extends State<LogBookPage> {
  List<LogBookItem> logBookItems = [
    LogBookItem(
      title: "Minggu 3",
      date: DateTime(2024, 1, 21),
      description: "Membuat desain UI/UX aplikasi aplikasi MY Pertanim...",
    ),
    LogBookItem(
      title: "Minggu 2",
      date: DateTime(2024, 1, 21),
      description: "Membuat desain UI/UX aplikasi aplikasi MY Pertanim...",
    ),
    LogBookItem(
      title: "Minggu 1",
      date: DateTime(2024, 1, 21),
      description: "Membuat desain UI/UX aplikasi aplikasi MY Pertanim...",
    ),
  ];

  String _searchQuery = '';

  List<LogBookItem> get filteredItems {
    return logBookItems.where((item) {
      return item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddLogBookDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Implement filter functionality if needed
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return LogBookItemWidget(
                  item: filteredItems[index],
                  onEdit: () {
                    _showEditLogBookDialog(context, filteredItems[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddLogBookDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddLogBookDialog(
          onSave: (LogBookItem newItem) {
            setState(() {
              logBookItems.add(newItem);
            });
          },
        );
      },
    );
  }

  void _showEditLogBookDialog(BuildContext context, LogBookItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditLogBookDialog(
          item: item,
          onSave: (LogBookItem updatedItem) {
            setState(() {
              int index = logBookItems.indexOf(item);
              logBookItems[index] = updatedItem;
            });
          },
        );
      },
    );
  }
}

class LogBookItem {
  final String title;
  final DateTime date;
  final String description;

  LogBookItem({
    required this.title,
    required this.date,
    required this.description,
  });
}

class LogBookItemWidget extends StatelessWidget {
  final LogBookItem item;
  final VoidCallback onEdit;

  const LogBookItemWidget({
    Key? key,
    required this.item,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(item.title),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(item.date)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description, textAlign: TextAlign.left),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: onEdit,
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddLogBookDialog extends StatefulWidget {
  final Function(LogBookItem) onSave;

  const AddLogBookDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  _AddLogBookDialogState createState() => _AddLogBookDialogState();
}

class _AddLogBookDialogState extends State<AddLogBookDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
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

class EditLogBookDialog extends StatefulWidget {
  final LogBookItem item;
  final Function(LogBookItem) onSave;

  const EditLogBookDialog({
    Key? key,
    required this.item,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditLogBookDialogState createState() => _EditLogBookDialogState();
}

class _EditLogBookDialogState extends State<EditLogBookDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _date;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.item.title;
    _date = widget.item.date;
    _description = widget.item.description;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Log Book Entry'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _title,
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
                initialValue: _description,
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