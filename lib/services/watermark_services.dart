import 'dart:io';
import 'package:image/image.dart';

class WatermarkService {
  Future<void> addWatermark(String inputPath, String outputPath) async {
    try {
      final inputFile = File(inputPath);
      if (!inputFile.existsSync()) {
        throw Exception('Input file not found: $inputPath');
      }

      final watermarkFile = File('assets/watermark.png');
      if (!watermarkFile.existsSync()) {
        throw Exception('Watermark file not found: assets/watermark.png');
      }

      // Decode gambar utama dan watermark
      final image = decodeImage(inputFile.readAsBytesSync())!;
      final watermark = decodeImage(watermarkFile.readAsBytesSync())!;

      // Tambahkan watermark ke gambar utama
      final outputImage = copyInto(
        image,
        watermark,
        dstX: image.width - watermark.width,
        dstY: image.height - watermark.height,
      );

      // Simpan hasil ke outputPath
      File(outputPath).writeAsBytesSync(encodePng(outputImage));
      print('Watermark added successfully: $outputPath');
    } catch (e) {
      print('Error: $e');
    }
  }
}
