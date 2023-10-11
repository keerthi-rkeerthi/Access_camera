import 'package:flutter/material.dart';
import 'package:camera/camera.dart'; // Import the camera package

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    home: CameraScreen(camera: firstCamera),
  ));
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({required this.camera});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium, // You can adjust the resolution as needed
    );

    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Camera Example')),
      body: CameraPreview(_controller), // Display the camera preview
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final image = await _controller.takePicture();
            // Use the captured image as needed
          } catch (e) {
            print('Error taking picture: $e');
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
