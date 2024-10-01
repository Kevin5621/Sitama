import 'package:flutter/material.dart';

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

class BimbinganPage extends StatefulWidget {
  const BimbinganPage({Key? key, required String studentName}) : super(key: key);

  @override
  _BimbinganPageState createState() => _BimbinganPageState();
}

class _BimbinganPageState extends State<BimbinganPage> {
  List<BimbinganItem> bimbinganData = [
    BimbinganItem(
      id: 1,
      title: 'Bimbingan 8',
      date: '28/01/2024',
      status: 'pending',
      description: 'Kegiatan Anda : Berikut poin-poin laporan saya:',
      points: [
        'Bab I - Pendahuluan: Latar belakang magang',
        'Pembahasan Kegiatan Magang',
        'Analisis dan Evaluasi'
      ],
      attachment: 'Lucas Bimbingan7.pdf',
    ),
    // Add more BimbinganItem instances here
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
      item.status = 'pending';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bimbingan'),
      ),
      body: ListView.builder(
        itemCount: bimbinganData.length,
        itemBuilder: (context, index) {
          return BimbinganItemWidget(
            data: bimbinganData[index],
            onAccept: () => handleAccept(bimbinganData[index].id),
            onReject: () => handleReject(bimbinganData[index].id),
          );
        },
      ),
    );
  }
}

class BimbinganItemWidget extends StatefulWidget {
  final BimbinganItem data;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const BimbinganItemWidget({Key? key, 
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
      case 'pending':
        return const Icon(Icons.error, color: Colors.red);
      case 'unread':
        return const Icon(Icons.remove_circle, color: Colors.grey);
      default:
        return const Icon(Icons.add_circle, color: Colors.blue);
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
                  icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
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
                      Text(widget.data.attachment, style: const TextStyle(color: Colors.blue)),
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