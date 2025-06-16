import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// Import auth logic
import 'services/auth_service.dart';
import 'screens/auth_screen.dart';// Import auth UI

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
      title: 'Medical App - Auth',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const AuthScreen(),
    );
  }
}