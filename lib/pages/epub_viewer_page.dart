import 'package:flutter/material.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';

class EpubViewerPage extends StatelessWidget {
  final String epubAssetPath;

  EpubViewerPage({required this.epubAssetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EPUB Viewer'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _openEpub(context);
          },
          child: Text('Baca EPUB'),
        ),
      ),
    );
  }

  Future<void> _openEpub(BuildContext context) async {
    final epubController = EpubController();

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text("E-Book Reader"),
          ),
          body: EpubViewer(
            epubSource: EpubSource.fromAsset(epubAssetPath),
            epubController: epubController,
            displaySettings: EpubDisplaySettings(
              flow: EpubFlow.paginated,
              snap: true,
            ),
            onChaptersLoaded: (chapters) {},
            onEpubLoaded: () async {},
            onRelocated: (value) {},
            onTextSelected: (epubTextSelection) {},
          ),
        ),
      ),
    );
  }
}
