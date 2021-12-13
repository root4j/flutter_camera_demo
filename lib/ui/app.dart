import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/camera_controller.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/theme_controller.dart';
import 'package:flutter_camera_demo/domain/use_case/controllers/ui.dart';
import 'package:flutter_camera_demo/domain/use_case/theme_management.dart';
import 'package:flutter_camera_demo/ui/pages/home/home_page.dart';
import 'package:flutter_camera_demo/ui/theme/theme.dart';

class App extends StatefulWidget {
  final CameraDescription camera;

  const App({Key? key, required this.camera}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Dependency injection: setting up state management
  late final ThemeController controller;
  late final UIController uiController;
  late final CamController camController;
  // Theme management
  late final ThemeManager manager;
  bool isLoaded = false;

  Future<void> initializeTheme() async {
    controller.darkMode = await manager.storedTheme;
    setState(() => isLoaded = true);
  }

  @override
  void initState() {
    // Dependency injection: setting up state management
    controller = Get.put(ThemeController());
    uiController = Get.put(UIController());
    camController = Get.put(CamController(widget.camera));
    // Theme management
    manager = ThemeManager();
    ever(controller.reactiveDarkMode, (bool isDarkMode) {
      manager.changeTheme(isDarkMode: isDarkMode);
    });
    initializeTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? const CircularProgressIndicator()
        : GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: MyTheme.ligthTheme,
            darkTheme: MyTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: const HomePage(),
          );
  }
}
