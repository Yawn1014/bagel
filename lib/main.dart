import 'package:flutter/material.dart';
import 'start.dart';
Future<void> main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bagel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartScreen(), // The first screen displayed is the StartScreen from start.dart
    );
  }
}