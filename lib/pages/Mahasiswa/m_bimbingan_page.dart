import 'package:flutter/material.dart';
import '../models/bimbingan_item.dart';
import '../models/bimbingan_item_widget.dart';
import '../models/search_field.dart';
import '../models/filter_dialog.dart';
import '../models/tambah_bimbingan.dart';
import '../models/edit_bimbingan_dialog.dart';

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
          SearchField(
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
            onFilterPressed: _showFilterDialog,
          ),
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

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FilterDialog(
          currentFilter: _filterStatus,
          onFilterChanged: (BimbinganStatus? value) {
            setState(() {
              _filterStatus = value;
            });
          },
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