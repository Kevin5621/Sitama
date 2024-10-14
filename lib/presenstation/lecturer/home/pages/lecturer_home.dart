import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistem_magang/common/widgets/search_field.dart';
import 'package:sistem_magang/core/config/assets/app_images.dart';
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

class LecturerHomeContent extends StatelessWidget {
  const LecturerHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _header(),
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
                    Expanded(child: FilterTahunWidget()),
                    SizedBox(width: 16), 
                    Expanded(child: FilterJurusanWidget()),
                  ],
                ),
                SizedBox(height: 32),
                StudentCard(
                  imageUrl: 'https://picsum.photos/200/300',
                  name: 'Lucas Scott',
                  nim: '3.34.23.2.23',
                  kelas: 'IK - 2C',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
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
//TODO must change to API
            'AMRAN YOBIOKTABERA, M. KOM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 26),
          SearchField(onChanged: (value) {}, onFilterPressed: () {}),
        ],
      ),
    );
  }
}
