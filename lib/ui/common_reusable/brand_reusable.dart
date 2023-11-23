import 'package:c_supervisor/data/data_sources/local/index.dart';
import 'package:c_supervisor/di/environment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/utilities/index.dart';
import 'package:flutter_core/widgets/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'background_image.dart';

class BrandReusable extends StatelessWidget {
  const BrandReusable(
      {super.key,
      required this.child,
      required this.header,
      this.bgImage,
      this.padding,
      this.isWidgetStacked = false,
      this.withStackedImage = false});

  factory BrandReusable.withAppHeader(
      {required Widget child,
      required ImageProvider bgImage,
      EdgeInsetsGeometry? padding,
      bool? isWidgetStacked,
      bool? withStackedImage}) {
    final header = Center(
      child: Image.asset(
        'assets/icons/supervisor_logo.png',
        height: 250,
        width: 250,
      ),
    );
    return BrandReusable(
        header: header,
        bgImage: bgImage,
        isWidgetStacked: isWidgetStacked,
        withStackedImage: withStackedImage,
        padding: padding,
        child: child);
  }

  factory BrandReusable.withAnyHeader(
      {required Widget child,
      Widget? header,
      ImageProvider? bgImage,
      EdgeInsetsGeometry? padding,
      bool? isWidgetStacked,
      bool? withStackedImage}) {
    return BrandReusable(
      header: header,
      bgImage: bgImage,
      padding: padding,
      isWidgetStacked: isWidgetStacked,
      withStackedImage: withStackedImage,
      child: child,
    );
  }

  final Widget child;
  final Widget? header;
  final ImageProvider? bgImage;

  /// Padding for page content
  final EdgeInsetsGeometry? padding;

  final bool? isWidgetStacked;
  final bool? withStackedImage;

  @override
  Widget build(BuildContext context) {
    final defaultPadding = EdgeInsets.symmetric(
      vertical: 0.h,
      horizontal: 0.w,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          bgImage != null
              ? BackgroundImage(image: bgImage!)
              : Container(
                  color: Colors.white,
                ),
          SafeArea(
            top: false,
            child: Padding(
              padding: padding ?? defaultPadding,
              child: isWidgetStacked ?? false
                  ? Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 255.h,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/backgrounds/header_bg.png'),
                                fit: BoxFit.cover,
                              ),
                            )),
                        Column(
                          children: [
                            SizedBox(
                              height: 60.h,
                            ),
                            header ?? const Row(),
                            SizedBox(
                              height: 10.h,
                            ),
                            child,
                          ],
                        ),
                        withStackedImage ?? false
                            ? Positioned(
                                top: 160.h,
                                left: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 75.r,
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                      child: CustomCachedNetworkImage(
                                          width: 120.w,
                                          height: 120.w,
                                          imgUrl: EnvironmentType.development
                                                  .environment.baseURL +
                                              (GetIt.I<AppSharedPrefsClient>()
                                                      .getCurrentUserInfo()
                                                      ?.photoPath ??
                                                  ''),
                                          placeholderPath: '')),
                                ))
                            : const SizedBox()
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header ?? const Row(),
                          child,
                        ],
                      ),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
