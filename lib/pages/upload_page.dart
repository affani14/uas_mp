import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _isUploading = false;
  String _uploadStatus = "";


  Future<void> pickAndUploadFile() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);


      String localDir = (await getTemporaryDirectory()).path;
      String localFilePath = '$localDir/${result.files.single.name}';
      await file.copy(localFilePath);


      setState(() {
        _isUploading = true;
        _uploadStatus = 'Mengunggah ${result.files.single.name}...';
      });


      try {
        Reference ref = FirebaseStorage.instance.ref().child('uploads/${DateTime.now().millisecondsSinceEpoch}_${result.files.single.name}');
        UploadTask uploadTask = ref.putFile(file);
        uploadTask.snapshotEvents.listen((event) {
          double progress = (event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) * 100;
          setState(() {
            _uploadStatus = 'Proses: ${progress.toStringAsFixed(2)}%';
          });
        });


        await uploadTask.whenComplete(() {
          setState(() {
            _isUploading = false;
            _uploadStatus = 'Pengunggahan selesai!';
          });
        });
      } catch (e) {
        setState(() {
          _isUploading = false;
          _uploadStatus = 'Gagal mengunggah: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload File Multi-format'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isUploading ? null : pickAndUploadFile,
              child: Text(_isUploading ? 'Mengunggah...' : 'Pilih dan Unggah File'),
            ),
            SizedBox(height: 20),
            Text(_uploadStatus),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          pickAndUploadFile();
        },
        child: Icon(Icons.upload),
        tooltip: 'Unggah Buku',
      ),
    );
  }
}
