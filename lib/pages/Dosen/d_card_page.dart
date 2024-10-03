import 'package:flutter/material.dart';

void main() {
  runApp(const CardMahasiswa(studentName: '',));
}

class CardMahasiswa extends StatelessWidget {
  const CardMahasiswa({Key? key, required String studentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Bimbingan dan Log Book',
      home: DCardPage(),
    );
  }
}

class BimbinganItem {
  final int id;
  final String title;
  final String date;
  String status;
  final String description;
  final List<String> points;
  final String attachment;

  BimbinganItem({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
    required this.description,
    required this.points,
    required this.attachment,
  });
}

class LogBookItem {
  final String title;
  final String date;
  final String description;

  LogBookItem({
    required this.title,
    required this.date,
    required this.description,
  });
}

class DCardPage extends StatefulWidget {
  const DCardPage({Key? key}) : super(key: key);

  @override
  _DCardPageState createState() => _DCardPageState();
}

class _DCardPageState extends State<DCardPage> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  List<BimbinganItem> bimbinganData = [
    BimbinganItem(
      id: 5,
      title: 'Bimbingan 5',
      date: '26/01/2024',
      status: 'unread',
      description: 'Kegiatan Anda: Silakan cek laporan saya yang belum dibaca.',
      points: [
        'Bab II - Metodologi: Metode yang digunakan',
        'Analisis Data',
      ],
      attachment: 'Lucas Bimbingan5.pdf',
    ),
    BimbinganItem(
      id: 6,
      title: 'Bimbingan 6',
      date: '25/01/2024',
      status: 'revisi',
      description: 'Kegiatan Anda: Mohon revisi laporan saya.',
      points: [
        'Bab III - Hasil dan Pembahasan',
        'Kesimpulan dan Saran',
      ],
      attachment: 'Lucas Bimbingan4.pdf',
    ),
    BimbinganItem(
      id: 7,
      title: 'Bimbingan 7',
      date: '27/01/2024',
      status: 'accepted',
      description: 'Kegiatan Anda: Berikut poin-poin laporan saya:',
      points: [
        'Bab I - Pendahuluan: Latar belakang magang',
        'Pembahasan Kegiatan Magang',
        'Analisis dan Evaluasi',
      ],
      attachment: 'Lucas Bimbingan6.pdf',
    ),
    BimbinganItem(
      id: 8,
      title: 'Bimbingan 8',
      date: '28/01/2024',
      status: 'pending',
      description: 'Kegiatan Anda: Berikut poin-poin laporan saya:',
      points: [
        'Bab I - Pendahuluan: Latar belakang magang',
        'Pembahasan Kegiatan Magang',
        'Analisis dan Evaluasi',
      ],
      attachment: 'Lucas Bimbingan7.pdf',
    ),
  ];

  List<LogBookItem> logBookData = [
    LogBookItem(
      title: "Minggu 2",
      date: "21/01/2024",
      description: "Membuat desain UI/UX aplikasi MY Pertamin...",
    ),
    LogBookItem(
      title: "Minggu 3",
      date: "28/01/2024",
      description: "Pengujian aplikasi MY Pertamina...",
    ),
  ];

  void handleAccept(int id) {
    setState(() {
      final item = bimbinganData.firstWhere((item) => item.id == id);
      item.status = 'accepted';
    });
  }

  void handleReject(int id) {
    setState(() {
      final item = bimbinganData.firstWhere((item) => item.id == id);
      item.status = 'rejected';
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bimbingan dan Log Book'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          _buildProfileSection(),
          _buildIndustrySection(),
          _buildNilaiSection(),
          _buildTabs(),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              children: [
                _buildBimbinganList(),
                _buildLogBookList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/1.jpg',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Harly James Ardhana Putra',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('3.34.23.2.24'),
          Text('lucasScott@polines.com'),
        ],
      ),
    );
  }

  Widget _buildIndustrySection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Industri',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Industri 1'),
              Text('Nama: Pertamina'),
              Text('Tanggal Mulai: 11 Agustus 2024'),
              Text('Tanggal Selesai: 12 Agustus 2025'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNilaiSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nilai',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Dosen: -'),
              Text('Industri: -'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTabItem("Bimbingan", 0),
          _buildTabItem("Log Book", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: _selectedIndex == index ? Colors.black : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          if (_selectedIndex == index)
            Container(
              height: 3,
              width: 60,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  Widget _buildBimbinganList() {
    return ListView.builder(
      key: const ValueKey('bimbinganList'),
      itemCount: bimbinganData.length,
      itemBuilder: (context, index) {
        return BimbinganItemWidget(
          data: bimbinganData[index],
          onAccept: () => handleAccept(bimbinganData[index].id),
          onReject: () => handleReject(bimbinganData[index].id),
        );
      },
    );
  }

  Widget _buildLogBookList() {
    return ListView.builder(
      key: const ValueKey('logBookList'),
      itemCount: logBookData.length,
      itemBuilder: (context, index) {
        return LogBookItemWidget(data: logBookData[index]);
      },
    );
  }
}

class BimbinganItemWidget extends StatefulWidget {
  final BimbinganItem data;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const BimbinganItemWidget({
    Key? key,
    required this.data,
    required this.onAccept,
    required this.onReject,
  }) : super(key: key);

  @override
  _BimbinganItemWidgetState createState() => _BimbinganItemWidgetState();
}

class _BimbinganItemWidgetState extends State<BimbinganItemWidget> {
  bool isExpanded = false;

  Icon getStatusIcon() {
    switch (widget.data.status) {
      case 'accepted':
        return const Icon(Icons.check_circle, color: Colors.green);
      case 'rejected':
        return const Icon(Icons.error, color: Colors.red);
      case 'revisi':
        return const Icon(Icons.add_circle, color: Colors.black);
      case 'unread':
        return const Icon(Icons.remove_circle, color: Colors.black);
      default:
        return const Icon(Icons.check_circle, color: Colors.green);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            leading: getStatusIcon(),
            title: Text(widget.data.title),
            subtitle: Text(widget.data.date),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.check, color: Colors.green),
                  onPressed: widget.onAccept,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: widget.onReject,
                ),
                IconButton(
                  icon:
                      Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data.description),
                  const SizedBox(height: 8),
                  ...widget.data.points.map((point) => Padding(
                        padding: const EdgeInsets.only(left: 16, top: 4),
                        child: Text('• $point'),
                      )),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.attach_file, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(widget.data.attachment,
                          style: const TextStyle(color: Colors.blue)),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class LogBookItemWidget extends StatelessWidget {
  final LogBookItem data;

  const LogBookItemWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(data.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.date),
            const SizedBox(height: 4),
            Text(data.description),
          ],
        ),
      ),
    );
  }
}
