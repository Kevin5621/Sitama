import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/guidance/student_guidance_card.dart';
import '../../../config/assets/app_images.dart';
import '../../../config/theme/theme.dart';
import '../Mahasiswa/guidance.dart';
// import 'm_bimbingan_page.dart';
// import 'm_logbook_page.dart';
// import 'm_settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    _HomeContent(),
    const GuidancePage(),
    // const LogBookPage(),
    // const MSettingsPage(),
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 160,
                padding: const EdgeInsets.symmetric(horizontal: 32),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.homePattern),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'HELLO,',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Lucas Scott',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: NotificationWidget(
                  onClose: () {},
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bimbingan Terbaru',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.arrow_forward_ios, size: 14),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => GuidanceCard(
              title: 'Bimbingan ${8 - index}',
              date: DateTime(2024, 1, 28 - index),
              status:
                  index == 0 ? GuidanceStatus.revisi : GuidanceStatus.approved,
              description:
                  'Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi',
            ),
            childCount: 2,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Log Book Terbaru',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.arrow_forward_ios, size: 14),
                ),
              ],
            ),
          ),
        ),
        newloogbook(),
      ],
    );
  }

  SliverList newloogbook() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => LogBookItemWidget(
          item: LogBookItem(
            week: 'Minggu ${index + 1}',
            date: DateTime(2024, 1, 21 + index * 7),
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
          ),
          onEdit: (updatedItem) {
            // Implement edit functionality
          },
        ),
        childCount: 2,
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final VoidCallback onClose;

  const NotificationWidget({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppTheme.warning,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.info,
              color: AppTheme.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: const Text(
                'Anda belum dijadwalkan seminar',
                style: TextStyle(
                  color: AppTheme.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: AppTheme.white,
              ),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
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
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: AppTheme.white,
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
            decoration:
                const InputDecoration(hintText: 'Enter new description'),
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
