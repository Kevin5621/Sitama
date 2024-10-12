import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sistem_magang/common/widgets/student_guidance_card.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';
import 'package:sistem_magang/presenstation/lecturer/input_score/pages/input_score.dart';

class DetailStudentPage extends StatelessWidget {
  const DetailStudentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Contoh data logbook yang digunakan untuk LogbookCard
    final List<LogbookItem> logbooks = [
      LogbookItem(
        id: '1',
        date: DateTime(2024, 1, 10),
        description: 'Deskripsi logbook pertama...',
        isExpanded: false,
        weekNumber: 1,
      ),
      LogbookItem(
        id: '2',
        date: DateTime(2024, 1, 17),
        description: 'Deskripsi logbook kedua...',
        isExpanded: false,
        weekNumber: 1,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Haley James',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  const Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/men/1.jpg'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Harly James Ardhana Putra',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '3.34.23.2.24',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'lucasscott@polines.com',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Industry Information Card
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Industri',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Industri: Pertamina'),
                          Text('Tanggal Mulai: 11 Agustus 2024'),
                          Text('Tanggal Selesai: 12 Agustus 2025'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Grades Section
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nilai',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text('Dosen: -'),
                              Text('Industri: -'),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              // Navigate to input grade page
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => InputScorePage(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Bimbingan Guidance Section
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => GuidanceCard(
                title: 'Bimbingan ${8 - index}',
                date: DateTime(2024, 1, 28 - index),
                status: index == 0
                    ? GuidanceStatus.rejected
                    : GuidanceStatus.approved,
                description:
                    'Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi',
              ),
              childCount: 2,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),

          // Logbook Section dengan LogbookCard
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Logbook Mahasiswa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final logbook = logbooks[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: LogbookCard(
                    logbook: logbook,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tapped on ${logbook.title}')),
                      );
                    },
                    onEdit: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Editing ${logbook.title}')),
                      );
                    },
                    onDelete: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Deleting ${logbook.title}')),
                      );
                    },
                  ),
                );
              },
              childCount: logbooks.length,
            ),
          ),
        ],
      ),
    );
  }
}

class LogbookItem {
  final String id;
  final int weekNumber;
  final DateTime date;
  final String description;
  final bool isExpanded;

  LogbookItem({
    required this.id,
    required this.weekNumber,
    required this.date,
    required this.description,
    this.isExpanded = false,
  });

  String get title => 'Logbook Week $weekNumber';

  LogbookItem copyWith({
    String? id,
    int? weekNumber,
    DateTime? date,
    String? description,
    bool? isExpanded,
  }) {
    return LogbookItem(
      id: id ?? this.id,
      weekNumber: weekNumber ?? this.weekNumber,
      date: date ?? this.date,
      description: description ?? this.description,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  static where(bool Function(dynamic item) param0) {}
}

class LogbookCard extends StatelessWidget {
  final LogbookItem logbook;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const LogbookCard({
    Key? key,
    required this.logbook,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                logbook.title,
                style: theme.textTheme.headlineSmall,
              ),
              subtitle: Text(
                DateFormat('dd/MM/yyyy').format(logbook.date),
                style: theme.textTheme.bodyMedium,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primary),
                    onPressed: onEdit,
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.danger),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ),
            if (logbook.isExpanded)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  logbook.description,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
