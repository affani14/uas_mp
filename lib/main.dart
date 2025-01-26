import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:developer' as developer;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    // Log jika berhasil
    print("Firebase initialized successfully");
    developer.log("Firebase initialized successfully", name: "Firebase Initialization");
  } catch (e) {
    // Log jika terjadi error
    print("Error initializing Firebase: $e");
    developer.log("Error initializing Firebase: $e", name: "Firebase Initialization");
  }

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomePage(
        isDarkMode: _isDarkMode,
        onThemeChanged: (value) {
          setState(() {
            _isDarkMode = value;
          });
        },
      ),
    );
  }
}

