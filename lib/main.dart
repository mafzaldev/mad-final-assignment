import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mad_combined_tasks/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD Combined Tasks',
      themeMode: ThemeMode.light,
      theme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.teal),
      darkTheme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const LoginPage(),
    );
  }
}
