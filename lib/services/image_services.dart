import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img_lib;

class ImageProcessor {
  static Future<List<List<List<List<double>>>>> processImage(CameraImage image) async {
    try {
      final stopwatch = Stopwatch()..start();
      final int width = image.width;
      final int height = image.height;
      final yPlane = image.planes[0].bytes;

      // Create grayscale image directly from Y plane
      final img = img_lib.Image(width: width, height: height);
      final bytesPerRow = image.planes[0].bytesPerRow;
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final int pixelIndex = y * bytesPerRow + x;
          final int luminance = yPlane[pixelIndex];
          img.setPixelRgb(x, y, luminance, luminance, luminance);
        }
      }

      // Resize to 64x64
      final resizedImg = img_lib.copyResize(
        img,
        width: 64,
        height: 64,
        interpolation: img_lib.Interpolation.nearest,
      );

      // Normalize and reshape to (1, 64, 64, 1)
      final input = List.generate(
        1,
            (_) => List.generate(
          64,
              (y) => List.generate(
            64,
                (x) => [resizedImg.getPixel(x, y).r / 255.0],
          ),
        ),
      );

      print('Image processing completed in ${stopwatch.elapsedMilliseconds}ms');
      return input;
    } catch (e) {
      print('Image processing failed: $e');
      throw Exception('Image processing failed: $e');
    }
  }
}