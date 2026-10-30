
import 'package:flutter/material.dart';

void main() {
  runApp(const ShamCardApp());
}

class ShamCardApp extends StatelessWidget {
  const ShamCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHAM CARD',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090810),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B5CF6),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF9B6DFF),
                    Color(0xFF5425A8),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Center(
                child: Text(
                  'SC',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'SHAM CARD',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'YOUR DIGITAL WORLD',
              style: TextStyle(
                color: Color(0xFFAAA5B8),
                letterSpacing: 3,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 35),
            const CircularProgressIndicator(
              color: Color(0xFF9B6DFF),
            ),
            const SizedBox(height: 15),
            const Text(
              'DEMO VERSION',
              style: TextStyle(
                color: Color(0xFF9B6DFF),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
