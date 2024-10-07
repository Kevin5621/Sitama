import 'package:flutter/material.dart';
import 'package:sitama3/presentation/pages/Mahasiswa/settings.dart';
import 'package:sitama3/presentation/widgets/guidance/filter_tahun.dart';
import 'package:sitama3/presentation/widgets/guidance/filter_prodi.dart';

import '../../../config/assets/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    _HomeContent(),
    const MSettingsPage(),
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

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
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
                child: const Column(
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
                      'Lucas Scott',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SearchField(),
              const SizedBox(height: 16),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Mahasiswa Bimbingan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilterButton(
                      title: '2024/2025',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilterTahun()),
                        );
                      },
                    ),
                    FilterButton(
                      title: 'D3 - Informatika',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilterProdi()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ProfileCard(
                imageUrl: 'https://picsum.photos/200/300',
                name: 'Lucas Scott',
                nim: '3.34.23.2.23',
                kelas: 'IK - 2C',
              ),
              const SizedBox(height: 8),
              ProfileCard(
                imageUrl: 'https://picsum.photos/200/301',
                name: 'Lucas Scott',
                nim: '3.34.23.2.23',
                kelas: 'IK - 2C',
              ),
              const SizedBox(height: 8),
              ProfileCard(
                imageUrl: 'https://picsum.photos/200/302',
                name: 'Lucas Scott',
                nim: '3.34.23.2.23',
                kelas: 'IK - 2C',
              ),
              // ... rest of the code
            ],
          ),
        ),
        // ... rest of the code
      ],
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String nim;
  final String kelas;

  const ProfileCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.nim,
    required this.kelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  nim,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF71727A),
                  ),
                ),
                Text(
                  kelas,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF71727A),
                  ),
                ),
              ],
            ),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailMahasiswa(
                            imageUrl: imageUrl,
                            name: name,
                            nim: nim,
                            kelas: kelas,
                          )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const FilterButton({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color(0xFF71727A)),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFF71727A),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Search',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
