import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerList extends StatelessWidget {
  const CustomShimmerList({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.itemsCount = 20,
    this.hasSliverAppBar = false,
    this.appBarHeaderHeight = 0,
  });

  final Color? baseColor;
  final Color? highlightColor;
  final int itemsCount;
  final bool hasSliverAppBar;
  final double appBarHeaderHeight;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey,
      highlightColor: highlightColor ?? Colors.grey,
      child: Column(
        children: [
          if (hasSliverAppBar)
            Container(
              height: appBarHeaderHeight,
              color: Colors.white,
            ),
          Separator.spacer(10.h),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, __) => Padding(
                padding: EdgeInsets.only(bottom: 8.0.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 48.0.w,
                      height: 48.0.h,

                      /// This color doesn't affect the design as it is overridden by [Shimmer]
                      /// widget [baseColor] also if this color is removed the container
                      /// will not be shown
                      color: Colors.white,
                    ),
                    Separator.spacer(8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 8.0.h,
                            color: Colors.white,
                          ),
                          Separator.spacer(2.h),
                          Container(
                            width: double.infinity,
                            height: 8.0.h,
                            color: Colors.white,
                          ),
                          Separator.spacer(2.h),
                          Container(
                            width: 40.0.w,
                            height: 8.0.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              itemCount: itemsCount,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        ],
      ),
    );
  }
}
