import 'package:c_supervisor/ui/common_reusable/brand_reusable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_content.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BrandReusable.withAppHeader(
      bgImage: const AssetImage(
        'assets/backgrounds/splash_bg.png',
      ),
      padding: EdgeInsets.only(top: 50.h),
      child: Padding(
        padding: EdgeInsets.only(
          left: 26.w,
          right: 26.w,
        ),
        child: LoginContent(),
      ),
    );
  }
}
