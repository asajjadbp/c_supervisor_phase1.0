import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class IconText extends StatelessWidget {
  const IconText({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
  }) : super(key: key);
  final Color color;
  final String title;

  final SvgPicture icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: 8.w,
        ),
        SizedBox(
          width: 120.w,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.normal, color: color),
          ),
        )
      ],
    );
  }
}
