import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_controller.dart';

class FilePreviewWidget extends StatelessWidget {
  final BookController bookController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {

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
    });
  }
}
