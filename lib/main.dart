import 'package:flutter/material.dart';
import 'package:movieflix2025/screen/home_screen.dart';

void main() {
  runApp(const MovieFlix2025());
}

class MovieFlix2025 extends StatelessWidget {
  const MovieFlix2025({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: Typography.blackMountainView,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: HomeScreen(),
    );
  }
}
