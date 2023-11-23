import 'package:flutter/material.dart';

import 'custom_error_widget.dart';

class CustomErrorPage extends StatelessWidget {
  const CustomErrorPage({super.key, this.message, this.onRetryPressed});

  final String? message;
  final void Function()? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Image.asset(
          //     'assets/pattern.png',
          //   ),
          // ),
          SizedBox(
            width: double.infinity,
            child: CustomErrorWidget(
              message: message,
              onRetryPressed: onRetryPressed,
            ),
          ),
        ],
      ),
    );
  }
}
