import 'package:flutter/material.dart';
import 'package:event_heaven/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Heaven',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9C27B0), // Purple
          primary: const Color(0xFF9C27B0),
          secondary: const Color(0xFFFF4081), // Pink
          tertiary: const Color(0xFFFF9800), // Orange
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
