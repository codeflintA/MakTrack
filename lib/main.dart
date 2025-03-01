import 'package:flutter/material.dart';
import 'package:maktrack/presentation/pages/auth/sing_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SingUpScreen()
    );
  }
}

