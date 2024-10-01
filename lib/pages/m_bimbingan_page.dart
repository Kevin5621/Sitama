import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@immutable
class MBimbinganPage extends StatefulWidget {
  const MBimbinganPage({Key? key}) : super(key: key);

  @override
  _MBimbinganPageState createState() => _MBimbinganPageState();
}

class _MBimbinganPageState extends State<MBimbinganPage> {

  List<BimbinganItem> bimbinganItems = [
    BimbinganItem(
      title: "Bimbingan 8",
      date: DateTime(2024, 1, 28),
      status: BimbinganStatus.revisi,
      description: "Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi",
    ),
    BimbinganItem(
      title: "Bimbingan 8",
      date: DateTime(2024, 1, 28),
      status: BimbinganStatus.pending,
      description: "Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi",
      fileUrl: "Lucas Bimbingan7.pdf",
      fileSize: "5 MB",
    ),
    BimbinganItem(
      title: "Bimbingan 8",
      date: DateTime(2024, 1, 28),
      status: BimbinganStatus.approved,
      description: "Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi",
      fileUrl: "Lucas Bimbingan7.pdf",
      fileSize: "5 MB",
    ),
  ];

  String _searchQuery = '';
  BimbinganStatus? _filterStatus;

  List<BimbinganItem> get filteredItems {
    return bimbinganItems.where((item) {
      final matchesSearch = item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter = _filterStatus == null || item.status == _filterStatus;
      return matchesSearch && matchesFilter;
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bimbingan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showTambahBimbinganDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchField(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return BimbinganItemWidget(
                  item: filteredItems[index],
                  onEdit: () {
                    _showEditBimbinganDialog(context, filteredItems[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding SearchField() {
    return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: _showFilterDialog,
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
        );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('All'),
                leading: Radio<BimbinganStatus?>(
                  value: null,
                  groupValue: _filterStatus,
                  onChanged: (BimbinganStatus? value) {
                    setState(() {
                      _filterStatus = value;
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              ...BimbinganStatus.values.map((status) {
                return ListTile(
                  title: Text(status.toString().split('.').last),
                  leading: Radio<BimbinganStatus?>(
                    value: status,
                    groupValue: _filterStatus,
                    onChanged: (BimbinganStatus? value) {
                      setState(() {
                        _filterStatus = value;
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showTambahBimbinganDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TambahBimbinganDialog(
          onSave: (BimbinganItem newItem) {
            setState(() {
              bimbinganItems.add(newItem);
            });
          },
        );
      },
    );
  }

  void _showEditBimbinganDialog(BuildContext context, BimbinganItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditBimbinganDialog(
          item: item,
          onSave: (BimbinganItem updatedItem) {
            setState(() {
              int index = bimbinganItems.indexOf(item);
              bimbinganItems[index] = updatedItem;
            });
          },
        );
      },
    );
  }
}

@immutable
  class BimbinganItem {
    final String title;
    final DateTime date;
    final BimbinganStatus status;
    final String description;
    final String? fileUrl;
    final String? fileSize;

    const BimbinganItem({
      required this.title,
      required this.date,
      required this.status,
      required this.description,
      this.fileUrl,
      this.fileSize,
    });
  }

  enum BimbinganStatus { revisi, pending, approved }

@immutable
class BimbinganItemWidget extends StatelessWidget {
  final BimbinganItem item;
  final VoidCallback onEdit;

  const BimbinganItemWidget({
    Key? key,
    required this.item,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: item.status == BimbinganStatus.revisi ? Colors.orange[100] : null,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Stack(
          children: [
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              leading: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _getStatusIcon(),
              ),
              title: Center(child: Text(item.title)),
              subtitle: Center(child: Text(DateFormat('dd/MM/yyyy').format(item.date))),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.description, textAlign: TextAlign.left),
                      if (item.fileUrl != null)
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.file_present),
                          title: Text(item.fileUrl!),
                          trailing: Text(item.fileSize!),
                        ),
                      if (item.status != BimbinganStatus.approved)
                        ElevatedButton(
                          onPressed: onEdit,
                          child: const Text('Edit'),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            if (item.status == BimbinganStatus.revisi)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon() {
    switch (item.status) {
      case BimbinganStatus.revisi:
        return const Icon(Icons.warning, color: Colors.orange);
      case BimbinganStatus.pending:
        return const Icon(Icons.remove_circle, color: Colors.grey);
      case BimbinganStatus.approved:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }
}

@immutable
class TambahBimbinganDialog extends StatefulWidget {
  final Function(BimbinganItem) onSave;

  const TambahBimbinganDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  _TambahBimbinganDialogState createState() => _TambahBimbinganDialogState();
}

class _TambahBimbinganDialogState extends State<TambahBimbinganDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late DateTime _date = DateTime.now();
  late String _description;
  String? _fileUrl;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Bimbingan'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
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
                decoration: const InputDecoration(labelText: 'Kegiatan bimbingan anda'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload File'),
                onPressed: () {
                  // TODO: Implement file upload
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
                status: BimbinganStatus.pending,
                description: _description,
                fileUrl: _fileUrl,
              ));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

@immutable
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

  @override
  void initState() {
    super.initState();
    _title = widget.item.title;
    _date = widget.item.date;
    _description = widget.item.description;
    _fileUrl = widget.item.fileUrl;
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
                decoration: const InputDecoration(labelText: 'Kegiatan bimbingan anda'),
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _fileUrl = null;
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
                fileSize: widget.item.fileSize,
              ));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}