import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'epub_viewer_page.dart';

class HomePage extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  HomePage({required this.isDarkMode, required this.onThemeChanged});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text('E-Book Reader'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: BookSearchDelegate());
            },
          ),
          Switch(
            value: widget.isDarkMode,
            onChanged: widget.onThemeChanged,
            activeColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daftar Buku',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.book, size: 40),
                    title: Text('Buku ${index + 1}'),
                    subtitle: Text('Deskripsi singkat buku ${index + 1}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookDetailPage(bookIndex: index + 1),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 32),
            Text(
              'Daftar Buku EPUB',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Buku EPUB 1'),
                    subtitle: Text('Deskripsi singkat buku EPUB 1'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EpubViewerPage(epubAssetPath: 'assets/epub/book1.epub'),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.book),
                    title: Text('Buku EPUB 2'),
                    subtitle: Text('Deskripsi singkat buku EPUB 2'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EpubViewerPage(epubAssetPath: 'assets/epub/book2.epub'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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

class BookSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Hasil pencarian untuk "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = List.generate(5, (index) => 'Saran Buku ${index + 1} untuk "$query"');
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {

          },
        );
      },
    );
  }
}

// Halaman Detail Buku
class BookDetailPage extends StatelessWidget {
  final int bookIndex;

  BookDetailPage({required this.bookIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku $bookIndex'),
      ),
      body: Center(
        child: Text('Detail informasi untuk Buku $bookIndex'),
      ),
    );
  }
}
