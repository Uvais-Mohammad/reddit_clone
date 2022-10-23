import 'package:flutter/material.dart';
import 'package:reddit_clone/core/locale/localization.dart';
import 'package:reddit_clone/features/auth/screens/login_screen.dart';
import 'package:reddit_clone/theme/pallette.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: LocalizationStrings.appName ,
      theme: Pallette.darkModeAppTheme,
      home: const LoginScreen(),
    );
  }
}
