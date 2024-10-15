import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sistem_magang/common/widgets/search_field.dart';
import 'package:sistem_magang/core/config/assets/app_images.dart';
import 'package:sistem_magang/domain/entities/lecturer_home_entity.dart';
import 'package:sistem_magang/presenstation/lecturer/home/bloc/lecturer_display_cubit.dart';
import 'package:sistem_magang/presenstation/lecturer/home/bloc/lecturer_display_state.dart';
import 'package:sistem_magang/presenstation/lecturer/home/widgets/filter_jurusan.dart';
import 'package:sistem_magang/presenstation/lecturer/home/widgets/filter_tahun.dart';
import 'package:sistem_magang/presenstation/lecturer/home/widgets/student_card.dart';
import 'package:sistem_magang/presenstation/lecturer/profile/pages/lecturer_profile.dart';

class LecturerHomePage extends StatefulWidget {
  const LecturerHomePage({super.key});

  @override
  State<LecturerHomePage> createState() => _LecturerHomePageState();
}

class _LecturerHomePageState extends State<LecturerHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    LecturerHomeContent(),
    LecturerProfilePage(),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class LecturerHomeContent extends StatefulWidget {
  const LecturerHomeContent({super.key});

  @override
  State<LecturerHomeContent> createState() => _LecturerHomeContentState();
}

class _LecturerHomeContentState extends State<LecturerHomeContent> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LecturerDisplayCubit()..displayLecturer(),
        child: BlocBuilder<LecturerDisplayCubit, LecturerDisplayState>(
          builder: (context, state) {
            if (state is LecturerLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state is LecturerLoaded) {
              LecturerHomeEntity data = state.lecturerHomeEntity;
              List<LecturerStudentsEntity> students = data.students.where((student) {
                var search = student.name.toLowerCase().contains(_search.toLowerCase()) || student.major.toLowerCase().contains(_search.toLowerCase());
                return search;
              }).toList();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _header(data.name),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mahasiswa Bimbingan',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(child: FilterJurusan()),
                              SizedBox(width: 16),
                              Expanded(child: FilterTahun()),
                            ],
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              itemCount: students.length,
                              separatorBuilder: (context, index) => SizedBox(
                                    width: 14,
                                  ),
                              itemBuilder: (context, index) {
                                return StudentCard(
                                  id: students[index].id,
                                  imageUrl: 'https://picsum.photos/200/300',
                                  name: students[index].name,
                                  jurusan: students[index].major,
                                  nim: students[index].username,
                                );
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is LoadLecturerFailure) {
              return Text(state.errorMessage);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _header(String name) {
    return Container(
      width: double.infinity,
      height: 220,
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
            name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 26),
          SearchField(
            onChanged: (value) {
              setState(() {
                _search = value;
              });
            },
            onFilterPressed: () {},
          ),
        ],
      ),
    );
  }
}
