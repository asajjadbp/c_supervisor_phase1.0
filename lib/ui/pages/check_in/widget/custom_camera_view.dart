import 'package:c_supervisor/ui/common_reusable/index.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'chekin_list.dart';

class CustomCameraView extends StatefulWidget {
  CustomCameraView(
      {Key? key,
      required this.cameraController,
      required this.parentContext,
      required this.isLoading,
      required this.commentController})
      : super(key: key);
  final CameraController? cameraController;
  final BuildContext parentContext;
  final bool isLoading;
  final TextEditingController commentController;
  List<bool> isCheckedList = [];

  @override
  State<CustomCameraView> createState() => _CustomCameraViewState();
}

void _closeApp() {
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}

class _CustomCameraViewState extends State<CustomCameraView> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      !widget.isLoading
          ? AppDialog(
              title: 'Supervisor checklist',
              confirmTitle: 'Confirm',
              cancelTitle: 'cancel',
              onCancelClicked: _closeApp,
              onConfirmClicked: () {
                if (widget.isCheckedList.contains(true)) {
                  Navigator.of(context).pop();
                  AppDialog(
                      title: 'Add Comment',
                      confirmTitle: 'Confirm',
                      cancelTitle: 'cancel',
                      onConfirmClicked: () {
                        Navigator.of(context).pop();

                        /// show comment dialog
                      }).showAppDialog(
                      context,
                      CustomTextField.withDarkBorder(
                        myController: widget.commentController,
                        labelText: 'Add Comment',
                        height: 53.h,
                        maxLines: 6,
                        prefixIcon: const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                        ),
                      ));
                }

                /// show comment dialog
              }).showAppDialog(context, CheckInList((checked) {
              widget.isCheckedList = checked;
            }))
          : null;
    });

    return AspectRatio(
      aspectRatio: widget.cameraController!.value.aspectRatio,
      child: CameraPreview(widget.cameraController!),
    );
  }
}
