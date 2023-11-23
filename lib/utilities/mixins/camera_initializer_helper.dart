import 'package:c_supervisor/main.dart';
import 'package:camera/camera.dart';

mixin CameraInitializerMixin {
  CameraController? controller;

  initCameraView(int cameraIndex) async {
    int selectedCameraIdx = cameraIndex;
    List<CameraDescription?>? currentAvailableCameras =
        await availableCameras();
    if (currentAvailableCameras.isNotEmpty) {
      if (cameras.isNotEmpty) {
        selectedCameraIdx = cameraIndex;
        await _initCameraController(cameras[selectedCameraIdx])
            .then((void v) {});
      } else {
        print("No camera available");
      }
    } else {
      print('Error: .code\nError Message:.message');
    }
  }

  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }

    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: false,
    );

    controller!.addListener(() {
      if (controller!.value.hasError) {
        print('Camera error ${controller!.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller!.initialize();
      //init location  after image initialization
    } on CameraException catch (_) {}
  }
}
