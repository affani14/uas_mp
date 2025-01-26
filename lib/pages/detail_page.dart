import 'package:flutter/material.dart';
import 'pdf_viewer_page.dart';

class BookDetailPage extends StatelessWidget {
  final int bookId;

  const BookDetailPage({required this.bookId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String bookTitle = 'Buku $bookId';
    String bookDescription =
        'Deskripsi panjang buku $bookId tentang berbagai topik yang menarik.';
    String author = 'Penulis Buku $bookId';
    String pdfPath = 'assets/pdf/book$bookId.pdf';
    String imagePath = 'assets/images/book$bookId.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku $bookId'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                color: Colors.blue[50],
                child: Image.asset(
                  imagePath,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          'Gambar tidak ditemukan',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),


              Text(
                bookTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),


              Text(
                'Penulis: $author',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),

              Text(
                'Deskripsi: $bookDescription',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(pdfPath: pdfPath),
                    ),
                  );
                },
                child: const Text('Baca PDF'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
