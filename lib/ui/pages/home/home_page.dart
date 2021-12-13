import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/camera_controller.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/theme_controller.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/ui.dart';
import 'package:flutter_camera_demo/ui/pages/home/camera/camera_screen.dart';
import 'package:flutter_camera_demo/ui/pages/home/preview/preview_screen.dart';
import 'package:flutter_camera_demo/ui/widgets/appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

// View content
  Widget _getScreen(int index) {
    if (index == 0) {
      return const CameraScreen();
    }
    return const PreviewScreen();
  }

  // We create a Scaffold that is used for all the content pages
  // We only define one AppBar, and one scaffold.
  @override
  Widget build(BuildContext context) {
    // Dependency injection: State management controller
    final ThemeController themeController = Get.find<ThemeController>();
    final UIController controller = Get.find<UIController>();
    final CamController camState = Get.find<CamController>();

    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        controller: themeController,
        tile: const Text("Flutter Camera"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Obx(() => _getScreen(controller.reactiveScreenIndex.value)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Si la camara ha sido inicializada tratar de tomar una foto, si fue exitoso,
          // Pasar a la siguiente pantalla y mostrar la imagen capturada.
          if (camState.cameraInitialized) {
            try {
              final img = await camState.controller.takePicture();
              camState.path = img.path;
              controller.screenIndex = 1;
            } catch (e) {
              Get.snackbar(
                "Error",
                e.toString(),
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 10),
              );
            }
          }
        },
        child: const Icon(Icons.camera_rounded),
      ),
      // Content screen navbar
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.camera_alt_rounded,
              ),
              label: 'Cámara',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_size_select_actual_outlined,
              ),
              label: 'Ver',
            ),
          ],
          currentIndex: controller.screenIndex,
          onTap: (index) {
            controller.screenIndex = index;
          },
        ),
      ),
    );
  }
}
