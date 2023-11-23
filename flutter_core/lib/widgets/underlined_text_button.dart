import 'package:flutter/material.dart';

class UnderlinedTextButton extends StatelessWidget {
  const UnderlinedTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.style,
    this.borderColor,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final TextStyle? style;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor ?? Colors.black,
            width: 1.0,
          ),
        ),
      ),
      child: InkWell(
        child: Text(
          text,
          style: style,
        ),
        onTap: () => onPressed(),
      ),
    );
  }
}