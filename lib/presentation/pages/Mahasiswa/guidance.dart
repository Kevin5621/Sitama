import 'package:flutter/material.dart';
import '../../widgets/guidance/student_guidance_card.dart';
import '../../widgets/Models/search_field.dart';

class GuidancePage extends StatelessWidget {
  const GuidancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: const Text(
          'Bimbingan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: SearchField(
                      onChanged: (value) {},
                      onFilterPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Icon(Icons.filter_list_outlined),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => GuidanceCard(
                title: 'Bimbingan ${8 - index}',
                date: DateTime(2024, 1, 28 - index),
                status: index == 0
                    ? GuidanceStatus.revisi
                    : GuidanceStatus.approved,
                description:
                    'Berikut poin-poin laporan saya:\n1. Bab I - Pendahuluan: Latar belakang magang\n2. Pembahasan Kegiatan Magang\n3. Analisis dan Evaluasi',
              ),
              childCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
