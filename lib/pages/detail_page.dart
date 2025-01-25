import 'package:flutter/material.dart';
import 'pdf_viewer_page.dart';

class DetailPage extends StatelessWidget {
  final int bookId;

  DetailPage({required this.bookId});

  @override
  Widget build(BuildContext context) {
    String bookTitle = 'Buku $bookId';
    String bookDescription = 'Deskripsi panjang buku $bookId tentang berbagai topik yang menarik.';
    String author = 'Penulis Buku $bookId';
    String pdfPath = 'assets/pdf/book$bookId.pdf';

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
                  'assets/images/book$bookId.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),


              Text(
                bookTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 8),

              // Penulis
              Text(
                'Penulis: $author',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 16),

              // Deskripsi Buku
              Text(
                'Deskripsi: $bookDescription',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: 20),

              // Tombol Baca PDF
              Container(
                color: Colors.red[50],
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PdfViewerPage(pdfPath: pdfPath),
                      ),
                    );
                  },
                  child: Text('Baca PDF'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
