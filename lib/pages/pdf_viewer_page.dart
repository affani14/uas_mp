import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:async';

class PdfViewerPage extends StatefulWidget {
  final String pdfPath;

  PdfViewerPage({required this.pdfPath});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final Completer<PDFViewController> _controller = Completer<PDFViewController>();
  int _totalPages = 0;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: PDFView(
        filePath: widget.pdfPath,
        onRender: (pages) {
          setState(() {
            _totalPages = pages ?? 0;
          });
        },
        onViewCreated: (controller) {
          _controller.complete(controller);
        },
        onPageChanged: (currentPage, _) {
          setState(() {
            _currentPage = currentPage ?? 0;
          });
        },
        onError: (e) {

          print("Error loading PDF: $e");
        },
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Page: ${_currentPage + 1} / $_totalPages'),
            IconButton(
              icon: Icon(Icons.bookmark),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bookmark halaman ${_currentPage + 1}')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
