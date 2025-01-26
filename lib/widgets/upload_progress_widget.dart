import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/book_controller.dart';

class UploadProgressWidget extends StatelessWidget {
  final BookController bookController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return bookController.isUploading.value
          ? Column(
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 8),
          Text(bookController.uploadStatus.value),
        ],
      )
          : SizedBox();
    });
  }
}
