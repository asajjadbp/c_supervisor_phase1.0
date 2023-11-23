import 'package:flutter/material.dart';

class CustomPlaceholderImage extends StatelessWidget {
  const CustomPlaceholderImage({
    Key? key,
    required this.width,
    required this.height,
    required this.path,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/backgrounds/no_image_found.jpg',
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
