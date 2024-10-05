import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sistem_magang/common/widgets/student_guidance_card.dart';
import 'package:sistem_magang/presenstation/student/guidance/widgets/search_field.dart';

class GuidancePage extends StatelessWidget {
  const GuidancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        title: Text(
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
            icon: Icon(Icons.add),
          )
        ],
        backgroundColor: Colors.transparent,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 12)),
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
                  SizedBox(width: 10),
                  Icon(Icons.filter_list_outlined),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
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
