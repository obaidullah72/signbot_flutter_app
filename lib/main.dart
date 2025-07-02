import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:sign_language_app/screens/home_screen.dart';
import 'package:sign_language_app/screens/sign_language_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  const MyApp({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Language Recognition',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(cameras: cameras),
    );
  }
}