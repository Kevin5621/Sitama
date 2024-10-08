import 'package:flutter/material.dart';
import 'package:sitama3/UI/pages/Mahasiswa/home.dart';
import 'package:sitama3/UI/pages/Dosen/home_dosen.dart';
import './config/theme/theme.dart';
// import './presentation/pages/common/splash.dart';
import './config/routes.dart';


void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const HomePageD(),
    );
  }
}