import 'package:flutter/material.dart';

class DCardPage extends StatelessWidget {
  const DCardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('D Home Page'),
      ),
      body: const Center(
        child: Text('Selamat datang di D Home Page'),
      ),
    );
  }
}