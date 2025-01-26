import 'dart:io';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class BookController extends GetxController {
  var isDarkMode = false.obs;
  var isUploading = false.obs;
  var uploadStatus = ''.obs;
  var filesToUpload = <File>[].obs;
  var previewUrls = <String>[].obs;

  // Fungsi untuk toggle theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }

  // Fungsi untuk memilih dan mengunggah file
  Future<void> pickAndUploadFiles() async {
    try {
      // Memilih file
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result == null) {
        // Jika tidak ada file yang dipilih
        uploadStatus.value = 'Tidak ada file yang dipilih';
        return;
      }

      // Mengubah list file yang dipilih
      List<File> files = result.paths.map((path) => File(path!)).toList();

      // Set state pengunggahan
      isUploading.value = true;
      uploadStatus.value = 'Mengunggah ${files.length} file...';
      filesToUpload.value = files;
      previewUrls.value = files.map((file) => file.path).toList();

      List<UploadTask> uploadTasks = [];

      for (var file in files) {
        // Menyimpan file secara lokal di direktori sementara
        String localDir = (await getTemporaryDirectory()).path;
        String localFilePath = '$localDir/${result.files.firstWhere((element) => element.path == file.path).name}';
        await file.copy(localFilePath);

        // Mendapatkan referensi file di Firebase Storage
        Reference ref = FirebaseStorage.instance.ref().child('uploads/${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}');
        UploadTask uploadTask = ref.putFile(file);

        // Menambahkan upload task ke list
        uploadTasks.add(uploadTask);

        // Mendengarkan event snapshot untuk melihat progress
        uploadTask.snapshotEvents.listen((event) {
          double progress = (event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) * 100;
          uploadStatus.value = 'Proses: ${progress.toStringAsFixed(2)}%';
        });
      }

      // Tunggu semua task upload selesai
      await Future.wait(uploadTasks);

      // Mengupdate status setelah selesai
      isUploading.value = false;
      uploadStatus.value = 'Pengunggahan selesai!';
    } catch (e) {
      // Tangani error jika terjadi
      isUploading.value = false;
      uploadStatus.value = 'Gagal mengunggah: $e';
    }
  }
}
