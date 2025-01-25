import 'package:flutter/material.dart';
import 'pdf_viewer_page.dart';

class DetailPage extends StatelessWidget {
  final int bookId;

  DetailPage({required this.bookId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku $bookId'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Informasi detail untuk Buku $bookId'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                String pdfPath = 'assets/pdf/book$bookId.pdf';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerPage(pdfPath: pdfPath),
                  ),
                );
              },
              child: Text('Baca PDF'),
            ),
          ],
        ),
      ),
    );
  }
}
