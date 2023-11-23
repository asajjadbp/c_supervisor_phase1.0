import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_core/widgets/custom_placeholder_image.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    Key? key,
    required this.imgUrl,
    this.width,
    this.height,
    required this.placeholderPath,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final String imgUrl;
  final String placeholderPath;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      progressIndicatorBuilder: (_, __, ___) => const LoadingView(),
      errorWidget: (_, __, ___) => CustomPlaceholderImage(
        width: width,
        height: height,
        path: placeholderPath,
      ),
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}
