import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'image_services.dart';

class TFLiteService {
  Interpreter? _interpreter;
  final List<String> _labels = List.generate(26, (index) => String.fromCharCode(65 + index)); // A-Z

  Future<void> loadModel(BuildContext context) async {
    try {
      final manifestContent = await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
      final containsModel = manifestContent.contains('assets/models/asl_model.tflite');
      if (!containsModel) {
        throw Exception('Model file not found in AssetManifest. Check pubspec.yaml.');
      }

      _interpreter = await Interpreter.fromAsset('assets/models/asl_model.tflite');
      print('Model loaded successfully.');
    } catch (e) {
      print('Failed to load TFLite model: $e');
      throw Exception('Failed to load TFLite model: $e');
    }
  }


  Future<String?> runInference(CameraImage image) async {
    if (_interpreter == null) {
      print('Interpreter is null. Model not loaded.');
      return null;
    }

    try {
      final stopwatch = Stopwatch()..start();
      final input = await ImageProcessor.processImage(image);

      final output = List.generate(1, (_) => List.filled(26, 0.0));
      _interpreter!.run(input, output);

      final List<double> prediction = List<double>.from(output[0]);
      final maxIndex = prediction.asMap().entries.reduce((a, b) => a.value > b.value ? a : b).key;

      print('Inference completed in ${stopwatch.elapsedMilliseconds}ms. Predicted: ${_labels[maxIndex]}');
      return _labels[maxIndex];
    } catch (e) {
      print('Inference failed: $e');
      return null;
    }
  }

  void dispose() {
    _interpreter?.close();
    print('Interpreter disposed');
  }
}