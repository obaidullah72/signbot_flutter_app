import 'package:camera/camera.dart';

class CameraService {
  CameraController? controller;

  bool get isCameraInitialized => controller?.value.isInitialized ?? false;

  Future<void> initializeCamera(CameraDescription camera, {ResolutionPreset resolution = ResolutionPreset.low}) async {
    try {
      controller = CameraController(
        camera,
        resolution,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );
      await controller!.initialize();
      print('Camera initialized with resolution: ${controller!.value.previewSize}');
    } catch (e) {
      print('Camera initialization failed: $e');
      throw Exception('Camera initialization failed: $e');
    }
  }

  void startImageStream(Function(CameraImage) onImage) {
    if (controller == null || !controller!.value.isInitialized) {
      throw Exception('Camera not initialized');
    }
    controller!.startImageStream((image) {
      onImage(image);
    });
  }

  void dispose() {
    controller?.dispose();
  }
}