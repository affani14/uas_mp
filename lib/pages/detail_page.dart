import 'package:flutter/material.dart';

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
        child: Text('Informasi detail untuk Buku $bookId'),
      ),
    );
  }
}
