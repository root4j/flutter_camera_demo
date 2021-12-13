import 'package:camera/camera.dart';
import 'package:get/get.dart';

class CamController extends GetxController {
  // Observables
  final Rx<CameraDescription> _camera;
  late Rx<CameraController> _controller;

  CamController(CameraDescription camera)
      : _camera = Rx<CameraDescription>(camera);

  final _path = "".obs;
  final _initialized = false.obs;

  set controller(CameraController controller) {
    _controller = Rx<CameraController>(controller);
  }

  set path(String path) {
    _path.value = path;
  }

  set initialized(bool init) {
    _initialized.value = init;
  }

  // Reactive Getters
  RxString get reactivePath => _path;

  // Getters
  CameraDescription get camera => _camera.value;

  CameraController get controller => _controller.value;

  String get picturePath => _path.value;

  bool get cameraInitialized => _initialized.value;
}
