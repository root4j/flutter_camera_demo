import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_demo/ui/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Obten una lista de camaras disponibles y selecciona la primera para su uso.
  final camaras = await availableCameras();
  // Obtener camara principal
  final camaraPrincipal = camaras.first;
  // Correr aplicacion
  runApp(App(camera: camaraPrincipal));
}
