import 'package:flutter/material.dart';

void main() {
  runApp(const CardMahasiswa(studentName: '',));
}

class CardMahasiswa extends StatelessWidget {
  const CardMahasiswa({Key? key, required String studentName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DCard Page',
      home: DCardPage(), // Menggunakan DCardPage
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

class DCardPage extends StatefulWidget {
  const DCardPage({Key? key}) : super(key: key);

  @override
  _DCardPageState createState() => _DCardPageState();
}

class _DCardPageState extends State<DCardPage> {
  List<BimbinganItem> bimbinganData = [
    BimbinganItem(
      id: 1,
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
    BimbinganItem(
      id: 2,
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
      id: 3,
      title: 'Bimbingan 6',
      date: '26/01/2024',
      status: 'unread',
      description: 'Kegiatan Anda: Berikut poin-poin laporan saya:',
      points: [
        'Bab I - Pendahuluan: Latar belakang magang',
        'Pembahasan Kegiatan Magang',
        'Analisis dan Evaluasi',
      ],
      attachment: 'Lucas Bimbingan5.pdf',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bimbingan'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile and Industry Info
            _buildProfileSection(),
            _buildIndustrySection(),
            _buildNilaiSection(),

            // Tabs for Bimbingan and Log Book
            _buildTabs(),

            // List of Bimbingan Items
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bimbinganData.length,
              itemBuilder: (context, index) {
                return BimbinganItemWidget(
                  data: bimbinganData[index],
                  onAccept: () => handleAccept(bimbinganData[index].id),
                  onReject: () => handleReject(bimbinganData[index].id),
                );
              },
            ),
          ],
        ),
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
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Bimbingan',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Log Book',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
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
        return const Icon(Icons.remove_circle,
            color: Colors.black); // Tanda "-"
      case 'pending':
        return const Icon(Icons.error, color: Colors.red); // Tanda "!"
      case 'unread':
        return const Icon(Icons.add_circle, color: Colors.black); // Tanda "+"
      default:
        return const Icon(Icons.help, color: Colors.grey);
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
