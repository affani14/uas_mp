import 'package:flutter/services.dart';

class DRMService {
  static const platform = MethodChannel('com.example.drm');

  Future<void> initializeDRM() async {
    try {
      final String result = await platform.invokeMethod('initializeDRM');
      print(result);
    } on PlatformException catch (e) {
      print("Failed to initialize DRM: ${e.message}");
    }
  }
}
