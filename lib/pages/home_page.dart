import 'package:flutter/material.dart';
import 'epub_viewer_page.dart';

class HomePage extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  HomePage({required this.isDarkMode, required this.onThemeChanged});

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
            value: isDarkMode,
            onChanged: onThemeChanged,
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
