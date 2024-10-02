import 'package:flutter/material.dart';
import 'g_login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/sitama_logo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'SELAMAT DATANG DI SITAMA!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Bantu kegiatan magang dan bimbingan jadi lebih mudah',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const LoginPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3A5BA0),
                    minimumSize: const Size(324, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55),
                    ),
                  ),
                  child: const Text('Login dengan Email', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                const Text('Or continue with'),
                const SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Google Sign
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.grey),
                    minimumSize: const Size(324, 52),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(55),
                    ),
                  ),
                  icon: Image.asset('assets/google_logo.png', height: 24),
                  label: const Text('Lanjut dengan Google',style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}