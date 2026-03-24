import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ShareApp());
}

class ShareApp extends StatelessWidget {
  const ShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Universal Share',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
