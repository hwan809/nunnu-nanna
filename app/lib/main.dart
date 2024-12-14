import 'package:flutter/material.dart';
import 'screens/onboarding/onboarding_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/study_mode/study_mode_screen.dart';
import 'package:provider/provider.dart';
import 'providers/eye_tracking_provider.dart';

void main() {
  runApp(MaterialApp(
    home: StudyModeScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => OnboardingScreen(), // 최초 실행 시
        '/home': (context) => HomeScreen(),
        '/study': (context) => StudyModeScreen(),
      },
    );
  }
}