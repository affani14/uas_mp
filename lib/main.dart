import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;
import 'pages/home_page.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully");
    developer.log("Firebase initialized successfully", name: "Firebase Initialization");
  } catch (e) {
    print("Error initializing Firebase: $e");
    developer.log("Error initializing Firebase: $e", name: "Firebase Initialization");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
        home: HomePage(),
      );
    });
  }
}
