import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DownloadPage extends StatefulWidget {
  @override
  _DownloadPageState createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  int downloadCount = 0;

  Future<void> _incrementDownloadCount() async {
    final prefs = await SharedPreferences.getInstance();
    downloadCount = (prefs.getInt('downloadCount') ?? 0) + 1;

    if (downloadCount > 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download limit reached!')),
      );
    } else {
      prefs.setInt('downloadCount', downloadCount);
      // Logika untuk mengunduh file
      print('File downloaded. Total downloads: $downloadCount');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Download Limitation')),
      body: Center(
        child: ElevatedButton(
          onPressed: _incrementDownloadCount,
          child: Text('Download File'),
        ),
      ),
    );
  }
}
