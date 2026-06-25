import 'package:flutter/material.dart';
import 'package:lumi_fashion_mobile/src/presentation/onboarding/view/onboarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awari Assessment',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Switch between the two screens to test them
      // home: TaskBoardScreen(),
      home: OnboardingScreen(),
    );
  }
}
