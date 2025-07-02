import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/camera.dart';
import '../services/tflite_service.dart';

class SignLanguageApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  const SignLanguageApp({Key? key, required this.cameras}) : super(key: key);

  @override
  _SignLanguageAppState createState() => _SignLanguageAppState();
}

class _SignLanguageAppState extends State<SignLanguageApp> with SingleTickerProviderStateMixin {
  final CameraService _cameraService = CameraService();
  final TFLiteService _tfliteService = TFLiteService();
  String _prediction = "Initializing...";
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _cameraReady = false;
  bool _modelReady = false;
  int _frameCount = 0;
  DateTime? _lastFrameTime;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _initializeApp();
  }

  void _setupAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  Future<void> _initializeApp() async {
    await _requestPermissions();
    await _initializeCamera();
    await _loadModel();
  }

  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.status;
    final micStatus = await Permission.microphone.status;
    final storageStatus = await Permission.storage.status;
    final manageStorageStatus = await Permission.manageExternalStorage.status;

    if (!cameraStatus.isGranted) await Permission.camera.request();
    if (!micStatus.isGranted) await Permission.microphone.request();
    if (!storageStatus.isGranted) await Permission.storage.request();
    if (!manageStorageStatus.isGranted) await Permission.manageExternalStorage.request();

    // Re-check after requesting
    final allGranted = await Permission.camera.isGranted &&
        await Permission.microphone.isGranted &&
        await Permission.storage.isGranted &&
        await Permission.manageExternalStorage.isGranted;

    if (!allGranted) {
      setState(() {
        _prediction = "Permission denied. Please enable permissions.";
      });
    }
  }

  Future<void> _initializeCamera() async {
    try {
      await _cameraService.initializeCamera(widget.cameras[0]);
      _cameraReady = true;
      _startStream();
    } catch (e) {
      setState(() {
        _prediction = "Camera Error: $e";
      });
    }
  }

  Future<void> _loadModel() async {
    try {
      await _tfliteService.loadModel(context);
      _modelReady = true;
    } catch (e) {
      setState(() {
        _prediction = "Model Load Error: $e";
      });
    }
  }

  void _startStream() {
    _cameraService.startImageStream((CameraImage image) async {
      if (!_modelReady || !_cameraReady) return;

      _frameCount++;
      if (_frameCount % 5 != 0) return;

      final now = DateTime.now();
      if (_lastFrameTime != null && now.difference(_lastFrameTime!).inMilliseconds < 100) return;

      _lastFrameTime = now;

      final result = await _tfliteService.runInference(image);
      if (result != null && mounted) {
        setState(() {
          _prediction = result;
          _animationController.forward(from: 0);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_cameraService.isCameraInitialized
          ? _buildLoadingUI()
          : Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(_cameraService.controller!),
          _buildOverlay(),
        ],
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 20),
          Text(
            _prediction,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
          ElevatedButton(
            onPressed: openAppSettings,
            child: Text("Open App Settings"),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return Stack(
      children: [
        Positioned(
          top: 40,
          left: 20,
          child: Text(
            "Sign Language Recognition",
            style: GoogleFonts.poppins(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _prediction,
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cameraService.dispose();
    _tfliteService.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
