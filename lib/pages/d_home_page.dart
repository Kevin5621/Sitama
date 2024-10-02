import 'package:flutter/material.dart';
import 'm_settings_page.dart';
import 'd_card_page.dart'; // Pastikan untuk mengimpor file ini

void main() {
  runApp(const DHomePage());
}

class DHomePage extends StatelessWidget {
  const DHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const StudentListPage(),
    );
  }
}

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  String selectedYear = '2024/2025';
  String selectedProgram = 'D3-Teknik Informatika';
  int _currentIndex = 0;

  final List<String> years = [
    '2023/2024',
    '2024/2025',
    '2025/2026',
    '2026/2027',
    '2027/2028',
  ];

  final List<String> programs = [
    'D3-Teknik Informatika',
    'D3-Elektronika',
    'D3-Telekomunikasi',
    'D3-Listrik',
    'D4-Teknologi Rekayasa Komputer',
    'D4 Teknologi Rekayasa Elektronika',
    'D4-Telekomunikasi',
    'D4-Teknologi Instalasi Listrik',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MSettingsPage()),
      );
    }
  }

  void _navigateToStudentCard(String studentName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CardMahasiswa(studentName: studentName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('9:41'),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.signal_cellular_alt),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.wifi),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.battery_full),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'AMRAN YOBIOKTABERA, M. KOM',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedYear,
                        isExpanded: true,
                        items: years.map((String year) {
                          return DropdownMenuItem<String>(
                            value: year,
                            child: Text(year, style: const TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedProgram,
                        isExpanded: true,
                        items: programs.map((String program) {
                          return DropdownMenuItem<String>(
                            value: program,
                            child: Text(program, style: const TextStyle(fontSize: 14)),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedProgram = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://example.com/lucas_scott.jpg'),
                  ),
                  title: const Text('Lucas Scott'),
                  subtitle: const Text('Mengerjakan Bab 2C'),
                  onTap: () => _navigateToStudentCard('Lucas Scott'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: const Icon(Icons.person),
                    backgroundColor: Colors.grey[300],
                  ),
                  title: const Text('Nathan Salvador'),
                  subtitle: const Text('Mengerjakan Bab 2'),
                  onTap: () => _navigateToStudentCard('Nathan Salvador'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: const Icon(Icons.person),
                    backgroundColor: Colors.grey[300],
                  ),
                  title: const Text('Pertatie Sandiga'),
                  subtitle: const Text('Mengerjakan Bab 3'),
                  onTap: () => _navigateToStudentCard('Pertatie Sandiga'),
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: const Icon(Icons.person),
                    backgroundColor: Colors.grey[300],
                  ),
                  title: const Text('Pertamax Sandiga'),
                  subtitle: const Text('Mengerjakan Bab 3'),
                  onTap: () => _navigateToStudentCard('Pertamax Sandiga'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}