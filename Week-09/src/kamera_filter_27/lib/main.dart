import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'widget/takepicture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();
  final firstCamera = cameras.isNotEmpty ? cameras.first : null;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription? camera;

  const MyApp({super.key, this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kamera + Filter Carousel',
      theme: ThemeData.dark(),
      home: camera != null
          ? TakePictureScreen(camera: camera!)
          : const Scaffold(body: Center(child: Text('No camera available'))),
      debugShowCheckedModeBanner: false,
    );
  }
}
