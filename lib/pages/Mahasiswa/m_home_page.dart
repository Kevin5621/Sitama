import 'package:flutter/material.dart';
import 'm_bimbingan_page.dart';
import 'm_logbook_page.dart';
import 'm_settings_page.dart';
import '../Models/notification_widget.dart';
import '../Models/bimbingan_item.dart';
import '../Models/logbook_item.dart';

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
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
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
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 16),
                  _buildNotification(),
                ],
              ),
            ),
            _buildBimbinganSection(context),
            _buildLogBookSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: Colors.orange),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HELLO,',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Lucas Scott',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildNotification() {
    return Container(
      color: Colors.white,
      child: NotificationWidget(onClose: () {}),
    );
  }

  Widget _buildBimbinganSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSectionHeader(
            context,
            title: 'Bimbingan Terbaru',
            onTapSeeAll: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MBimbinganPage()),
            ),
          ),
          _buildBimbinganList(),
        ],
      ),
    );
  }

  Widget _buildBimbinganList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => BimbinganItem(
          title: 'Bimbingan ${8 - index}',
          date: DateTime(2024, 1, 28 - index),
          status: index == 0 ? BimbinganStatus.revisi : BimbinganStatus.approved,
          description: 'Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi',
        ),
        childCount: 2,
      ),
    );
  }

  Widget _buildLogBookSection(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildSectionHeader(
            context,
            title: 'Log Book Terbaru',
            onTapSeeAll: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LogBookPage()),
            ),
          ),
          _buildLogBookList(),
        ],
      ),
    );
  }

  Widget _buildLogBookList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
                (context, index) => LogBookItemWidget(
          item: LogBookItem(
            week: 'Minggu ${index + 1}',
            date: DateTime(2024, 1, 21 + index * 7),
            description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...', title: '',
          ),
          onEdit: (updatedItem) {
            // Implement edit functionality
          },
        ),
        childCount: 2,
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title, required VoidCallback onTapSeeAll}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onTapSeeAll,
            child: const Row(
              children: [
                Text('Lihat Semua'),
                Icon(Icons.arrow_forward_ios, size: 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}