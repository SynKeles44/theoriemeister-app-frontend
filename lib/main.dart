import 'package:flutter/material.dart';

void main() {
  runApp(const TheorieMeisterApp());
}

class TheorieMeisterApp extends StatelessWidget {
  const TheorieMeisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheorieMeister',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2196F3),
          secondary: Color(0xFF4CAF50),
          surface: Color(0xFF0D1B3E),
        ),
        scaffoldBackgroundColor: const Color(0xFF0D1B3E),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Logo
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: const Color(0xFF132044),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2196F3).withOpacity(0.3),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.school,
                      size: 70,
                      color: Color(0xFF2196F3),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // App Name
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'Theorie',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Meister',
                      style: TextStyle(color: Color(0xFF2196F3)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Tagline
              const Text(
                'LERNEN. VERSTEHEN. BESTEHEN.',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7A9CC4),
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(flex: 3),

              // Registrieren Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Registrieren',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Anmelden Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(
                      color: Color(0xFF2A4070),
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Anmelden',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
