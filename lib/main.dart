import 'package:c_supervisor/di/environment_type.dart';
import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'di/injectors/dependancy_injector.dart';

/// [cameras] hold all camera references across the app
List<CameraDescription> cameras = [];

final logger = Logger(
  printer: PrettyPrinter(
    lineLength: 90,
    methodCount: 0,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init available cameras
  cameras = await availableCameras();
  Bloc.observer = AppBlocObserver();

  await ScreenUtil.ensureScreenSize();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await DependencyInjector(
    environment: EnvironmentType.development,
  ).injectModules();

  runApp(
    /// DevicePreview to test screen to suitable with all screens size
    const MyApp(
      environmentType: EnvironmentType.development,
    ),
  );
}
