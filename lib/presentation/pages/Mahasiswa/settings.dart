import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitama3/presentation/bloc/event/add_industry.dart';
import 'package:sitama3/presentation/bloc/event/reset_psw.dart';
import 'package:sitama3/presentation/pages/common/welcome.dart';

class MSettingsPage extends StatelessWidget {
  const MSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_image.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Lucas Scott',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                '3.34.23.2.24',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Text(
                'lucasscott@polnes.com',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              const IndustryCard(),
              const SizedBox(height: 16),
              SettingsButton(
                icon: Icons.add_business,
                title: 'Tambah Industri',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MAddIndustryPage()),
                  );
                },
              ),
              SettingsButton(
                icon: Icons.lock_reset,
                title: 'Reset Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GResetPasswordPage()),
                  );
                },
              ),
              SettingsButton(
                icon: Icons.logout,
                title: 'Log Out',
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Log Out'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Log Out'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomePages()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class IndustryCard extends StatelessWidget {
  const IndustryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Industri',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Industri 1'),
            const Text('Nama: Pertamina'),
            Text('Tanggal Mulai: ${DateFormat('dd MMMM yyyy').format(DateTime(2024, 8, 11))}'),
            Text('Tanggal Selesai: ${DateFormat('dd MMMM yyyy').format(DateTime(2025, 8, 12))}'),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SettingsButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}