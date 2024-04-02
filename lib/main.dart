import 'package:flutter/material.dart';
import 'package:med_app/login.dart';

void main() {
  runApp(const MyApp());
}

final theme =
    ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text(
              'Get Started',
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          body: const Center(
            child: LoginScreen(),
          ),
        ),
      ),
    );
  }
}
