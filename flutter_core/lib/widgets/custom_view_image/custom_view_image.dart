import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomViewImage extends StatelessWidget {
  const CustomViewImage({
    Key? key,
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
  }) : super(key: key);
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imagePath,
      initGestureConfigHandler: (state) {
        return GestureConfig(
          minScale: 0.9,
          animationMinScale: 0.7,
          maxScale: 3.0,
          animationMaxScale: 3.5,
          speed: 1.0,
          inertialSpeed: 100.0,
          initialScale: 1.0,
          inPageView: false,
        );
      },
      width: imageWidth,
      height: imageHeight,
      fit: BoxFit.cover,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case LoadState.completed:
            return FadeTransition(
              opacity: const AlwaysStoppedAnimation(1.0),
              child: ExtendedRawImage(
                image: state.extendedImageInfo?.image,
                width: imageWidth,
                height: imageWidth,
              ),
            );

          case LoadState.failed:
            return Image.asset(
              "assets/backgrounds/no_image_found.jpg",
              fit: BoxFit.fill,
            );
        }
      },
    );
  }
}
