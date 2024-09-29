import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'm_bimbingan_page.dart';
import 'm_logbook_page.dart';
import 'm_settings_page.dart';

class MHomePage extends StatefulWidget {
  const MHomePage({Key? key}) : super(key: key);

  @override
  _MHomePageState createState() => _MHomePageState();
}

class _MHomePageState extends State<MHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    _HomeContent(),
    const MBimbinganPage(),
    const LogBookPage(),
    const MSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Bimbingan'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Log book'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.5),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HELLO,',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Lucas Scott',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    NotificationWidget(
                      onClose: () {
                        // Implement notification close functionality
                      },
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Bimbingan Terbaru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MBimbinganPage()),
                        );
                      },
                      child: const Row(
                        children: [
                          Text('Lihat Semua'),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => BimbinganItem(
                  title: 'Bimbingan ${8 - index}',
                  date: DateTime(2024, 1, 28 - index),
                  status: index == 0 ? BimbinganStatus.revisi : BimbinganStatus.approved,
                  description: 'Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi',
                ),
                childCount: 2,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Log Book Terbaru',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LogBookPage()),
                        );
                      },
                      child: const Row(
                        children: [
                          Text('Lihat Semua'),
                          Icon(Icons.arrow_forward_ios, size: 14),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => LogBookItemWidget(
                  item: LogBookItem(
                    week: 'Minggu ${index + 1}',
                    date: DateTime(2024, 1, 21 + index * 7),
                    description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                  ),
                  onEdit: (updatedItem) {
                    // Implement edit functionality
                  },
                ),
                childCount: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final VoidCallback onClose;

  const NotificationWidget({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline),
          const SizedBox(width: 8),
          const Expanded(child: Text('Anda belum dijadwalkan seminar')),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

enum BimbinganStatus { revisi, pending, approved }

class BimbinganItem extends StatelessWidget {
  final String title;
  final DateTime date;
  final BimbinganStatus status;
  final String description;

  const BimbinganItem({
    Key? key,
    required this.title,
    required this.date,
    required this.status,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      color: status == BimbinganStatus.revisi ? Colors.orange[100] : null,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: _getStatusIcon(),
          title: Text(title),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(date)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(description, textAlign: TextAlign.left),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon() {
    switch (status) {
      case BimbinganStatus.revisi:
        return const Icon(Icons.warning, color: Colors.orange);
      case BimbinganStatus.pending:
        return const Icon(Icons.remove_circle, color: Colors.grey);
      case BimbinganStatus.approved:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }
}

class LogBookItem {
  final String week;
  final DateTime date;
  String description;

  LogBookItem({
    required this.week,
    required this.date,
    required this.description,
  });
}

class LogBookItemWidget extends StatelessWidget {
  final LogBookItem item;
  final Function(LogBookItem) onEdit;

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
          title: Text(item.week),
          subtitle: Text(DateFormat('dd/MM/yyyy').format(item.date)),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.description),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _showEditDialog(context),
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

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newDescription = item.description;
        return AlertDialog(
          title: const Text('Edit Log Book'),
          content: TextField(
            maxLines: 5,
            decoration: const InputDecoration(hintText: 'Enter new description'),
            onChanged: (value) {
              newDescription = value;
            },
            controller: TextEditingController(text: item.description),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                onEdit(LogBookItem(
                  week: item.week,
                  date: item.date,
                  description: newDescription,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}