import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/camera_controller.dart';

class PreviewScreen extends StatefulWidget {
  const PreviewScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<PreviewScreen> {
  final CamController camState = Get.find<CamController>();

  @override
  Widget build(BuildContext context) {
    // Si hay una imagen disponible debes mostrarla si no mostrar un spinner
    return Center(
      child: Obx(() {
        if (camState.picturePath.isNotEmpty) {
          return Image.file(File(camState.picturePath));
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }
}
