import 'package:flutter/material.dart';
import 'package:sitama3/core/config/theme/app_theme.dart';
import 'package:sitama3/routes.dart';
import 'package:sitama3/ui/Start/splash/splash.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
