import 'package:path_provider/path_provider.dart' as syspath;
import 'package:camera/camera.dart';

class ImageHelpers {
  static Future<String> captureImageCamera(
      CameraController cameraController) async {
    final String path =
        '${(await syspath.getTemporaryDirectory()).path}/${DateTime.now()}.png';
    await cameraController.takePicture(path);
    // print('ImageFilePath: $path');
    return path;
  }
}
