// import 'm_bimbingan_page.dart';
// import 'm_logbook_page.dart';
// import 'm_settings_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sitama3/common/widgets/student_guidance_card.dart';
import 'package:sitama3/common/widgets/student_log_book_card.dart';
import 'package:sitama3/core/config/assets/app_images.dart';
import 'package:sitama3/core/config/theme/app_color.dart';
import 'package:sitama3/domain/entities/student_home_entity.dart';
import 'package:sitama3/ui/Mahasiswa/bimbingan/pages/guidance.dart';
import 'package:sitama3/ui/Mahasiswa/home/bloc/student_display_cubit.dart';
import 'package:sitama3/ui/Mahasiswa/home/bloc/student_display_state.dart';
import 'package:sitama3/ui/Mahasiswa/logbook/pages/logbook.dart';
import 'package:sitama3/ui/Mahasiswa/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const GuidancePage(),
    const LogBookPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _currentIndex == 0 ? _buildHomeContent() : _pages[_currentIndex - 1],
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

  Widget _buildHomeContent() {
    return _HomeContent(
      allGuidances: () {
        setState(() {
          _currentIndex = 1; // Navigate to the 'Guidance' page
        });
      },
      allLogBooks: () {
        setState(() {
          _currentIndex = 2; // Navigate to the 'Logbook' page
        });
      },
    );
  }
}

class _HomeContent extends StatelessWidget {
  final VoidCallback allGuidances;
  final VoidCallback allLogBooks;

  const _HomeContent(
      {super.key, required this.allGuidances, required this.allLogBooks});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentDisplayCubit()..displayStudent(),
      child: BlocBuilder<StudentDisplayCubit, StudentDisplayState>(
        builder: (context, state) {
          if (state is StudentLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is StudentLoaded) {
            return CustomScrollView(
              slivers: [
                _header(state.studentHomeEntity),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 28),
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
                          onTap: allGuidances,
                          child: Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                _guidancesList(state.studentHomeEntity),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 28),
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
                          onTap: allLogBooks,
                          child: Icon(Icons.arrow_forward_ios, size: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                _logBooksList(state.studentHomeEntity),
              ],
            );
          }
          if (state is LoadStudentFailure) {
            return Text(state.errorMessage);
          }
          return Container();
        },
      ),
    );
  }

  SliverList _guidancesList(StudentHomeEntity student) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => GuidanceCard(
          title: student.latest_guidances[index].title,
          date: DateTime(2024, 1, 28 - index),
          status: student.latest_guidances[index].status == 'approved'
              ? GuidanceStatus.approved
              : student.latest_guidances[index].status == 'in-progress'
                  ? GuidanceStatus.inProgress
                  : student.latest_guidances[index].status == 'rejected'
                      ? GuidanceStatus.rejected
                      : GuidanceStatus.updated,
          description: student.latest_guidances[index].activity,
        ),
        childCount: student.latest_guidances.length,
      ),
    );
  }

  SliverToBoxAdapter _header(StudentHomeEntity student) {
    return SliverToBoxAdapter(
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
            child: Column(
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
                  student.name,
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
    );
  }

  SliverList _logBooksList(StudentHomeEntity student) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => LogBookCard(
          item: LogBookItem(
            title: student.latest_log_books[index].title,
            date: DateTime(2024, 1, 21 + index * 7),
            description: student.latest_log_books[index].activity,
          ),
          onEdit: (updatedItem) {
            // Implement edit functionality
          },
        ),
        childCount: student.latest_log_books.length,
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
          color: AppColors.warning,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.info,
              color: AppColors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: const Text(
                'Anda belum dijadwalkan seminar',
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.close,
                color: AppColors.white,
              ),
              onPressed: onClose,
            ),
          ],
        ),
      ),
    );
  }
}
