import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sistem_magang/core/config/themes/app_color.dart';
import 'package:sistem_magang/domain/usecases/update_scores.dart';
import 'package:sistem_magang/presenstation/lecturer/detail_student/widgets/lecturer_guidance_tab.dart';
import 'package:sistem_magang/presenstation/lecturer/detail_student/widgets/lecturer_log_book_tab.dart';
import 'package:sistem_magang/presenstation/lecturer/input_score/pages/input_score.dart';

class DetailStudentPage extends StatelessWidget {
  const DetailStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/home_pattern.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          color: AppColors.black,
                        ),
                      ),
                      Text(
                        '3.34.23.2.24',
                        style: TextStyle(color: AppColors.black),
                      ),
                      Text(
                        'lucasscott@polines.com',
                        style: TextStyle(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildInfoBoxes(context), // Pass context to _buildInfoBoxes
                _buildTabSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBoxes(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoBox(
            'Industri',
            [
              'Industri 1',
              'Nama: Pertamina',
              'Tanggal Mulai: 11 Agustus 2024',
              'Tanggal Selesai: 12 Agustus 2025',
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoBox(
            'Nilai',
            [
              'Proposal: -',
              'Laporan: -',
              'Nilai Industri: -',
              'Rata - rata: -',
            ],
            showAddButton: true,
            context: context, // Pass context here
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBox(String title, List<String> content,
      {bool showAddButton = false, BuildContext? context}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (showAddButton && context != null)
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputScorePage(
                          updateScoresUseCase: GetIt.I<UpdateScoresUseCase>(),
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
          ...content.map((item) => Text(item)),
        ],
      ),
    );
  }

  Widget _buildTabSection() {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: [
              Tab(text: 'Bimbingan'),
              Tab(text: 'Log Book'),
            ],
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.gray,
            indicatorColor: AppColors.primary,
          ),
          SizedBox(
            height: 300, // Adjust this height as needed
            child: TabBarView(
              children: [
                LecturerGuidanceTab(),
                LecturerLogBookTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
