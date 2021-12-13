import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/camera_controller.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CameraScreen> {
  final CamController camState = Get.find<CamController>();
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Instancia y almacena el controlador para la camara
    camState.controller =
        CameraController(camState.camera, ResolutionPreset.medium);
    _initializeControllerFuture = camState.controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    // Mientras la camara inicia muestra un spinner y luego muestra la vista previa
    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          camState.initialized = true;
          return CameraPreview(camState.controller);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    camState.controller.dispose();
    super.dispose();
  }
}
