import 'dart:io';

import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/data/models/index.dart';
import 'package:c_supervisor/styles/colors.dart';
import 'package:c_supervisor/ui/bloc/upload_image_cubit.dart';
import 'package:c_supervisor/ui/common_reusable/index.dart';
import 'package:c_supervisor/ui/pages/check_in/cubit/check_in_cubit.dart';
import 'package:c_supervisor/ui/pages/check_in/widget/custom_camera_view.dart';
import 'package:c_supervisor/utilities/index.dart';
import 'package:c_supervisor/utilities/mixins/camera_initializer_helper.dart';
import 'package:c_supervisor/utilities/mixins/image_name_creation_mixin.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'package:networking/client/networking_models/index.dart';

class CheckInContent extends StatefulWidget {
  const CheckInContent({Key? key}) : super(key: key);

  @override
  State<CheckInContent> createState() => _CheckInContentState();
}

class _CheckInContentState extends State<CheckInContent>
    with
        LocationHelperMixin,
        CameraInitializerMixin,
        TickerProviderStateMixin,
        ImageNameCreatorMixin {
  // todo change it to int
  bool isLoading = false;

  TextEditingController commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  /// todo text controller
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: (controller == null || !controller!.value.isInitialized)
                  ? const Center(child: Text('Wait init camera'))
                  : AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: CustomCameraView(
                        cameraController: controller,
                        parentContext: context,
                        isLoading: isLoading,
                        commentController: commentController,
                      ),
                    )),
          Positioned(
            top: 50,
            right: 10,
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black54,
                height: 40,
                child: const Center(
                    child: Text(
                  'Check in',
                  style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.normal),
                )),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: !isLoading ? takePicture : null,
        child: !isLoading
            ? const Icon(
                Icons.camera_alt,
                color: Colors.white,
              )
            : const CircularProgressIndicator(
                color: Colors.white,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _requestPermission() async {
    await initLocationGPS();
    await getPermission();
    await initCameraView(1);
    _refreshCamera();
  }

  void _refreshCamera() async {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return;
    }
    try {
      XFile file = await cameraController.takePicture();
      AppDialog(
          title: 'Image Preview',
          confirmTitle: 'Confirm',
          cancelTitle: 'cancel',
          onConfirmClicked: () {
            Navigator.of(context).pop();
            _uploadPhotoImage(file);
          },
          onCancelClicked: () {
            Navigator.of(context).pop();
          }).showAppDialog(
          context,
          Container(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.file(
              File(file.path),
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          )));
    } on CameraException catch (_) {
      return;
    }
  }

  _uploadPhotoImage(XFile image) async {
    String finalImagePath =
        await createPhotoName(image, moduleName: "UserCheckIn");

    setState(() {
      isLoading = true;
    });

    final result = await context
        .read<UploadImageCubit>()
        .uploadImages(files: [File(finalImagePath)]);

    if (!result.hasError) {
      _getLocationLatLong(result.data?.imagePathes?[0] ?? '');
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getLocationLatLong(String photoPath) async {
    LocationData? currentLocation = await getLocationLatLong();
    if (currentLocation != null) {
      //send zero values if location null
      _addStoreCheckIn(
          photoPath, currentLocation.latitude!, currentLocation.longitude!);
    } else {
      _addStoreCheckIn(photoPath, 0.0, 0.0);
    }
  }

  _addStoreCheckIn(String photoPath, double lat, double long) async {
    context;
    final BaseResponse<EmptyModel?> result = await context
        .read<CheckInCubit>()
        .insertCheckIn(
            userCheckInModel: UserCheckInModel(
                userID: GetIt.I<AppSharedPrefsClient>()
                        .getCurrentUserInfo()
                        ?.userId ??
                    0,
                userLatitude: lat,
                userLongitude: long,
                photoPath: photoPath..replaceAll('\\', '/'),
                comment: commentController.text));

    if (result.hasError) {
    } else {
      /// home path
      GetIt.I<AppSharedPrefsClient>().updateUserCheckInStatus();
      context.go(PostAuthRoutes.mainDashboard.route.path);
    }
  }
}
