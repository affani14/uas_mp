import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'book_controller.dart';
import 'detail_page.dart';
import 'epub_viewer_page.dart';
import '../controllers/theme_controller.dart';

class HomePage extends StatelessWidget {

  final BookController bookController = Get.put(BookController());
  final ThemeController themeController = Get.find();

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

          Obx(() => Switch(
            value: themeController.isDarkMode.value,
            onChanged: (value) {
              themeController.toggleTheme();
            },
            activeColor: Colors.white,
          )),
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
                              BookDetailPage(bookId: index + 1),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 32),
            // Daftar Buku EPUB
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
            // Status upload
            Obx(() {
              return bookController.isUploading.value
                  ? Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 8),
                  Text(bookController.uploadStatus.value),
                ],
              )
                  : SizedBox();
            }),
            SizedBox(height: 16),

            Obx(() {
              if (bookController.filesToUpload.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'File yang Dipilih:',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: bookController.filesToUpload.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Icon(Icons.file_present),
                          title: Text(bookController.filesToUpload[index].path.split('/').last),
                          subtitle: Text(bookController.previewUrls[index]),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return SizedBox();
              }
            }),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: bookController.pickAndUploadFiles,
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
    List<String> suggestions = List.generate(
      5,
          (index) => 'Saran Buku ${index + 1} untuk "$query"',
    );
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
