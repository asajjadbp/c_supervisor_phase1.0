import 'dart:math';

import 'package:extended_image/extended_image.dart';

import '../index.dart';

class ImageViewOnAlert extends StatefulWidget {
  final String imagePath;
  String? baserUrl;
  final bool isExpanded;

  ImageViewOnAlert({
    Key? key,
    required this.imagePath,
    required this.isExpanded,
    this.baserUrl,
  }) : super(key: key);

  @override
  ImageViewOnAlertState createState() => ImageViewOnAlertState();
}

class ImageViewOnAlertState extends State<ImageViewOnAlert> {
  double rotationAngle = 0.0;

  void rotateImage() {
    setState(() {
      rotationAngle += 90.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Transform.rotate(
                            angle: rotationAngle * (pi / 180),
                            child: ExtendedImage.network(
                              widget.baserUrl == null
                                  ? 'https://testapi.catalist-me.com/${widget.imagePath}'
                                  : '${widget.baserUrl}${widget.imagePath}',
                              width: 200.w,
                              height: 200.h,
                              fit: BoxFit.fill,
                              cache: true,
                              loadStateChanged: (ExtendedImageState state) {
                                switch (state.extendedImageLoadState) {
                                  case LoadState.loading:
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );

                                  ///if you don't want override completed widget
                                  ///please return null or state.completedWidget
                                  //return null;
                                  //return state.completedWidget;
                                  case LoadState.completed:
                                    return ExtendedRawImage(
                                      image: state.extendedImageInfo?.image,
                                      width: 200.w,
                                      height: 200.h,
                                    );

                                  case LoadState.failed:
                                    return Image.asset(
                                      "assets/backgrounds/no_image_found.jpg",
                                      fit: BoxFit.fill,
                                      width: 200.w,
                                      height: 200.h,
                                    );
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              rotateImage();
                            });
                          },
                          child: const Icon(
                            Icons.rotate_right_sharp,
                            color: white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: const Text("Close"),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 8.0.w),
          child: Container(
            height: 150.0,
            width: widget.isExpanded ? 300.0 : 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0.r),
                child: ExtendedImage.network(
                  cacheHeight: 300,
                  cacheWidth: 300,
                  widget.baserUrl == null
                      ? 'https://testapi.catalist-me.com/${widget.imagePath}'
                      : '${widget.baserUrl}${widget.imagePath}',
                  width: 200.w,
                  height: 150.h,
                  fit: BoxFit.cover,
                  cache: true,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );

                      ///if you don't want override completed widget
                      ///please return null or state.completedWidget
                      //return null;
                      //return state.completedWidget;
                      case LoadState.completed:
                        return ExtendedRawImage(
                          image: state.extendedImageInfo?.image,
                          width: 200.w,
                          height: 200.h,
                          fit: BoxFit.cover,
                        );

                      case LoadState.failed:
                        return Image.asset(
                          "assets/backgrounds/no_image_found.jpg",
                          fit: BoxFit.cover,
                          width: 200.w,
                          height: 200.h,
                        );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
