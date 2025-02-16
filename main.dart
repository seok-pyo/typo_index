import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:typo_index/firebase_options.dart';
// import 'package:typo_index/screen/home_screen.dart';
import 'package:typo_index/screen/home_screen2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

// View
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen2(),
    );
  }
}
